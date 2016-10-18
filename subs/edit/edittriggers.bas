sub EditTriggers()

 dim select_map as BlueMenu
 dim select_trigger as BlueMenu
 dim edit_trigger as TriggerInfoMenu
 dim t as Trigger ptr
 dim blank as any ptr
 dim done as Boolean
 dim a as UInteger
 
 blank = ImageCreate(640, 480, RGB(0, 0, 0))
 
 for i as Integer = 1 to total_maps
  select_map.AddOption(Pad(map_names.ItemAt(i), screen_width - 2, , FF4Text(" ")))
 next
 select_map.max_rows = 8
 
 select_trigger = BlueMenu(0, 10)
 select_trigger.swap_enabled = true
 select_trigger.max_rows = screen_height - select_map.max_rows - 2
 edit_trigger = TriggerInfoMenu(12, 10)
 
 do
  
  do
   select_trigger.ClearAll()
   for i as Integer = 1 to maps(select_map.selected).triggers.Length()
    select_trigger.AddOption(FF4Text("Trigger " + Pad(str(i), 2)))
   next
   if select_trigger.options.Length() = 0 then select_trigger.AddOption(FF4Text("-- None --"))
   select_trigger.ChangeSelected(1)
   put (0, 10 * 8), blank, pset
   select_trigger.Display()
  loop until select_map.UserInput()
  
  if not select_map.cancelled then
   
   do
   
    done = false
    do
    
     put (12 * 8, 10 * 8), blank, pset
     if maps(select_map.selected).triggers.Length() > 0 then
      t = maps(select_map.selected).triggers.PointerAt(select_trigger.selected)
      edit_trigger.t = t
      edit_trigger.m = select_map.selected
      if select_map.selected > &h100 or select_map.selected = 253 or select_map.selected = 254 then
       edit_trigger.underworld = true
      else
       edit_trigger.underworld = false
      end if
      edit_trigger.Display()
     end if
     select_trigger.Display()
     select_trigger.ShowCursor()
     a = getkey
    
     select case a
    
      case DELETE_KEY
       if select_map.selected < 252 or select_map.selected > 254 then
        if maps(select_map.selected).triggers.Length() > 0 then
         maps(select_map.selected).triggers.Remove(select_trigger.selected)
         total_triggers -= 1
         'select_trigger.Remove(select_trigger.selected)
         select_trigger.ClearAll()
         for i as Integer = 1 to maps(select_map.selected).triggers.Length()
          select_trigger.AddOption(FF4Text("Trigger " + Pad(str(i), 2)))
         next
         if select_trigger.options.Length() = 0 then select_trigger.AddOption(FF4Text("-- None --"))
         if select_trigger.selected > select_trigger.options.Length() then select_trigger.ChangeSelected(select_trigger.options.Length())
         select_trigger.Display()
        end if
       else
        if maps(select_map.selected).triggers.Length() > 0 then
         maps(select_map.selected).triggers.Remove(select_trigger.selected)
         'select_trigger.Remove(select_trigger.selected)
         select_trigger.ClearAll()
         for i as Integer = 1 to maps(select_map.selected).triggers.Length()
          select_trigger.AddOption(FF4Text("Trigger " + Pad(str(i), 2)))
         next
         if select_trigger.options.Length() = 0 then select_trigger.AddOption(FF4Text("-- None --"))
         if select_trigger.selected > select_trigger.options.Length() then select_trigger.ChangeSelected(select_trigger.options.Length())
         select_trigger.Display()
        end if
       end if
       
      case INSERT_KEY
       if select_map.selected < 252 or select_map.selected > 254 then
        if total_triggers < max_triggers then
         t = callocate(SizeOf(Trigger))
         maps(select_map.selected).triggers.Insert(select_trigger.selected, t)
         total_triggers += 1
         select_trigger.ClearAll()
         for i as Integer = 1 to maps(select_map.selected).triggers.Length()
          select_trigger.AddOption(FF4Text("Trigger " + Pad(str(i), 2)))
         next
         select_trigger.Display()
        end if
       else
        if maps(252).triggers.Length() + maps(253).triggers.Length() + maps(254).triggers.Length() < max_overworld_triggers then
         t = callocate(SizeOf(Trigger))
         maps(select_map.selected).triggers.Insert(select_trigger.selected, t)
         total_triggers += 1
         select_trigger.ClearAll()
         for i as Integer = 1 to maps(select_map.selected).triggers.Length()
          select_trigger.AddOption(FF4Text("Trigger " + Pad(str(i), 2)))
         next
         select_trigger.Display()
        end if
       end if
       
      case else
       done = select_trigger.ProcessKey(a)
    
     end select
    
    loop until done
    
    if not select_trigger.cancelled then
     if select_trigger.highlighted = 0 then
      if maps(select_map.selected).triggers.Length() > 0 then 
       edit_trigger.UserSelect()
      end if
     else
      maps(select_map.selected).triggers.Exchange(select_trigger.selected, select_trigger.highlighted)
      select_trigger.highlighted = 0
     end if
    end if
   
   loop until select_trigger.cancelled   
   
  end if
 
 loop until select_map.cancelled
 
 dim treasures as UByte = 0
 dim ot as UByte = 0

 for i as Integer = 1 to total_maps - 1
  if i = 257 then treasures = 0
  maps(i).treasure_index = treasures
  ot = treasures
  for j as Integer = 1 to maps(i).triggers.Length()
   t = maps(i).triggers.PointerAt(j)
   if t->treasure then treasures += 1
  next
 next

end sub
