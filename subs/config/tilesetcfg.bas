sub ReadTilesetNames()

 dim temp as String
 
 for i as Integer = 1 to total_tilesets
  tileset_names.Append(FF4Text("Tileset " + Pad(str(i), 2, true, "0")))
 next
 
 open "config/tilesets.dat" for input as #1
  do until eof(1)
   line input #1, temp
   tileset_names.Assign(val(left(temp, 2)), FF4Text(mid(temp, 4)))
  loop
 close #1

end sub
