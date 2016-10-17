sub ReadMonsterSizeNames()

 dim temp as String
 
 for i as Integer = 1 to 256
  monstersizenames.Append(FF4Text(str(i - 1)))
 next
 
 open "config/monstersizes.dat" for input as #1
  do until eof(1)
   line input #1, temp
   monstersizenames.Assign(val(left(temp, 3)) + 1, FF4Text(mid(temp, 5)))
  loop
 close #1

end sub
