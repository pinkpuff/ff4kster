constructor EventMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 edit_event = BlueMenu(x, y)
 edit_event.swap_enabled = true
 edit_event.max_rows = 9
 edit_else = BlueMenu(x, y + edit_event.max_rows + 2)
 edit_else.swap_enabled = true
 edit_else.max_rows = 5
 edit_entry = ScriptEntryMenu(x, edit_else.y + edit_else.max_rows + 2)
 blank = ImageCreate(640, 480, RGB(0, 0, 0))
 really_clear_event = BlueMenu(edit_entry.x, edit_entry.y + 3)
 really_clear_event.AddOption(FF4Text("No"))
 really_clear_event.AddOption(FF4Text("Yes"))

end constructor


sub EventMenu.Display()

 edit_event.Display()
 if events(index).else_script.Length() > 0 then
  edit_else.Display()
 else
  put (edit_else.x * 8, edit_else.y * 8), blank, pset
 end if

end sub


sub EventMenu.SetTo(new_index as Integer)

 dim actual_map as UInteger
 dim temp as String
 
 index = new_index
 edit_event.ClearAll()
 edit_else.ClearAll()
 actual_maps.Destroy()
 actual_maps_else.Destroy()
 actual_map = events(index).map_link
 for i as Integer = 1 to events(index).script.Length()
  temp = events(index).script.ItemAt(i)
  edit_event.AddOption(events(index).ScriptEntry(temp, actual_map))
  if asc(left(temp, 1)) = &hFE then
   actual_map = asc(mid(temp, 2)) + 1
   if asc(mid(temp, 5)) and &h80 then actual_map += &h100
  end if
  actual_maps.Append(str(actual_map))
 next
 actual_map = events(index).map_link
 for i as Integer = 1 to events(index).else_script.Length()
  temp = events(index).else_script.ItemAt(i)
  edit_else.AddOption(events(index).ScriptEntry(temp, actual_map))
  if asc(left(temp, 1)) = &hFE then
   actual_map = asc(mid(temp, 2)) + 1
   if asc(mid(temp, 5)) and &h80 then actual_map += &h100
  end if
  actual_maps_else.Append(str(actual_map))
 next
 Display()

end sub


sub EventMenu.UserSelect()

 dim done as Boolean
 dim a as UInteger
 dim current_menu as BlueMenu ptr
 dim current_script as List ptr
 dim found_yesnobox as Boolean
 dim temp as UInteger
 
 current_menu = @edit_event
 current_script = @events(index).script

 edit_entry.map_link = events(index).map_link

 do
 
  done = false
  do until done
  
   SetTo(index)
   current_menu->Display()
   current_menu->ShowCursor()
   
   if current_menu = @edit_event then
    temp = val(actual_maps.ItemAt(current_menu->selected))
   else
    temp = val(actual_maps_else.ItemAt(current_menu->selected))
   end if
   edit_entry.SetTo(current_script->ItemAt(current_menu->selected), temp)
   if current_menu->selected < current_menu->options.Length() then
    edit_entry.Display()
   else
    put (edit_entry.x * 8, edit_entry.y * 8), blank, pset
   end if
   
   a = getkey
   select case a
   
    case TAB_KEY
     if edit_else.options.Length() > 0 then
      current_menu->Display()
      if current_menu = @edit_event then 
       current_menu = @edit_else 
       current_script = @events(index).else_script
      else
       current_menu = @edit_event
       current_script = @events(index).script
      end if
     end if
   
    case DELETE_KEY
     if current_menu->selected < current_menu->options.Length() then
      current_menu->Remove(current_menu->selected)
      current_script->Remove(current_menu->selected)
      found_yesnobox = false
      for i as Integer = 1 to events(index).script.Length()
       if left(events(index).script.ItemAt(i), 1) = chr(&hF8) then
        found_yesnobox = true
        exit for
       end if
      next
      if not found_yesnobox then 
       events(index).else_script.Destroy()
       edit_else.ClearAll()
       put (edit_else.x * 8, edit_else.y * 8), blank, pset
      end if
     end if
     
    case INSERT_KEY
     current_script->Insert(current_menu->selected, chr(0))
     current_menu->options.Insert(current_menu->selected, "")
     current_menu->colors.Insert(current_menu->selected, "15")
     edit_entry.SetTo(current_script->ItemAt(current_menu->selected), temp)
     Display()
     done = true
     
    case BACKSPACE_KEY
     put (edit_entry.x * 8, edit_entry.y * 8), blank, pset
     BlueBox(edit_entry.x, edit_entry.y, 33, 1)
     WriteText(FF4Text("Really erase entire event script?"), edit_entry.x + 1, edit_entry.y + 1)
     really_clear_event.ChangeSelected(1)
     really_clear_event.UserSelect()
     if not really_clear_event.cancelled and really_clear_event.selected = 2 then
      current_script->Destroy()
      current_script->Append(chr(&hFF))
      current_menu->options.Destroy()
      current_menu->AddOption(events(index).ScriptEntry(current_script->ItemAt(1)))
      current_menu->ChangeSelected(1)
     end if
   
    case else
     done = current_menu->ProcessKey(a)
   
   end select
  
  loop

  if not current_menu->cancelled then
   if current_menu->selected < current_menu->options.Length() then 
    if current_menu->highlighted > 0 then
     current_script->Exchange(current_menu->highlighted, current_menu->selected)
     current_menu->options.Exchange(current_menu->highlighted, current_menu->selected)
     current_menu->highlighted = 0
    else
     edit_entry.UserSelect()
     current_script->Assign(current_menu->selected, edit_entry.Entry())
     current_menu->ChangeOption(current_menu->selected, events(index).ScriptEntry(current_script->ItemAt(current_menu->selected)), 15)
    end if
   end if
  end if

  found_yesnobox = false
  for i as Integer = 1 to events(index).script.Length()
   if left(events(index).script.ItemAt(i), 1) = chr(&hF8) then
    found_yesnobox = true
    exit for
   end if
  next
  if not found_yesnobox then 
   events(index).else_script.Destroy()
   edit_else.ClearAll()
   put (edit_else.x * 8, edit_else.y * 8), blank, pset
  else
   if events(index).else_script.Length() = 0 then 
    events(index).else_script.Append(chr(&hFF))
    edit_else.AddOption(events(index).ScriptEntry(events(index).else_script.ItemAt(1)))
   end if
   edit_else.Display()
  end if
  
 loop until current_menu->cancelled

 current_menu->cancelled = false

end sub
