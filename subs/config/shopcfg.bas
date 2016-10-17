sub ReadShopNames()
 
 'Reads the shop names from a config file.

 dim temp as String
 
 'Initialize the shop names to their numbers (e.g. "Shop 03").
 for i as Integer = 1 to total_shops
  shop_names.Append(FF4Text("Shop " + Pad(str(i), 2, true, "0")))
 next
 
 'Replace the names of certain shops as specified in the config file.
 open "config\shop.dat" for input as #1
  do until eof(1)
   line input #1, temp
   shop_names.Assign(val(left(temp, 2)), FF4Text(ltrim(rtrim(right(temp, len(temp) - instr(temp, ":"))))))
  loop
 close #1
 
end sub
