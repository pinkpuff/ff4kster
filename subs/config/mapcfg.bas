sub ReadMapNames()

 dim temp as String
 
 for i as Integer = 1 to total_maps
  map_names.Append(FF4Text("Map " + Pad(str(i), 3, true, "0")))
 next
 
 open "config/maps.dat" for input as #1
  do until eof(1)
   line input #1, temp
   map_names.Assign(val(left(temp, 3)), FF4Text(mid(temp, 5)))
  loop
 close #1

end sub
