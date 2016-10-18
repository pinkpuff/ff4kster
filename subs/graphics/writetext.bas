sub WriteText(s as String, x as Integer = -1, y as Integer = -1, c as UByte = 15, target as Any ptr = 0)
 
 'Writes a string of text in the ROM font to the screen.
 ' s -- The string of text to write.
 ' x -- X-coordinate of the write location (omit for cursor x)
 ' y -- Y-coordinate of the write location (omit for cursor y)
 ' c -- Color of text (omit for white)
 
 'Set defaults for omitted coordinates.
 if x < 0 then x = pos(0) - 1
 if y < 0 then y = csrlin - 1
 
 'Draw each letter in the string.
 for i as UInteger = 1 to len(s)
  DrawLetter(asc(mid(s, i, 1)), x + i - 1, y, c, target)
 next
 
 'Update the new cursor position.
 locate y, x
 
end sub
