sub ReadMonsterGfxNames()

 dim temp as String
 
 open "config/monstergfxpointers.dat" for input as #1
  do until eof(1)
   line input #1, temp
   monstergfxnames.Assign(FF4Text(mid(temp, 11)), left(temp, 9))
  loop
 close #1

end sub
