sub EditEvents()

 dim select_event as BlueMenu
 dim edit_event as EventMenu
 dim preview_menu as BlueMenu
 dim box_y as UByte
 dim a as UInteger
 dim done as Boolean
 
 select_event.y = 3
 select_event.swap_enabled = true
 select_event.max_rows = 4
 for i as Integer = 1 to total_events
  select_event.AddOption(Pad(event_names.ItemAt(i), 78, false, FF4Text(" ")))
 next
 
 edit_event = EventMenu(0, select_event.y + 6)
 
 'preview_menu = BlueMenu(0, select_event.max_rows + 2 + edit_event.edit_event.max_rows + 2 + edit_event.edit_else.max_rows + 2)
 preview_menu.max_rows = 1
 for i as Integer = 1 to total_maps
  preview_menu.AddOption(FF4Text("Preview as: ") + map_names.ItemAt(i))
 next
 
 do until select_event.cancelled
 
  do
   edit_event.SetTo(select_event.selected)
   preview_menu.ChangeSelected(events(select_event.selected).map_link)
   preview_menu.Display()
   select_event.Display()
   select_event.ShowCursor()
   a = getkey
   select case a
    case TAB_KEY
     preview_menu.UserSelect()
     if not preview_menu.cancelled then events(select_event.selected).map_link = preview_menu.selected
     done = false
    case ENTER_KEY
     done = select_event.ProcessKey(a)
    case INSERT_KEY
     if select_event.highlighted > 0 then
      events(select_event.selected).script.Remove(events(select_event.selected).script.Length())
      events(select_event.selected).script.Join(events(select_event.highlighted).script)
      if events(select_event.selected).else_script.Length() > 0 then
       events(select_event.selected).else_script.Remove(events(select_event.selected).else_script.Length())
      end if
      events(select_event.selected).else_script.Join(events(select_event.highlighted).else_script)
      select_event.highlighted = 0
     end if
     done = false
    case else
     done = select_event.ProcessKey(a)
     edit_event.edit_event.ChangeSelected(1)
     edit_event.edit_else.ChangeSelected(1)
   end select
  loop until done
  
  if not select_event.cancelled then
   if select_event.highlighted > 0 then
    swap events(select_event.highlighted), events(select_event.selected)
    select_event.highlighted = 0
   else
    preview_menu.Display()
    edit_event.UserSelect()
   end if
  end if
 
 loop

end sub
