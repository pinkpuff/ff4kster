constructor BlueMessageInput(starting_x as UByte = 0, starting_y as UByte = 0, starting_message as String = "")

 x = starting_x
 y = starting_y
 w = 28
 h = 52
 'topline = 1
 'cursor = ImageCreate(8, 8, 14)
 cursor = ImageCreate(8, 8, RGB(255, 255, 0))
 
 ParseMessage(starting_message)
 if lines.Length() = 0 then lines.Append("")
 cursor_y = y + Min(h, lines.Length())
 topline = lines.Length() - Min(lines.Length(), h) + 1
 cursor_x = x + len(lines.ItemAt(lines.Length())) + 1
 
end constructor


function BlueMessageInput.Message() as String

 dim result as String
 dim temp as String
 dim total as String
 
 for i as Integer = 1 to lines.Length()
  total += lines.ItemAt(i)
 next

 temp = total
 for i as Integer = 1 to len(total) step 2
  select case mid(total, i, 2)
   case FF4Text("e "): result += chr(&h8A)
   case FF4Text(" t"): result += chr(&h8B)
   case FF4Text("th"): result += chr(&h8C)
   case FF4Text("he"): result += chr(&h8D)
   case FF4Text("t "): result += chr(&h8E)
   case FF4Text("ou"): result += chr(&h8F)
   case FF4Text(" a"): result += chr(&h90)
   case FF4Text("s "): result += chr(&h91)
   case FF4Text("er"): result += chr(&h92)
   case FF4Text("in"): result += chr(&h93)
   case FF4Text("re"): result += chr(&h94)
   case FF4Text("d "): result += chr(&h95)
   case FF4Text("an"): result += chr(&h96)
   case FF4Text(" o"): result += chr(&h97)
   case FF4Text("on"): result += chr(&h98)
   case FF4Text("st"): result += chr(&h99)
   case FF4Text(" w"): result += chr(&h9A)
   case FF4Text("o "): result += chr(&h9B)
   case FF4Text(" m"): result += chr(&h9C)
   case FF4Text("ha"): result += chr(&h9D)
   case FF4Text("to"): result += chr(&h9E)
   case FF4Text("is"): result += chr(&h9F)
   case FF4Text("yo"): result += chr(&hA0)
   case FF4Text(" y"): result += chr(&hA1)
   case FF4Text(" i"): result += chr(&hA2)
   case FF4Text("al"): result += chr(&hA3)
   case FF4Text("ar"): result += chr(&hA4)
   case FF4Text(" h"): result += chr(&hA5)
   case FF4Text("r "): result += chr(&hA6)
   case FF4Text(" s"): result += chr(&hA7)
   case FF4Text("at"): result += chr(&hA8)
   case FF4Text("n "): result += chr(&hA9)
   case FF4Text(" c"): result += chr(&hAA)
   case FF4Text("ng"): result += chr(&hAB)
   case FF4Text("ve"): result += chr(&hAC)
   case FF4Text("ll"): result += chr(&hAD)
   case FF4Text("y "): result += chr(&hAE)
   case FF4Text("nd"): result += chr(&hAF)
   case FF4Text("en"): result += chr(&hB0)
   case FF4Text("ed"): result += chr(&hB1)
   case FF4Text("hi"): result += chr(&hB2)
   case FF4Text("or"): result += chr(&hB3)
   case FF4Text(", "): result += chr(&hB4)
   case FF4Text("I "): result += chr(&hB5)
   case FF4Text("u "): result += chr(&hB6)
   case FF4Text("me"): result += chr(&hB7)
   case FF4Text("ta"): result += chr(&hB8)
   case FF4Text(" b"): result += chr(&hB9)
   case FF4Text(" I"): result += chr(&hBA)
   case FF4Text("te"): result += chr(&hBB)
   case FF4Text("of"): result += chr(&hBC)
   case FF4Text("ea"): result += chr(&hBD)
   case FF4Text("ur"): result += chr(&hBE)
   case FF4Text("l "): result += chr(&hBF)
   case else
    select case mid(total, i, 1)
     case FF4Text("/")
      if lcase(AsciiText(mid(total, i + 1, 4))) = "song" then
       result += chr(3) + chr(val(AsciiText(mid(total, i + 5, 3))))
       i += 7
      elseif lcase(AsciiText(mid(total, i + 1, 4))) = "name" then
       result += chr(4) + chr(val(AsciiText(mid(total, i + 5, 2))))
       i += 6
      elseif lcase(AsciiText(mid(total, i + 1, 4))) = "wait" then
       result += chr(5) + chr(val(AsciiText(mid(total, i + 5, 3))))
       i += 7
      elseif lcase(AsciiText(mid(total, i + 1, 3))) = "chr" then
       result += chr(val(AsciiText(mid(total, i + 4, 2))))
       i += 5
      elseif lcase(AsciiText(mid(total, i + 1, 5))) = "slash" then
       result += FF4Text("/")
       i += 5
      else
       if mid(total, i - 1, 1) = FF4Text("/") or i = 1 then result += chr(9) else result += chr(1)
      end if
     case else
      result += mid(total, i, 1)
    end select
    i -= 1
  end select
 next
 
 return result

