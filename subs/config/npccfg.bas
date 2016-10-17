sub ReadNPCNames()

 dim temp as String
 dim index as Integer
 
 for i as Integer = 1 to total_npcs
  npc_names.Append(FF4Text("NPC " + str(i)))
 next
 
 open "config/npcs.dat" for input as #1
  do until eof(1)
   line input #1, temp
   index = val(left(temp, 3)) + 1
   npc_names.Assign(index, FF4Text(mid(temp, 5)))
  loop
 close #1

end sub
