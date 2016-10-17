sub ReadWeaponAnimationNames()
 
 dim temp as String
 
 for i as Integer = 0 to total_palettes - 1
  palette_names.Append(FF4Text("Palette " + Pad(str(i), len(str(total_palettes - 1)), true, "0")))
 next
 
 for i as Integer = 0 to total_weapon_sprites - 1
  weapon_sprite_names.Append(FF4Text("Sprite " + Pad(str(i), len(str(total_weapon_sprites - 1)), true, "0")))
 next
 
 for i as Integer = 0 to total_swings - 1
  swing_names.Append(FF4Text("Swing " + Pad(str(i), len(str(total_swings - 1)), true, "0")))
 next
 
 for i as Integer = 0 to total_slashes - 1
  slash_names.Append(FF4Text("Slash " + Pad(str(i), len(str(total_slashes - 1)), true, "0")))
 next
  
 open "config\palettes.dat" for input as #1
  do until eof(1)
   line input #1, temp
   palette_names.Assign(val(left(temp, 2)) + 1, FF4Text(mid(temp, 5)))
  loop
 close #1
 
 open "config\weaponsprites.dat" for input as #1
  do until eof(1)
   line input #1, temp
   weapon_sprite_names.Assign(val(left(temp, 2)) + 1, FF4Text(mid(temp, 5)))
  loop
 close #1
 
 open "config\swings.dat" for input as #1
  do until eof(1)
   line input #1, temp
   swing_names.Assign(val(left(temp, 2)) + 1, FF4Text(mid(temp, 5)))
  loop
 close #1
 
 open "config\slashes.dat" for input as #1
  do until eof(1)
   line input #1, temp
   slash_names.Assign(val(left(temp, 2)) + 1, FF4Text(mid(temp, 5)))
  loop
 close #1
 
end sub
