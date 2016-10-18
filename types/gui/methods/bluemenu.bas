constructor BlueMenu(starting_x as UInteger = 0, starting_y as UInteger = 0)

 x = starting_x
 y = starting_y

end constructor


function BlueMenu.CursorX(h as Boolean = false) as UByte

 dim result as UByte
 
 if h then 
  result = x + ((highlighted - 1) mod columns) * (options.Width() + 2) + 1
 else
  result = x + ((selected - 1) mod columns) * (options.Width() + 2)
 end if
 
 return result

end function


function BlueMenu.CursorY(h as Boolean = false) as UByte

 dim result as UByte
 
 if h then
  result = y + (highlighted - 1) \ columns - top_row + 2
 else
  result = y + (selected - 1) \ columns - top_row + 2
 end if
 
 return result

end function


function BlueMenu.ProcessKey(key_code as UInteger) as Boolean

 dim result as Boolean
 dim temp as Integer

 select case key_code
 case ENTER_KEY
  if swap_enabled and (multikey(SC_LSHIFT) or multikey(SC_RSHIFT)) then
   highlighted = selected
  else
   result = true
   cancelled = false
  end if
 case ESC_KEY
  result = true
  cancelled = true
 case UP_KEY
  if selected > columns then 
   selected -= columns
   if selected <= (top_row - 1) * columns then top_row -= 1
  end if
 case DOWN_KEY
  if selected + columns <= options.Length() then
   selected += columns
   if selected > (top_row + WindowHeight() - 1) * columns then top_row += 1
  end if
 case LEFT_KEY
  if (selected - 1) mod columns > 0 then selected -= 1
 case RIGHT_KEY
  if (selected - 1) mod columns < columns - 1 and selected < options.Length() then selected += 1
 case HOME_KEY
  if top_row > 1 then top_row = 1
  selected = 1
 case END_KEY
  if max_rows > 0 then
   'if top_row < (options.Length() - 1) \ columns + 1 - WindowHeight() + 1 then 
   if top_row + RoundUp(options.Length() / columns) > WindowHeight() then
    top_row = (options.Length() - 1) \ columns + 1 - WindowHeight() + 1
   end if
  end if
  selected = options.Length()
 case PAGEUP_KEY
  if max_rows = 1 then temp = 10 else temp = WindowHeight()
  if top_row > temp then
   top_row -= temp
   selected -= temp * columns
  else
   top_row = 1
   selected = 1
  end if
 case PAGEDOWN_KEY
  if max_rows = 1 then temp = 10 else temp = WindowHeight()
  if WindowHeight() > options.Length() then
   selected = options.Length()
  else
   if top_row + WindowHeight() + temp > RoundUp(options.Length() / columns) then
    top_row = (options.Length() - 1) \ columns + 1 - WindowHeight() + 1
    selected = options.Length()
   else
    top_row += temp
    selected += temp * columns
   end if
  end if
 case asc("/")
  indexed_mode = not indexed_mode
  RestoreSnapshot()
  TakeSnapshot()
 end select
 
 return result

end function


function BlueMenu.UserInput() as Boolean
 
 dim result as Boolean
 
 'screensync
 Display()
 ShowCursor()
 result = ProcessKey(getkey)

 return result
 
end function


function BlueMenu.WindowHeight() as UByte
 
 dim result as UByte
 
 if max_rows = 0 then result = options.Length() else result = max_rows
 if result mod columns = 0 then result \= columns else result = result \ columns + 1
 
 return result
 
end function


function BlueMenu.WindowWidth() as UByte

 dim result as UByte
 
 result = (options.Width() + 2) * columns - 2
 if indexed_mode then result += len(str(options.Length())) + 2
 
 return result

end function


sub BlueMenu.AddOption(s as String, c as UByte = 15)
 
 options.Append(s)
 colors.Append(str(c))
 
end sub


sub BlueMenu.ChangeOption(index as UInteger, s as String = "", c as Integer = -1)
 
 if len(s) > 0 then options.Assign(index, s)
 if c >= 0 then colors.Assign(index, str(c))
 
