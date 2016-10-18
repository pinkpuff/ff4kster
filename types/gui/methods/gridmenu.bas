function GridMenu.Columns() as UInteger

 return options.Width()

end function


function GridMenu.Height() as UByte

 dim result as UByte
 
 result = max_rows
 if result = 0 then result = Rows()
 
 return result

end function


function GridMenu.ProcessKey(k as UInteger) as Boolean

 dim result as Boolean
 
 select case k
  case ESC_KEY
   result = true
  case LEFT_KEY
   if cursor_x > 0 then cursor_x -= 1
  case RIGHT_KEY
   if cursor_x < Columns() - 1 then cursor_x += 1
  case UP_KEY
   if cursor_y > 0 then cursor_y -= 1
  case DOWN_KEY
   if cursor_y < Rows() - 1 then cursor_y += 1
  case HOME_KEY
   cursor_x = 0
   cursor_y = 0
  case END_KEY
   cursor_x = 0
   cursor_y = Rows() - 1
  case PAGEUP_KEY
   cursor_x = Columns() - 1
   cursor_y = 0
  case PAGEDOWN_KEY
   cursor_x = Columns() - 1
   cursor_y = Rows() - 1
 end select
 
 if cursor_x < window_x then window_x = cursor_x
 if cursor_y < window_y then window_y = cursor_y
 if cursor_x >= window_x + Width() then window_x = cursor_x - Width() + 1
 if cursor_y >= window_y + Height() then window_y = cursor_y - Height() + 1
 
 return result
 
end function


function GridMenu.Rows() as UInteger

 return options.Height()
 
end function


function GridMenu.UserInput() as Boolean

 'return ProcessKey(getkey)
 
 dim key as String
 dim keycode as UInteger
 
 do
  key = inkey
  keycode = asc(right(key, 1))
  if len(key) > 1 then keycode = keycode * &h100 + 255
  Animate()
 loop while key = ""
 
 return ProcessKey(keycode)
 
end function


function GridMenu.Width() as UByte

 dim result as UByte
 
 result = max_columns
 if result = 0 then result = Columns()
 
 return result

end function


sub GridMenu.Animate()

 dim current_tile as Tile ptr
 dim cx as Integer
 dim cy as Integer
 dim null_bg as Any ptr
 dim canvas as Any ptr

 canvas = ImageCreate((Width() + 1) * 16, (Height() + 1) * 16, RGB(255, 0, 255))
 null_bg = ImageCreate(32 * 16, 32 * 16, RGB(0, 0, 0))

 if timer - delay >= .25 then

  'Reset timer
  delay = timer
  frame = (frame + 1) mod 4

  if Columns() > 0 then
   for i as Integer = 1 to Height()
    for j as Integer = 1 to Width()
     current_tile = @tilesets(tileset_index + 1).tiles(val("&h" + options.ItemAt(j + window_x, i + window_y)) + 1)
     if current_tile->sprite(1).IsAnimated() then
      current_tile->Display((j - 1) * 2 + 1, (i - 1) * 2 + 1, foreground, frame)
     end if
    next
   next
   if cursor_w < 0 then cx = cursor_x + cursor_w else cx = cursor_x
   if cursor_h < 0 then cy = cursor_y + cursor_h else cy = cursor_y
   'if background(1) = 0 then
    'bg_frame = null_bg
   'else
    'select case frame
     'case 0: bg_frame = background
     'case 1: bg_frame = background2
     'case 2: bg_frame = background3
     'case 3: bg_frame = background4
    'end select
   'end if
   if bg_translucent then
    put canvas, (0, 0), foreground, trans
    put canvas, (8, 8), background(frame + 1), (0, 0)-(Width() * 16 - 1, Height() * 16 - 1), alpha, 127
   else
    put canvas, (8, 8), background(frame + 1), (0, 0)-(Width() * 16 - 1, Height() * 16 - 1), pset
    put canvas, (0, 0), foreground, trans
   end if
   put canvas, ((cx - window_x) * 16 + 4, (cy - window_y) * 16 + 4), cursor, trans
   put (x * 8, y * 8), canvas, trans
  end if
  
 elseif delay = 0 then
 
  delay = timer
  frame = 0
  
 end if
 
 ImageDestroy(null_bg)
 ImageDestroy(canvas)

end sub


