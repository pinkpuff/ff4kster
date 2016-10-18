sub DrawLetter(letter as UByte, x as UInteger, y as UInteger, c as Integer = 15, target as Any ptr = 0)
 
 'Draws a letter in the ROM font to the screen.
 ' letter -- Which character to draw
 ' x      -- X-coordinate of draw location
 ' y      -- Y-coordinate of draw location
 ' c      -- Color of text (omit for white)
 
 'Draw letter in specified location.
 
 dim actual_color as UInteger
 
 select case c
  case 0
   actual_color = RGB(0, 0, 0)
  case 10
   actual_color = RGB(0, 255, 0)
  case 12
   actual_color = RGB(255, 63, 63)
  case 14
   actual_color = RGB(255, 255, 0)
  case else
   actual_color = RGB(255, 255, 255)
 end select
 
 line target, (x * 8, y * 8)-((x + 1) * 8 - 1, (y + 1) * 8 - 1), actual_color, bf
 put target, (x * 8, y * 8), font(letter), trans

end sub
