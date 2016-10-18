sub EditMaps()

 dim select_map as BlueMenu
 dim edit_map as MapEditorMenu
 dim underground as Integer
 dim done as Boolean
 dim key as String
 dim keycode as UInteger
 'dim spaceused as UInteger
 dim m as MapGrid ptr
 dim really as BlueMenu
 dim blank as Any ptr
  
 select_map.swap_enabled = true
 select_map.max_rows = 8
 for i as Integer = 1 to total_maps
  select_map.AddOption(Pad(map_names.ItemAt(i), screen_width - 2,, FF4Text(" ")))
 next
 
 edit_map = MapEditorMenu(0, 10)
 
 really.x = 18
 really.y = 50
 really.AddOption(FF4Text("Yes"))
 really.AddOption(FF4Text("No"))
  
 do 
 
  do
   if select_map.selected > &h100 then underground = &h100 else underground = 0
   edit_map.SetTo(select_map.selected)
   edit_map.Display()
   select_map.Display()
   select_map.ShowCursor()
   do
    key = inkey
    keycode = asc(right(key, 1))
    if len(key) > 1 then keycode = keycode * &h100 + 255
    select case keycode
     case BACKSPACE_KEY
      if not mapgrids(maps(select_map.selected).grid_index + underground + 1).no_data then
       BlueBox(18, 47, 29, 1)
       WriteText(FF4Text("Really erase this map's data?"), 19, 48, 15)
       really.ChangeSelected(2)
       really.UserSelect()
       if not really.cancelled and really.selected = 1 then
        mapgrids(maps(select_map.selected).grid_index + underground + 1).no_data = true
       end if
       blank = ImageCreate(31 * 8, 3 * 8, RGB(0, 0, 0))
       put (18 * 8, 47 * 8), blank, pset
       ImageDestroy(blank)
      end if
    end select
    edit_map.map_menu.Animate()
    edit_map.palette_menu.Animate()
   loop while key = ""
   done = select_map.ProcessKey(keycode)
  loop until done
  
  if not select_map.cancelled then
  
   if select_map.highlighted > 0 then
   
    swap maps(select_map.selected), maps(select_map.highlighted)
    swap maps(select_map.selected).grid_index, maps(select_map.highlighted).grid_index
    select_map.highlighted = 0
   
   elseif mapgrids(maps(select_map.selected).grid_index + underground + 1).no_data then
   
    BlueBox(18, 47, 23, 1)
    WriteText(FF4Text("Really create map data?"), 19, 48, 15)
    really.ChangeSelected(2)
    really.UserSelect()
    if not really.cancelled and really.selected = 1 then
     mapgrids(maps(select_map.selected).grid_index + underground + 1).no_data = false
    end if
    blank = ImageCreate(25 * 8, 3 * 8, RGB(0, 0, 0))
    put (18 * 8, 47 * 8), blank, pset
    ImageDestroy(blank)
   
   else
    
    edit_map.UserSelect()
    if edit_map.map_menu.Columns() > 0 then
     if select_map.selected >= &h100 then underground = &h100 else underground = 0
     'm = mapgrids.PointerAt(maps(select_map.selected).grid_index + underground + 1)
     for i as Integer = 0 to 31
      for j as Integer = 0 to 31
       mapgrids(maps(select_map.selected).grid_index + underground + 1).tiles(i, j) = val("&h" + edit_map.map_menu.options.ItemAt(i + 1, j + 1))
      next
     next
    end if
    
   end if
  
  end if
  
 loop until select_map.cancelled

end sub
