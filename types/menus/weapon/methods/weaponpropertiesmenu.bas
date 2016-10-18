constructor WeaponPropertiesMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 flag_menu = BlueMenu(x, y)
 for i as Integer = 1 to total_weapon_properties
  flag_menu.AddOption(weapon_property_names.ItemAt(i), 0)
 next

end constructor


sub WeaponPropertiesMenu.Display()

 for i as Integer = 1 to total_weapon_properties
  if flags(i) then
   flag_menu.ChangeOption(i,, 14)
  else
   flag_menu.ChangeOption(i,, 0)
  end if
 next
 
 flag_menu.Display()
 
end sub


sub WeaponPropertiesMenu.UserSelect()

 flag_menu.cancelled = false
 do until flag_menu.cancelled
  flag_menu.UserSelect()
  if not flag_menu.cancelled then
   flags(flag_menu.selected) = not flags(flag_menu.selected)
   Display()
  end if
 loop

end sub
