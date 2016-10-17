sub ReadVisualFX()

 dim temp as String
 
 for i as Integer = 1 to 256
  vfx.Append(FF4Text("Visual effect " + Pad(str(i - 1), 3, true)))
 next
 
 open "config/visualfx.dat" for input as #1
  do until eof(1)
   line input #1, temp
   vfx.Assign(val(left(temp, 2)) + 1, FF4Text(mid(temp, 5)))
  loop
 close #1

end sub
