constructor EventCallMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 call_menu = BlueMenu(x, y)
 condition_menu = BlueMenu(x, y)

end constructor


sub EventCallMenu.Display()

 dim c as CallComponent ptr
 
 call_menu.ClearAll()
 for i as Integer = 1 to e->components.Length()
  c = e->components.PointerAt(i)
  if c->event_reference = 0 then
   call_menu.AddOption(FF4Text(Pad("-- No Event --", event_names.Width())))
  else
   call_menu.AddOption(Pad(event_names.ItemAt(c->event_reference), event_names.Width(), , FF4Text(" ")))
  end if
 next
 if call_menu.options.Length() = 0 then
  call_menu.AddOption(FF4Text("-- EMPTY --"))
 end if
 
 data_menu = BlueMenu(x, y + call_menu.options.Length() + 2)
 for i as Integer = 1 to e->parameters.Length()
  data_menu.AddOption(FF4Text("Message " + Pad(str(asc(e->parameters.ItemAt(i)) + 1), 2, true)))
 next
 if data_menu.options.Length() = 0 then 
  data_menu.AddOption(FF4Text("-- No messages --"))
 end if
 
 call_menu.Display()
 data_menu.Display()

end sub


sub EventCallMenu.SetTo(p as EventCall ptr, associated_map as Integer)

 e = p
 m = associated_map

end sub


sub EventCallMenu.UpdateConditionMenu(index as UByte)

 dim c as CallComponent ptr

 condition_menu.y = call_menu.y + 2 + call_menu.options.Length()
 if data_menu.options.Length() > 0 then condition_menu.y += data_menu.options.Length() + 2
 condition_menu.ClearAll()
 c = e->components.PointerAt(index)
 for i as Integer = 1 to c->true_conditions.Length()
  condition_menu.AddOption(Pad(flag_names.ItemAt(asc(c->true_conditions.ItemAt(i)) + 1), flag_names.Width(),, FF4Text(" ")) + FF4Text(": ON "))
 next
 for i as Integer = 1 to c->false_conditions.Length()
  condition_menu.AddOption(Pad(flag_names.ItemAt(asc(c->false_conditions.ItemAt(i)) + 1), flag_names.Width(),, FF4Text(" ")) + FF4Text(": OFF"))
 next
 if condition_menu.options.Length() = 0 then condition_menu.AddOption(FF4Text(Pad("-- Always -- ", flag_names.Width() + 5)))

end sub