sub GridMenu.Display()

 dim temp as Integer
 dim tile as String
 dim canvas as Any ptr
 dim c as UInteger
 dim cx as Integer
 dim cy as Integer
 
 if foreground <> 0 then ImageDestroy(foreground)
 foreground = ImageCreate((Width() + 1) * 16, (Height() + 1) * 16, RGB(255, 0, 255))
 canvas = ImageCreate((Width() + 1) * 16, (Height() + 1) * 16, RGB(255, 0, 255))
 for i as Integer = 1 to 4
  if background(i) = 0 then background(i) = ImageCreate(32 * 16, 32 * 16, RGB(0, 0, 0))
 next
 SetCursorGraphic()
  
 BlueBox(0, 0, Width() * 2, Height() * 2, canvas)
 if Columns() = 0 then
  WriteText(FF4Text("No data"), max_columns - 3, max_rows, , canvas)
 else
  for i as Integer = 1 to Height()
   for j as Integer = 1 to Width()
    tilesets(tileset_index + 1).tiles(val("&h" + options.ItemAt(j + window_x, i + window_y)) + 1).Display((j - 1) * 2 + 1, (i - 1) * 2 + 1, foreground, frame)
   next
  next
  if bg_translucent then
   put canvas, (0, 0), foreground, trans
   put canvas, (8, 8), background(1), (0, 0)-(Width() * 16 - 1, Height() * 16 - 1), alpha, 127
  else
   put canvas, (8, 8), background(1), (0, 0)-(Width() * 16 - 1, Height() * 16 - 1), pset
   put canvas, (0, 0), foreground, trans
  end if
  if cursor_w < 0 then cx = cursor_x + cursor_w else cx = cursor_x
  if cursor_h < 0 then cy = cursor_y + cursor_h else cy = cursor_y
  put canvas, ((cx - window_x) * 16 + 4, (cy - window_y) * 16 + 4), cursor, trans
 end if
 
 put (x * 8, y * 8), canvas, trans
 
 ImageDestroy(canvas)
  
end sub


sub GridMenu.ClearAll()

 options.Destroy()

end sub


sub GridMenu.FloodFill(x as UByte, y as UByte, tile as String)

 dim oldtile as String
 
 oldtile = options.ItemAt(x, y)
 if tile <> oldtile then
  options.Assign(x, y, tile)
  if x > 1 then if options.ItemAt(x - 1, y) = oldtile then FloodFill(x - 1, y, tile)
  if x < options.Width() then if options.ItemAt(x + 1, y) = oldtile then FloodFill(x + 1, y, tile)
  if y > 1 then if options.ItemAt(x, y - 1) = oldtile then FloodFill(x, y - 1, tile)
  if y < options.Height() then if options.ItemAt(x, y + 1) = oldtile then FloodFill(x, y + 1, tile)
 end if

end sub


sub GridMenu.SetBackgroundMap(index as Integer)

 bg_map = index
 
 for layer as Integer = 1 to 4
  if background(layer) <> 0 then ImageDestroy(background(layer))
  background(layer) = ImageCreate(32 * 16, 32 * 16, RGB(0, 0, 0))
  if bg_map > 1 and bg_map <= total_maps then
   if not mapgrids(bg_map).no_data then
    for i as Integer = 0 to 31
     for j as Integer = 0 to 31
      tilesets(tileset_index + 1).tiles(mapgrids(bg_map).tiles(i + 1, j + 1) + 1).Display(i * 2, j * 2, background(layer), layer - 1)
     next
    next
   end if
  end if
 next

 if bg_map > 1 and bg_map <= total_maps then
  if tilesets(tileset_index + 1).tiles(mapgrids(bg_map).tiles(1, 1) + 1).sprite(1).front then
   bg_translucent = true
  else
   bg_translucent = false
  end if
 end if
 
end sub


sub GridMenu.SetCursorGraphic()

 dim c as UInteger

 if cursor <> 0 then ImageDestroy(cursor)
 cursor = ImageCreate(16 * (abs(cursor_w) + 1) + 8, 16 * (abs(cursor_h) + 1) + 8)
 if active then c = RGB(255, 255, 255) else c = RGB(127, 127, 127)
 
 'Create cursor graphic
 line cursor, (0, 0)-(16 * (abs(cursor_w) + 1) + 7, 16 * (abs(cursor_h) + 1) + 7), RGB(0, 0, 0), b
 line cursor, (1, 1)-(16 * (abs(cursor_w) + 1) + 6, 16 * (abs(cursor_h) + 1) + 6), c, b
 line cursor, (2, 2)-(16 * (abs(cursor_w) + 1) + 5, 16 * (abs(cursor_h) + 1) + 5), c, b
 line cursor, (3, 3)-(16 * (abs(cursor_w) + 1) + 4, 16 * (abs(cursor_h) + 1) + 4), RGB(0, 0, 0), b

end sub


sub GridMenu.UserSelect()

 do
  Display()
 loop until UserInput()

end sub