end function


sub BlueMessageInput.Display()

 dim message_image as Any ptr
 'dim blank as Any ptr
  
 'blank = ImageCreate(640, 480)
 'message_image = ImageCreate((w + 2) * 8, (h + 2) * 8)
 message_image = ImageCreate(640, 480, RGB(0, 0, 0))
 BlueBox(0, 0, w, h, message_image)
 for i as Integer = topline to Min(topline + h - 1, lines.Length())
  WriteText(lines.ItemAt(i), 1, 1 + i - topline, 15, message_image)
 next
 DisplayDialogue(screen_width - 28 - x, 0, Message(), 9, RoundUp((topline - 1) / 4) + 1, message_image, true)
 put (x * 8, y * 8), message_image, pset
 ImageDestroy(message_image)
 
 'put ((screen_width - 28) * 8, y * 8), blank, pset
 'DisplayDialogue(screen_width - 28, y, Message(), 9, RoundUp((topline - 1) / 4) + 1)

end sub


sub BlueMessageInput.ParseMessage(m as String)

 dim temp as String
 dim newline as Boolean
 
 lines.Destroy()
 for i as Integer = 1 to len(m)
  select case asc(mid(m, i, 1))
   case 1, 9
    temp = FF4Text("/")
    newline = true
   case 3
    i += 1
    temp = FF4Text("/song" + Pad(str(asc(mid(m, i, 1))), 3, true, "0"))
   case 4
    i += 1
    temp = FF4Text("/name" + Pad(str(asc(mid(m, i, 1))), 2, true, "0"))
   case 5
    i += 1
    temp = FF4Text("/wait" + Pad(str(asc(mid(m, i, 1))), 3, true, "0"))
   case &hC7
    temp = FF4Text("/slash")
   case is > &h20
    temp = FromDTE(mid(m, i, 1))
   case else
    temp = FF4Text("/chr" + Pad(str(asc(mid(m, i, 1))), 2, true, "0"))
  end select
  if len(lines.ItemAt(lines.Length())) + len(temp) > w or lines.Length() = 0 then
   lines.Append(temp)
  else
   lines.Assign(lines.Length(), lines.ItemAt(lines.Length()) + temp)
  end if
  if newline then lines.Append("")
  newline = false
 next

end sub


sub BlueMessageInput.ShowCursor()

 put (cursor_x * 8, cursor_y * 8), cursor

end sub


