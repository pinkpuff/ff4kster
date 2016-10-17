sub ReadNPCSprites()

 dim temp as String
 
 for i as Integer = 0 to total_npc_sprites - 1
  npc_sprite_names.Append(FF4Text("Sprite " + str(i)))
 next
 
 open "config/npcsprites.dat" for input as #1
  do until eof(1)
   line input #1, temp
   npc_sprite_names.Assign(val(left(temp, 3)) + 1, FF4Text(mid(temp, 5)))
  loop
 close #1

end sub
