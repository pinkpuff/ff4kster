sub ReadFlagNames()

 dim temp as String
 
 for i as Integer = 0 to 255
  flag_names.Append(FF4Text("Flag " + Pad(str(i), 3, true)))
 next
 
 open "config/flags.dat" for input as #1
  do until eof(1)
   line input #1, temp
   flag_names.Assign(val(left(temp, 3)) + 1, FF4Text(mid(temp, 5)))
  loop
 close #1

end sub