sub BlueMessageInput.UserType()

 dim done as Boolean
 dim a as UInteger
 dim temp as String
 dim pos_x as UByte
 dim pos_y as UByte
 dim insert_menu as BlueMenu
 dim symbol_menu as BlueMenu
 dim name_menu as BlueMenu
 dim song_menu as BlueMenu
 dim parameter_input as BlueNumberInput
 
 insert_menu = BlueMenu(x, y + h + 2)
 insert_menu.AddOption(FF4Text("Name"))
 insert_menu.AddOption(FF4Text("Song"))
 insert_menu.AddOption(FF4Text("Pause"))
 insert_menu.AddOption(FF4Text("Symbol"))
 insert_menu.columns = insert_menu.options.Length()
 
 symbol_menu = BlueMenu(x + w + 2, y)
 for i as Integer = &h21 to &h41
  symbol_menu.AddOption(chr(i))
 next
 for i as Integer = &h76 to &h7F
  symbol_menu.AddOption(chr(i))
 next
 
 name_menu = BlueMenu(x, y + h - character_names.Length())
 for i as Integer = 1 to character_names.Length()
  name_menu.AddOption(character_names.ItemAt(i))
 next
 
 song_menu = BlueMenu(x, y + h - character_names.Length())
 song_menu.max_rows = character_names.Length()
 for i as Integer = 1 to song_names.Length()
  song_menu.AddOption(song_names.ItemAt(i))
 next
 
 parameter_input = BlueNumberInput(x + w + 2, y)
 
 do

  Display()
  ShowCursor()
  a = getkey

  select case a

   case ESC_KEY
    done = true

   case UP_KEY
    if cursor_y - y - 1 > 0 then
     cursor_y -= 1
    else
     if topline > 1 then topline -= 1
    end if

   case DOWN_KEY
    if cursor_y - y + topline <= lines.Length() then
     if cursor_y - y + 1 <= h then
      cursor_y += 1
     else
      if topline + h - 1 <= lines.Length() then topline += 1
     end if
    end if

   case LEFT_KEY
    if cursor_x - x - 1 > 0 then
     cursor_x -= 1
    end if

   case RIGHT_KEY
    if cursor_x - x + 1 <= w then
     cursor_x += 1
    end if

   case HOME_KEY
    cursor_x = x + 1

   case END_KEY
    cursor_x = Min(x + w, x + len(lines.ItemAt(cursor_y - y + topline - 1)) + 1)

   case PAGEUP_KEY
    cursor_y = y + 1
    topline = 1

   case PAGEDOWN_KEY
    cursor_y = y + Min(h, lines.Length())
    topline = lines.Length() - Min(lines.Length(), h) + 1

   case ENTER_KEY
    pos_y = cursor_y - y + topline - 1
    pos_x = cursor_x - x
    temp = mid(lines.ItemAt(pos_y), pos_x)
    lines.Assign(pos_y, left(lines.ItemAt(pos_y), pos_x - 1))
    lines.Insert(pos_y + 1, temp)
    cursor_x = x + 1
    if cursor_y - y + 1 <= h then cursor_y += 1 else topline += 1

   case DELETE_KEY
    pos_y = cursor_y - y + topline - 1
    pos_x = cursor_x - x
    temp = lines.ItemAt(pos_y)
    if len(temp) >= pos_x then
     temp = left(temp, pos_x - 1) + mid(temp, pos_x + 1)
     lines.Assign(pos_y, temp)
    end if

   case BACKSPACE_KEY
    pos_y = cursor_y - y + topline - 1
    if cursor_x > x + 1 then
     pos_x = cursor_x - x - 1
     temp = lines.ItemAt(pos_y)
     lines.Assign(pos_y, left(temp, pos_x - 1) + mid(temp, pos_x + 1))
     cursor_x -= 1
    else
     if pos_y - 1 > 0 then
      'if len(lines.ItemAt(pos_y)) = 0 then lines.Remove(pos_y)
      pos_y -= 1
      temp = lines.ItemAt(pos_y)
      pos_x = len(temp)
      cursor_y -= 1
      if cursor_y = y then
       cursor_y = y + 1
       topline -= 1
      end if
      if topline = 0 then
       topline = 1
       cursor_x = x + 1
      else
       cursor_x = x + len(lines.ItemAt(cursor_y - y + topline - 1)) + 1
       if len(temp) >= w then cursor_x -= 1
      end if
      if len(temp) < w and len(temp) + len(lines.ItemAt(pos_y + 1)) - 1 <= w then
       lines.Assign(pos_y, temp + lines.ItemAt(pos_y + 1))
       lines.Remove(pos_y + 1)
      else
       lines.Assign(pos_y, left(temp, len(temp) - 1))
      end if
     end if
    end if
    
   case INSERT_KEY
    dim instring as String
    pos_y = cursor_y - y + topline - 1
    pos_x = cursor_x - x
    temp = Pad(lines.ItemAt(pos_y), pos_x,, FF4Text(" "))
    insert_menu.UserSelect()
    if not insert_menu.cancelled then
     select case insert_menu.selected
      case 1 'Name
       name_menu.UserSelect()
       if not name_menu.cancelled then instring = FF4Text("/name" + Pad(str(name_menu.selected - 1), 2, true, "0"))
      case 2 'Song
       song_menu.UserSelect()
       if not song_menu.cancelled then instring = FF4Text("/song" + Pad(str(song_menu.selected - 1), 2, true, "0"))
      case 3 'Pause
       parameter_input.UserSelect()
       if parameter_input.number > 0 then instring = FF4Text("/wait" + Pad(str(parameter_input.number), 3, true, "0"))
      case 4 'Symbol
       symbol_menu.UserSelect()
       if not symbol_menu.cancelled then
        if symbol_menu.selected < 34 then
         instring = chr(32 + symbol_menu.selected)
        else
         instring = chr(84 + symbol_menu.selected)
        end if
       end if
     end select
     if len(instring) > 0 then
      temp = left(temp, pos_x - 1) + instring + mid(temp, pos_x)
      lines.Assign(pos_y, left(temp, w))
      if len(temp) > w then lines.Insert(pos_y + 1, mid(temp, w + 1))
      cursor_x += len(instring)
      if cursor_x - x > w then
       cursor_x = x + pos_x + len(instring) - w
       cursor_y += 1
       if cursor_y - y > h then
        cursor_y -= 1
        topline += 1
       end if
      end if
     end if

    end if

   case else
    pos_y = cursor_y - y + topline - 1
    pos_x = cursor_x - x
    temp = Pad(lines.ItemAt(pos_y), pos_x - 1,, FF4Text(" "))
    'if len(temp) < pos_x then temp = String(pos_x - len(temp), asc(FF4Text(" ")))
    temp = left(temp, pos_x - 1) + FF4Text(chr(a)) + mid(temp, pos_x)
    if len(temp) > w then
     dim found as boolean
     for i as Integer = pos_y + 1 to lines.Length()
      if len(lines.ItemAt(i)) < w then
       lines.Assign(i, right(temp, 1) + lines.ItemAt(i))
       found = true
       exit for
      end if
     next
     if not found then lines.Append(right(temp, 1))
    elseif len(temp) = w then
     lines.Append("")
    end if
    lines.Assign(pos_y, left(temp, w))
    if cursor_x - x + 1 <= w then
     cursor_x += 1
    else
     cursor_x = x + 1
     if cursor_y - y + 1 <= h then cursor_y += 1 else topline += 1
    end if
  end select
 loop until done

end sub
