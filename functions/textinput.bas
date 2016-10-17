function TextInput(x as UByte, y as UByte, starting_text as String = "", text_width as UByte = 0) as String

 dim result as String = starting_text
 dim done as Boolean
 dim temp as UInteger
 
 if text_width = 0 then text_width = len(starting_text)
 BlueBox(x, y, text_width, 1)
 WriteText(starting_text, x + 1, y + 1)
 
 do until done
 
  temp = getkey
  
  select case temp
  
   case BACKSPACE_KEY
    if len(result) > 0 then result = left(result, len(result) - 1)
    
   case ENTER_KEY
    done = true
    
   case ESC_KEY
    result = starting_text
    done = true
    
   case else
    if len(result) < text_width then result += FF4Text(chr(temp))
  
  end select
 
 loop
 
 return result

end function
