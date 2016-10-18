#include once "../keycodes.bas"
#include once "../list.bas"
#include once "../functions/pad.bas"

type Menu
 
 x as UInteger = 0
 y as UInteger = 0
 options as List
 colors as List
 highlight_color as UByte = 7
 cancelled as Boolean = false
 selected as UInteger = 1
 max_rows as UInteger = 0
 top_row as UInteger = 1
 columns as UByte = 1
 max_width as UInteger = 78
 
 declare constructor(starting_x as UInteger = 0, starting_y as UInteger = 0)
 
 declare function UserInput() as Boolean
 declare function WindowHeight() as UByte
 
 declare sub AddOption(s as String, c as UByte = 7)
 declare sub ChangeOption(index as UInteger, s as String = "", c as Integer = -1)
 declare sub ChangeSelected(index as UInteger)
 declare sub ClearAll()
 declare sub Display(show_highlight as Boolean = true)
 declare sub UserSelect()
 
end type


constructor Menu(starting_x as UInteger = 0, starting_y as UInteger = 0)

 x = starting_x
 y = starting_y

end constructor


function Menu.UserInput() as Boolean
 
 dim result as Boolean
 dim a as UInteger
 
 Display()
 
 select case getkey
 case ENTER_KEY
  result = true
  cancelled = false
 case ESC_KEY
  result = true
  cancelled = true
 case UP_KEY
  if selected > columns then 
   selected -= columns
   if selected <= (top_row - 1) * columns then top_row -= 1
  end if
 case DOWN_KEY
  if selected <= options.Length() - columns then
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
   if top_row < (options.Length() - 1) \ columns + 1 - WindowHeight() + 1 then 
    top_row = (options.Length() - 1) \ columns + 1 - WindowHeight() + 1
   end if
  end if
  selected = options.Length()
 end select
 
 return result
 
end function


function Menu.WindowHeight() as UByte
 
 dim result as UByte
 
 if max_rows = 0 then result = options.Length() else result = max_rows
 if result mod columns = 0 then result \= columns else result = result \ columns + 1
 
 return result
 
end function


sub Menu.AddOption(s as String, c as UByte = 7)
 
 options.Append(s)
 colors.Append(str(c))
 
end sub


sub Menu.ChangeOption(index as UInteger, s as String = "", c as Integer = -1)
 
 if len(s) > 0 then options.Assign(index, s)
 if c >= 0 then colors.Assign(index, str(c))
 
end sub


sub Menu.ChangeSelected(index as UInteger)
 
 if index > 0 and index <= options.Length() then
  selected = index
  do while selected <= (top_row - 1) * columns 
   top_row -= 1
  loop
  do while selected > (top_row + WindowHeight() - 1) * columns 
   top_row += 1
  loop
 end if
  
end sub


sub Menu.ClearAll()
 
 options.Destroy()
 
end sub


sub Menu.Display(show_highlight as Boolean = true)
 
 dim temp as String
 dim item_index as Integer
 dim text_x as Integer
 dim text_y as Integer
 
 for i as UByte = 1 to WindowHeight()
  for j as UByte = 1 to columns
   item_index = (top_row + i - 2) * columns + j
   temp = left(Pad(rtrim(options.ItemAt(item_index)), options.Width()), max_width)
   text_x = x + (j - 1) * (options.Width() + 2)
   text_y = y + i - 1
   locate text_y, text_x
   if item_index = selected and show_highlight then
    color 0, highlight_color
   else
    color val(colors.ItemAt(item_index)), 0
   end if
   print temp;
   color 7, 0
   if j < columns then print "  ";
  next
 next
 color 7, 0
  
end sub


sub Menu.UserSelect()
 
 do until UserInput()
 loop
 
end sub
