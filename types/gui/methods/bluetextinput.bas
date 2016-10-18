constructor BlueTextInput(starting_x as UByte = 0, starting_y as UByte = 0, starting_width as UByte = 0)

 x = starting_x
 y = starting_y
 text_width = starting_width

end constructor


function BlueTextInput.ShownText() as String

 dim result as String
 
 if extended then
  for i as Integer = 1 to len(text)
   if mid(text, i, 1) = chr(4) then
    if i < len(text) then
     result += character_names.ItemAt(asc(mid(text, i + 1, 1)) + 1)
     do while asc(right(result, 1)) = &hFF
      result = left(result, len(result) - 1)
     loop
     i += 1
    end if
   elseif mid(text, i, 1) = chr(6) then
    if i < len(text) then
     result += FF4Text("CODE:") + mid(text, i + 1, 1)
     i += 1
    end if
   else
    result += mid(text, i, 1)
   end if
  next
 else
  result = text
 end if
 
 return result

end function


sub BlueTextInput.ChangeStartingText(new_text as String)

 starting_text = left(new_text, text_width)
 text = starting_text

end sub


sub BlueTextInput.Display()

 dim temp as String
 
 BlueBox(x, y, text_width, 1)
 WriteText(Pad(left(ShownText(), text_width), text_width,, FF4Text(" ")), x + 1, y + 1)

end sub


sub BlueTextInput.Hide()

 dim blank as Any ptr
 
 blank = ImageCreate((text_width + 2) * 8, 3 * 8, RGB(0, 0, 0))
 put (x * 8, y * 8), blank, pset
 
 ImageDestroy(blank)

end sub


sub BlueTextInput.ShowCursor()

 DrawLetter(20, x, y + 1)

end sub


sub BlueTextInput.UserType()

 dim snapshot as any ptr
 dim done as Boolean
 dim temp as UInteger
 dim letter as UByte

 snapshot = ImageCreate(640, 480)
 get (x * 8, y * 8)-((x + text_width + 2) * 8, (y + 2) * 8 - 1), snapshot
 text = starting_text

 do until done
  Display()
  if cursor then ShowCursor()
  temp = getkey
  select case temp
   case ESC_KEY
    text = starting_text
    done = true
   case ENTER_KEY
    done = true
   case BACKSPACE_KEY
    text = left(text, len(text) - 1)
    if extended then
     if right(text, 1) = chr(4) or right(text, 1) = chr(6) then text = left(text, len(text) - 1)
    end if
   case INSERT_KEY
    if len(ShownText()) < text_width then
     if extended then
      dim insert_menu as BlueMenu
      dim symbol_menu as BlueMenu
      dim name_menu as BlueMenu
      dim code_input as BlueNumberInput
      insert_menu = BlueMenu(x, y + 3)
      insert_menu.AddOption(FF4Text("Name"))
      insert_menu.AddOption(FF4Text("Symbol"))
      insert_menu.AddOption(FF4Text("Code"))
      insert_menu.columns = insert_menu.options.Length()
      insert_menu.UserSelect()
      if not insert_menu.cancelled then
       select case insert_menu.selected
        case 1 'Name
         name_menu = BlueMenu(x, y + 3)
         for i as Integer = 1 to character_names.Length()
          name_menu.AddOption(character_names.ItemAt(i))
         next
         name_menu.UserSelect()
         if not name_menu.cancelled and len(ShownText()) + 6 <= text_width then text += chr(4) + chr(name_menu.selected - 1)
        case 2 'Symbol
         symbol_menu = BlueMenu(x, y + 3)
         for i as Integer = &h21 to &h41
          symbol_menu.AddOption(chr(i))
         next
         for i as Integer = &h76 to &h7F
          symbol_menu.AddOption(chr(i))
         next
         symbol_menu.columns = Max(text_width \ 3, 1)
         symbol_menu.UserSelect()
         if not symbol_menu.cancelled then
          if symbol_menu.selected < 34 then
           text += chr(symbol_menu.selected + 32)
          else
           text += chr(symbol_menu.selected + 84)
          end if
         end if
        case 3 'Code
         code_input = BlueNumberInput(x, y + 3)
         code_input.max_value = 4
         code_input.UserSelect()
         if len(ShownText()) + 6 <= text_width then text += chr(6) + FF4Text(str(code_input.number))
       end select
      end if
     else
      letter = &h21
      do until done
       DrawLetter(letter, x + len(text) + 1, y + 1, 10)
       select case getkey
        case ESC_KEY
         done = true
        case ENTER_KEY
         text += chr(letter)
         done = true
        case UP_KEY
         if letter = &h41 then
          letter = &h76
         elseif letter < &h7F then 
          letter += 1
         end if
        case DOWN_KEY
         if letter = &h76 then
          letter = &h41
         elseif letter > &h21 then
          letter -= 1
         end if
       end select
      loop
     end if
     done = false
    end if
   case else
    if len(ShownText()) < text_width then text += FF4Text(chr(temp))
  end select
 loop

 put (x * 8, y * 8), snapshot, pset
 ImageDestroy(snapshot)

end sub
