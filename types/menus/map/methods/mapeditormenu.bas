constructor MapEditorMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 palette_menu.x = x
 palette_menu.y = y
 for i as Integer = 0 to 7
  for j as Integer = 0 to 15
   palette_menu.options.Assign(i + 1, j + 1, hex(j \ 2) + hex((j mod 2) * 8 + i))
  next
 next
 map_menu.x = x + 18
 map_menu.y = y 
 map_menu.max_columns = 16
 map_menu.max_rows = 16

end constructor


sub MapEditorMenu.Display()

 dim amount as Integer
 
 palette_menu.Display()
 map_menu.Display()
 BlueBox(map_menu.x, map_menu.y + map_menu.max_rows * 2 + 2, 6, 1)
 WriteText(FF4Text(Pad(str(map_menu.cursor_x), 2, true) + ", " + Pad(str(map_menu.cursor_y), 2, true)), map_menu.x + 1, map_menu.y + map_menu.max_rows * 2 + 3)
 BlueBox(palette_menu.x, palette_menu.y + palette_menu.rows * 2 + 2, 16, 1)
 amount = &h17B5F - spaceused - mapgrids(map_index).BytesUsed()
 'amount = 0
 if amount < 0 then
  WriteText(FF4Text("Over:      " + Pad(str(abs(amount)), 5, true)), palette_menu.x + 1, palette_menu.y + palette_menu.rows * 2 + 3, 12)
 else
  WriteText(FF4Text("Room:      " + Pad(str(amount), 5, true)), palette_menu.x + 1, palette_menu.y + palette_menu.rows * 2 + 3, 15)
 end if

end sub


sub MapEditorMenu.SetTo(index as UInteger)

 dim underground as Integer
 dim temp as Integer
 dim debug as String
 
 if index > &h100 then underground = &h100 else underground = 0
 map_menu.options.Destroy()
 map_index = maps(index).grid_index + underground + 1
 
 'if index < 252 or index > 256 then
  'open "debug.txt" for output as #1
  spaceused = 0
  for i as Integer = 1 to total_maps
   if i <> maps(index).grid_index + underground + 1 then ' and not mapgrids(maps(i).grid_index + underground + 1).no_data then
    'debug = mapgrids(maps(i).grid_index + underground + 1).RunLengthEncoding()
    temp = mapgrids(i).BytesUsed()
    spaceused += temp
    'print #1, Pad(str(i), 3, true); ": "; Pad(str(temp), 3, true); " = "; Pad(str(spaceused), 6, true); " - ";
    'for j as Integer = 1 to temp
     'print #1, hex(asc(mid(debug, j, 1)), 2); " ";
    'next
    'print #1, ""
   end if
  next
  'close #1
  'print "OK"
  'getkey
  'end
   
  map_menu.tileset_index = maps(index).tileset_index
  map_menu.current_palette = maps(index).map_palette
  palette_menu.tileset_index = map_menu.tileset_index
  palette_menu.current_palette = map_menu.current_palette
  tilesets(map_menu.tileset_index + 1).SetGraphics(map_menu.current_palette)

  for i as Integer = 0 to 31
   for j as Integer = 0 to 31
    if not mapgrids(maps(index).grid_index + underground + 1).no_data then 
     map_menu.options.Assign(j + 1, i + 1, hex(mapgrids(maps(index).grid_index + underground + 1).tiles(j, i), 2))
    end if
   next
  next
  
  map_menu.SetBackgroundMap(maps(index).background + underground + 1)
 
 'end if

end sub