end sub


sub BlueMenu.ChangeSelected(index as UInteger)
 
 if index > 0 and options.Length() > 0 then
  if index <= options.Length() then
   selected = index
  else
   selected = options.Length()
  end if
  if max_rows > 0 then
   do while selected <= (top_row - 1) * columns 
    top_row -= 1
   loop
   do while selected > (top_row + WindowHeight() - 1) * columns 
    top_row += 1
   loop
  end if
 end if
  
end sub


sub BlueMenu.ClearAll()
 
 options.Destroy()
 colors.Destroy()
 
end sub


sub BlueMenu.Display()
 
 dim temp as String
 dim item_index as Integer
 dim text_x as Integer
 dim text_y as Integer
 dim menu_image as Any ptr
 dim text_width as Integer
 dim item_width as Integer
 
 if max_rows = 0 then top_row = 1
 
 item_width = options.Width()
 if indexed_mode then item_width += len(str(options.Length())) + 2
 text_width = (columns - 1) * (item_width + 2) + item_width
 
 menu_image = ImageCreate((text_width + 2) * 8, (WindowHeight() + 2) * 8, RGB(0, 0, 0))
 BlueBox(0, 0, text_width, WindowHeight(), menu_image)
 'if debug then print "OK": getkey: end
 
 for i as UByte = 1 to WindowHeight()
  for j as UByte = 1 to columns
   item_index = (top_row + i - 2) * columns + j
   temp = rtrim(options.ItemAt(item_index))
   if indexed_mode then temp = FF4Text(Pad(str(item_index), len(str(options.Length())), true) + ": ") + temp
   temp += FF4Text(space(item_width - len(temp)))
   if j < columns then temp += FF4Text("  ")
   text_x = 0 + (j - 1) * (item_width + 2) + 1
   text_y = 0 + i
   WriteText(temp, text_x, text_y, val(colors.ItemAt(item_index)), menu_image)
  next
 next
 
 put (x * 8, y * 8), menu_image, trans
 ImageDestroy(menu_image)

  
end sub


sub BlueMenu.Hide()

 dim blank as Any ptr 
 
 if snapshot = 0 then
  blank = ImageCreate(Min((WindowWidth() + (len(str(options.Length())) + 2) + 2), screen_width) * 8, (WindowHeight() + 2) * 8, RGB(0, 0, 0))
  put (x * 8, y * 8), blank, pset
  ImageDestroy(blank)
 else
  RestoreSnapshot()
  ImageDestroy(snapshot)
  snapshot = 0
 end if
 
end sub


sub BlueMenu.Remove(index as UInteger = 0)

 if index = 0 then index = selected
 options.Remove(index)
 colors.Remove(index)
 if selected > options.Length() then selected = options.Length()
 if selected = 0 then selected = 1

end sub


sub BlueMenu.RestoreSnapshot()

 put (x * 8, y * 8), snapshot, pset

end sub

sub BlueMenu.ShowCursor()

 DrawLetter(20, CursorX(), CursorY())
 if highlighted > 0 then
  if CursorY(true) > y and CursorY(true) <= y + WindowHeight() then
   DrawLetter(20, CursorX(true), CursorY(true))
  end if
 end if

end sub


sub BlueMenu.TakeSnapshot()

 if snapshot <> 0 then
  ImageDestroy(snapshot)
  'snapshot = 0
 end if
 snapshot = ImageCreate(Min((WindowWidth() + (len(str(options.Length())) + 2) + 2), screen_width) * 8, (WindowHeight() + 2) * 8, RGB(0, 0, 0))
 get (x * 8, y * 8)-(Min((x + WindowWidth() + (len(str(options.Length())) + 2) + 2), screen_width) * 8 - 1, (y + WindowHeight() + 2) * 8 - 1), snapshot

end sub


sub BlueMenu.UserSelect()

 TakeSnapshot()
 do until UserInput()
 loop
 RestoreSnapshot()
 ImageDestroy(snapshot)
 snapshot = 0
 
end sub
