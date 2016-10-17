sub ReadTargetTypes()

 dim temp as String
 
 for i as Integer = 1 to total_targets
  targets.Append(FF4Text("Target type " + str(i - 1)))
 next
 
 open "config/targets.dat" for input as #1
  do until eof(1)
   line input #1, temp
   targets.Assign(val(left(temp, 1)) + 1, FF4Text(mid(temp, 3)))
  loop
 close #1

end sub