sub MapEditorMenu.UserSelect()

 dim key as String
 dim keycode as UInteger
 dim done as Boolean
 dim active_menu as GridMenu ptr
 
 if map_menu.Columns() > 0 then

  palette_menu.active = false
  map_menu.active = true
  active_menu = @map_menu
  
  do
   
   Display()
   do
    key = inkey
    keycode = asc(right(key, 1))
    if len(key) > 1 then keycode = keycode * &h100 + 255
    map_menu.Animate()
    palette_menu.Animate()
   loop while key = ""
   select case keycode
    case TAB_KEY
     if active_menu = @map_menu then 
      active_menu = @palette_menu
      palette_menu.active = true
      map_menu.active = false
     else
      active_menu = @map_menu
      palette_menu.active = false
      map_menu.active = true
     end if
    case ENTER_KEY
     if active_menu = @map_menu then
      for i as Integer = 0 to map_menu.cursor_w step sgn(map_menu.cursor_w)
       for j as Integer = 0 to map_menu.cursor_h step sgn(map_menu.cursor_h)
        map_menu.options.Assign(map_menu.cursor_x + i + 1, map_menu.cursor_y + j + 1, palette_menu.options.ItemAt(palette_menu.cursor_x + 1, palette_menu.cursor_y + 1))
        if map_menu.cursor_h = 0 then exit for
       next
       if map_menu.cursor_w = 0 then exit for
      next
     end if
    case BACKSPACE_KEY
     if active_menu = @map_menu then
      palette_menu.cursor_x = val("&h" + right(map_menu.options.ItemAt(map_menu.cursor_x + 1, map_menu.cursor_y + 1), 1)) mod 8
      palette_menu.cursor_y = val("&h" + left(map_menu.options.ItemAt(map_menu.cursor_x + 1, map_menu.cursor_y + 1), 1)) * 2 + val("&h" + right(map_menu.options.ItemAt(map_menu.cursor_x + 1, map_menu.cursor_y + 1), 1)) \ 8
     end if
    case SPACE_KEY
     if active_menu = @map_menu then
      map_menu.FloodFill(map_menu.cursor_x + 1, map_menu.cursor_y + 1, palette_menu.options.ItemAt(palette_menu.cursor_x + 1, palette_menu.cursor_y + 1))
     end if
    case DOWN_KEY
     if active_menu = @map_menu then
      if multikey(SC_LSHIFT) or multikey(SC_RSHIFT) then
       if abs(map_menu.cursor_h) < map_menu.max_columns - 1 then
        if map_menu.cursor_y < map_menu.Rows() - 1 then map_menu.cursor_h -= 1
        map_menu.ProcessKey(keycode)
       end if
      else
       map_menu.cursor_w = 0
       map_menu.cursor_h = 0
       map_menu.ProcessKey(keycode)
      end if
     else
      active_menu->ProcessKey(keycode)
     end if
    case RIGHT_KEY
     if active_menu = @map_menu then
      if multikey(SC_LSHIFT) or multikey(SC_RSHIFT) then
       if abs(map_menu.cursor_w) < map_menu.max_rows - 1 then
        if map_menu.cursor_x < map_menu.Columns() - 1 then map_menu.cursor_w -= 1
        map_menu.ProcessKey(keycode)
       end if
      else
       map_menu.cursor_w = 0
       map_menu.cursor_h = 0
       map_menu.ProcessKey(keycode)
      end if
     else
      active_menu->ProcessKey(keycode)
     end if
    case UP_KEY
     if active_menu = @map_menu then
      if multikey(SC_LSHIFT) or multikey(SC_RSHIFT) then
       if abs(map_menu.cursor_h) < map_menu.max_columns - 1 then
        if map_menu.cursor_y > 0 then map_menu.cursor_h += 1
        map_menu.ProcessKey(keycode)
       end if
      else
       map_menu.cursor_w = 0
       map_menu.cursor_h = 0
       map_menu.ProcessKey(keycode)
      end if
     else
      active_menu->ProcessKey(keycode)
     end if
    case LEFT_KEY
     if active_menu = @map_menu then
      if multikey(SC_LSHIFT) or multikey(SC_RSHIFT) then
       if abs(map_menu.cursor_w) < map_menu.max_rows - 1 then
        if map_menu.cursor_x > 0 then map_menu.cursor_w += 1
        map_menu.ProcessKey(keycode)
       end if
      else
       map_menu.cursor_w = 0
       map_menu.cursor_h = 0
       map_menu.ProcessKey(keycode)
      end if     
     else
      active_menu->ProcessKey(keycode)
     end if
    case else
     done = active_menu->ProcessKey(keycode)
   end select
   
  loop until done
  
  active_menu->active = false
  
 end if

end sub
