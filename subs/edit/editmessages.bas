sub EditMessages()

 dim select_bank as BlueMenu
 dim select_message as BlueMenu
 dim select_map as BlueMenu
 dim select_item as BlueMenu
 dim total_messages as UInteger
 dim small_text as BlueTextInput
 dim enter_message as BlueMessageInput
 dim blank as Any ptr
 dim done as Boolean
 dim key as UInteger
 dim old as UInteger
 
 blank = ImageCreate(640, 480, RGB(0, 0, 0))
 
 select_bank.AddOption(FF4Text("Bank 1"))
 select_bank.AddOption(FF4Text("Bank 2"))
 select_bank.AddOption(FF4Text("Bank 3"))
 select_bank.AddOption(FF4Text("Battle"))
 select_bank.AddOption(FF4Text("Alerts"))
 select_bank.AddOption(FF4Text("Statuses"))
 select_bank.AddOption(FF4Text("Items"))
 select_bank.columns = select_bank.options.Length()
 
 select_map.y = 3
 select_map.max_rows = 8
 for i as Integer = 1 to total_maps
  select_map.AddOption(Pad(map_names.ItemAt(i), screen_width - 2))
 next
 
 select_item = BlueMenu(0, 3)
 select_item.max_rows = screen_height - 3
 for i as Integer = 1 to total_items
  select_item.AddOption(item_names.ItemAt(i))
 next

 do
 
  put (0, 0), blank, pset
  select_bank.UserSelect()
  
  if not select_bank.cancelled then
  
   select_bank.Display()
   select case select_bank.selected

    case 1 'Bank 1
     select_message = BlueMenu(0, 3)
     select_message.max_rows = screen_height - 3
     for i as Integer = 1 to total_dialogues_bank1
      select_message.AddOption(FF4Text("Message " + Pad(str(i), 3, true)))
     next
     do
      do
       put ((select_message.options.Width() + 2) * 8, 3 * 8), blank, pset
       DisplayDialogue(screen_width - 28, 3, dialogues_bank1.ItemAt(select_message.selected), 9,,, true)
      loop until select_message.UserInput()
      if not select_message.cancelled then
       enter_message = BlueMessageInput(select_message.options.Width() + 2, select_message.y, dialogues_bank1.ItemAt(select_message.selected))
       enter_message.UserType()
       dialogues_bank1.Assign(select_message.selected, enter_message.Message())
      end if
     loop until select_message.cancelled

    case 2 'Bank 2
     do
      put (0 * 8, select_map.y * 8), blank, pset
      select_map.UserSelect()
      if not select_map.cancelled then
       select_map.Display()
       select_map.ShowCursor()
       select_message = BlueMenu(0, 13)
       select_message.swap_enabled = true
       select_message.max_rows = screen_height - 13
       for i as Integer = 1 to maps(select_map.selected).dialogues.Length()
        select_message.AddOption(FF4Text("Message " + Pad(str(i), 2, true)))
       next
       do
        done = false
        do
         put ((select_message.options.Width() + 2) * 8, 13 * 8), blank, pset
         DisplayDialogue(screen_width - 28, 13, maps(select_map.selected).dialogues.ItemAt(select_message.selected), 7,,, true)
         select_message.Display()
         select_message.ShowCursor()
         key = getkey
         select case key
          case INSERT_KEY
           maps(select_map.selected).dialogues.Insert(select_message.selected, chr(&h55))
           old = select_message.selected
           select_message.ClearAll()
           for i as Integer = 1 to maps(select_map.selected).dialogues.Length()
            select_message.AddOption(FF4Text("Message " + Pad(str(i), 2, true)))
           next
           select_message.ChangeSelected(old)
          case DELETE_KEY
           if maps(select_map.selected).dialogues.Length() > 1 then
            maps(select_map.selected).dialogues.Remove(select_message.selected)
            old = select_message.selected
            select_message.ClearAll()
            for i as Integer = 1 to maps(select_map.selected).dialogues.Length()
             select_message.AddOption(FF4Text("Message " + Pad(str(i), 2, true)))
            next
            select_message.ChangeSelected(old)
           end if
          case else
           done = select_message.ProcessKey(key)
         end select
        loop until done
        if not select_message.cancelled then
         if select_message.highlighted > 0 then
          maps(select_map.selected).dialogues.Exchange(select_message.highlighted, select_message.selected)
          select_message.highlighted = 0
         else
          enter_message = BlueMessageInput(select_message.options.Width() + 2, select_message.y, maps(select_map.selected).dialogues.ItemAt(select_message.selected))
          enter_message.h = 42
          enter_message.UserType()
          maps(select_map.selected).dialogues.Assign(select_message.selected, enter_message.Message())
         end if
        end if
       loop until select_message.cancelled
      end if
     loop until select_map.cancelled

    case 3 'Bank 3
     select_message = BlueMenu(0, 3)
     select_message.max_rows = screen_height - 3
     for i as Integer = 1 to total_dialogues_bank3
      select_message.AddOption(FF4Text("Message " + Pad(str(i), 3, true)))
     next
     do
      do
       put ((select_message.options.Width() + 2) * 8, 3 * 8), blank, pset
       DisplayDialogue(screen_width - 28, 3, dialogues_bank3.ItemAt(select_message.selected), 9,,, true)
      loop until select_message.UserInput()
      if not select_message.cancelled then
       enter_message = BlueMessageInput(select_message.options.Width() + 2, select_message.y, dialogues_bank3.ItemAt(select_message.selected))
       enter_message.UserType()
       dialogues_bank3.Assign(select_message.selected, enter_message.Message())
      end if
     loop until select_message.cancelled

    case 4 'Battle
     select_message = BlueMenu(0, 3)
     select_message.max_rows = screen_height - 3
     for i as Integer = 1 to total_dialogues_battle
      select_message.AddOption(FF4Text("Message " + Pad(str(i), 3, true)))
     next
     small_text.y = 3
     small_text.x = select_message.options.Width() + 2
     small_text.text_width = 24
     small_text.cursor = true
     small_text.extended = true
     do
      do
       small_text.starting_text = dialogues_battle.ItemAt(select_message.selected) 'FromDTE(dialogues_battle.ItemAt(select_message.selected))
       small_text.text = small_text.starting_text
       small_text.Display()
      loop until select_message.UserInput()
      if not select_message.cancelled then
       small_text.UserType()
       dialogues_battle.Assign(select_message.selected, small_text.text)
      end if
     loop until select_message.cancelled     

    case 5 'Alerts
     select_message = BlueMenu(0, 3)
     select_message.max_rows = screen_height - 3
     for i as Integer = 1 to total_dialogues_alerts
      select_message.AddOption(FF4Text("Message " + Pad(str(i), 3, true)))
     next
     small_text.y = 3
     small_text.x = select_message.options.Width() + 2
     small_text.text_width = 24
     small_text.cursor = true
     small_text.extended = true
     do
      do
       small_text.starting_text = dialogues_alerts.ItemAt(select_message.selected)
       small_text.text = small_text.starting_text
       small_text.Display()
      loop until select_message.UserInput()
      if not select_message.cancelled then
       small_text.UserType()
       dialogues_alerts.Assign(select_message.selected, small_text.text)
      end if
     loop until select_message.cancelled

    case 6 'Statuses
     select_message = BlueMenu(0, 3)
     for i as Integer = 1 to 4
      for j as Integer = 8 to 1 step -1
       select_message.AddOption(element_names.ItemAt(i * 8 + j))
      next
     next
     small_text.y = 3
     small_text.x = select_message.options.Width() + 2
     small_text.text_width = 8
     small_text.cursor = true
     do
      do
       small_text.starting_text = dialogues_status.ItemAt(select_message.selected)
       small_text.text = small_text.starting_text
       small_text.Display()
      loop until select_message.UserInput()
      if not select_message.cancelled then
       small_text.UserType()
       dialogues_status.Assign(select_message.selected, small_text.text)
      end if
     loop until select_message.cancelled
     
    case 7 'Items
     select_message = BlueMenu(0, 3)
     select_message.max_rows = screen_height - 3
     for i as Integer = 1 to total_descriptions
      select_message.AddOption(FF4Text("Description " + Pad(str(i), 2, true)))
     next
     small_text.y = 3
     small_text.x = select_message.options.Width() + 2
     small_text.text_width = 19
     small_text.cursor = true
     do
      do
       small_text.starting_text = item_descriptions.ItemAt(select_message.selected)
       small_text.text = small_text.starting_text
       small_text.Display()
      loop until select_message.UserInput()
      if not select_message.cancelled then
       small_text.UserType()
       item_descriptions.Assign(select_message.selected, small_text.text)
      end if
     loop until select_message.cancelled

   end select
   

  end if
  
 loop until select_bank.cancelled
 
 ImageDestroy(blank)

end sub
