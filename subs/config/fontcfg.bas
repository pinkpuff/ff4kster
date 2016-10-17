sub ReadFontConfig()
 
 'Reads the config file specifying the character conversion from ASCII text
 ' to FF4 text.
 
 dim temp as String
 
 asc2ff4 = String(&hFF, &hC5)
 open "config\font.dat" for input as #1
  do until eof(1)
   line input #1, temp
   'The character on the left corresponds to the array index, and the hex code
   ' on the right corresponds to the hex code of the FF4 letter.
   mid(asc2ff4, asc(left(temp, 1)), 1) = chr(val("&h" + right(temp, 2)))
  loop
 close #1
 
end sub
