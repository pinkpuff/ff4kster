constructor BlueNumberInput(starting_x as UInteger = 0, starting_y as UInteger = 0)

 x = starting_x
 y = starting_y

end constructor


function BlueNumberInput.UserInput() as Boolean

 dim result as Boolean
 dim a as UInteger

 Display()
 DrawLetter(20, x, y + 1)
 a = getkey
 select case a
  case ESC_KEY
   number = starting_number
   result = true
  case ENTER_KEY
   result = true
  case UP_KEY
   if number < max_value then number += 1
  case DOWN_KEY
   if number > min_value then number -= 1
  case PAGEUP_KEY
   if number + 10 <= max_value then number += 10
  case PAGEDOWN_KEY
   if number >= min_value + 10 then number -= 10
  case HOME_KEY
   number = min_value
  case END_KEY
   number = max_value
  case BACKSPACE_KEY
   number = number \ 10
   if number < min_value then number = min_value
  case asc("0") to asc("9")
   number *= 10
   number += a - 48
   if number > max_value then number = max_value
 end select
 
 return result

end function


sub BlueNumberInput.Display()

 BlueBox(x, y, len(str(max_value)), 1)
 WriteText(FF4Text(Pad(str(number), len(str(max_value)), true)), x + 1, y + 1)

end sub


sub BlueNumberInput.Hide()

 dim blank as Any ptr 
 
 blank = ImageCreate((x + len(str(max_value)) + 2) * 8, (y + 1 + 2) * 8, RGB(0, 0, 0))
 put (x * 8, y * 8), blank, pset
 
 ImageDestroy(blank)

end sub


sub BlueNumberInput.UserSelect()

 dim done as Boolean
 dim snapshot as any ptr

 snapshot = ImageCreate(640, 480)
 get (x * 8, y * 8)-((x + len(str(max_value)) + 2) * 8, (y + 1 + 2) * 8 - 1), snapshot
 number = starting_number

 do until UserInput()
 loop

 put (x * 8, y * 8), snapshot, pset
 ImageDestroy(snapshot)

end sub
