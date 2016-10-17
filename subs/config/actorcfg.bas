sub ReadActorNames()

 dim temp as String
 
 for i as Integer = 1 to total_actors
  actor_names.Append(FF4Text("Actor " + Pad(str(i), 2, true, "0")))
 next
 
 open "config/actors.dat" for input as #1
  do until eof(1)
   line input #1, temp
   actor_names.Assign(val(left(temp, 2)), FF4Text(mid(temp, 5)))
  loop
 close #1

end sub
