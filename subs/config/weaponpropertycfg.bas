sub ReadWeaponPropertyNames()

 dim temp as String
 
 for i as Integer = 1 to 8
  weapon_property_names.Append(FF4Text("Property " + str(i)))
 next
 
 open "config/weaponproperties.dat" for input as #1
  do until eof(1)
   line input #1, temp
   if val(left(temp, 1)) <= 8 then
    weapon_property_names.Assign(val(left(temp, 1)), FF4Text(mid(temp, 3)))
   end if
  loop
 close #1

end sub