sub EventCallMenu.UserSelect()

 dim done as Boolean
 dim mode as String
 dim a as UInteger
 dim blank as Any ptr
 dim c as CallComponent ptr
 dim event_menu as BlueMenu
 dim flag_menu as BlueMenu
 dim flag_setting as BlueMenu
 dim message_input as BlueNumberInput
 
 call_menu.ChangeSelected(1)
 data_menu.ChangeSelected(1)
 condition_menu.ChangeSelected(1)
 
 event_menu = BlueMenu(x, y)
 event_menu.max_rows = 1
 event_menu.AddOption(FF4Text("-- No Event --"))
 for i as Integer = 1 to total_events
  event_menu.AddOption(event_names.ItemAt(i))
 next
 
 flag_menu = BlueMenu(x, y)
 flag_menu.max_rows = 1
 for i as Integer = 1 to 256
  flag_menu.AddOption(flag_names.ItemAt(i))
 next
 
 flag_setting = BlueMenu(x + flag_names.Width() + 2, y)
 flag_setting.max_rows = 1
 flag_setting.AddOption(FF4Text("ON "))
 flag_setting.AddOption(FF4Text("OFF"))
 
 message_input.x = data_menu.x + 8
 message_input.max_value = &hFF
 
 blank = ImageCreate(640, 480, RGB(0, 0, 0))
 mode = "call"
 
 do

  if mode = "call" then

   call_menu.Hide()
   data_menu.Hide()
   condition_menu.Hide()
   if e->components.Length() > 0 then
    UpdateConditionMenu(call_menu.selected)
    condition_menu.Display()
   end if
   'data_menu.Display()
   'call_menu.Display()
   Display()
   call_menu.ShowCursor()
   a = getkey

   select case a

    case TAB_KEY
     if e->components.Length() > 0 then
      mode = "data"
      call_menu.Display()
      c = e->components.PointerAt(call_menu.selected)
     end if

    case ENTER_KEY
     if e->components.Length() > 0 then
      c = e->components.PointerAt(call_menu.selected)
     else
      c = callocate(SizeOf(CallComponent))
      e->components.Append(c)
     end if
     event_menu.ChangeSelected(c->event_reference + 1)
     event_menu.y = call_menu.selected + call_menu.y - 1
     event_menu.UserSelect()
     if not event_menu.cancelled then c->event_reference = event_menu.selected - 1
     Display()
     
    case DELETE_KEY
     call_menu.Hide()
     if e->components.Length() > 1 then
      e->components.Remove(call_menu.selected)
     else
      c = e->components.PointerAt(call_menu.selected)
      c->event_reference = 0
      c->true_conditions.Destroy()
      c->false_conditions.Destroy()
     end if
     Display()
     if call_menu.selected > call_menu.options.Length() then call_menu.ChangeSelected(call_menu.options.Length())
     
    case INSERT_KEY
     c = callocate(SizeOf(CallComponent))
     e->components.Insert(call_menu.selected, c)
     Display()

    case else
     done = call_menu.ProcessKey(a)

   end select
   
  elseif mode = "data" then
  
   data_menu.Hide()
   condition_menu.Hide()
   if data_menu.selected <= e->parameters.Length() then
    DisplayDialogue(screen_width - 28, data_menu.y, maps(m).dialogues.ItemAt(asc(e->parameters.ItemAt(data_menu.selected)) + 1), 5)
   end if
   'data_menu.Display()
   Display()
   data_menu.ShowCursor()
   condition_menu.Display()
   a = getkey
   
   select case a
   
    case TAB_KEY
     mode = "condition"
     put ((screen_width - 28) * 8, data_menu.y * 8), blank, pset
     data_menu.Display()
     
    case ENTER_KEY
     if e->parameters.Length() > 0 then
      message_input.y = data_menu.y + data_menu.selected - 1
      message_input.max_value = maps(m).dialogues.Length() - 1
      message_input.starting_number = asc(e->parameters.ItemAt(data_menu.selected))
      message_input.number = message_input.starting_number
      do
       data_menu.Hide()
       DisplayDialogue(screen_width - 28, data_menu.y, maps(m).dialogues.ItemAt(message_input.number + 1), 5)
      loop until message_input.UserInput()
      e->parameters.Assign(data_menu.selected, chr(message_input.number))
      data_menu.ChangeOption(data_menu.selected, FF4Text("Message " + Pad(str(asc(e->parameters.ItemAt(data_menu.selected))), 2, true)))
      'Display()
      'condition_menu.Display()
     end if
     
    case INSERT_KEY
     data_menu.Hide()
     condition_menu.Hide()
     if e->parameters.Length() < 3 then
      if e->parameters.Length() > 0 then condition_menu.y += 1
      e->parameters.Append(chr(0))
      'put (x * 8, y * 8), blank, pset
     end if
     Display()
     condition_menu.Display()
     
    case DELETE_KEY
     data_menu.Hide()
     condition_menu.Hide()
     if e->parameters.Length() > 0 then
      if e->parameters.Length() > 1 then condition_menu.y -= 1
      e->parameters.Remove(data_menu.selected)
      'put (x * 8, y * 8), blank, pset
     end if
     Display()
     condition_menu.Display()
   
    case else
     done = data_menu.ProcessKey(a)

   end select

  else

   condition_menu.Display()
   condition_menu.ShowCursor()
   a = getkey

   select case a

    case TAB_KEY
     mode = "call"

    case ENTER_KEY
     flag_menu.y = condition_menu.y + condition_menu.selected - 1
     if condition_menu.selected <= c->true_conditions.Length() then
      flag_menu.ChangeSelected(asc(c->true_conditions.ItemAt(condition_menu.selected)) + 1)
     else
      flag_menu.ChangeSelected(asc(c->false_conditions.ItemAt(condition_menu.selected - c->true_conditions.Length())) + 1)
     end if
     flag_menu.UserSelect()
     if not flag_menu.cancelled then
      flag_menu.Display()
      flag_setting.y = flag_menu.y
      flag_setting.UserSelect()
      if not flag_setting.cancelled then
       if condition_menu.selected <= c->true_conditions.Length() then
        c->true_conditions.Remove(condition_menu.selected)
       else
        c->false_conditions.Remove(condition_menu.selected - c->true_conditions.Length())
       end if
       if flag_setting.selected = 1 then
        c->true_conditions.Append(chr(flag_menu.selected - 1))
       else
        c->false_conditions.Append(chr(flag_menu.selected - 1))
       end if
      end if
      UpdateConditionMenu(call_menu.selected)
     end if
     
    case DELETE_KEY
     condition_menu.Hide()
     if condition_menu.selected <= c->true_conditions.Length() then
      c->true_conditions.Remove(condition_menu.selected)
     else
      c->false_conditions.Remove(condition_menu.selected - c->true_conditions.Length())
     end if
     UpdateConditionMenu(call_menu.selected)
     if condition_menu.selected > condition_menu.options.Length() then condition_menu.ChangeSelected(condition_menu.options.Length())
     
    case INSERT_KEY
     c->false_conditions.Append(chr(0))
     UpdateConditionMenu(call_menu.selected)

    case else
     done = condition_menu.ProcessKey(a)

   end select

  end if

 loop until done
 
 condition_menu.Hide()
 data_menu.Hide()
 
end sub
