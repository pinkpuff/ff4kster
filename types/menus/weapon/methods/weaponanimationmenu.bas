constructor WeaponAnimationMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 main_menu = BlueMenu(x, y)

 'main_menu.AddOption(FF4Text("Palette: ") + Pad(palette_names.ItemAt(colors), palette_names.Width(),, FF4Text(" ")))
 'main_menu.AddOption(FF4Text("Sprite:  ") + Pad(weapon_sprite_names.ItemAt(sprite), weapon_sprite_names.Width(),, FF4Text(" ")))
 'main_menu.AddOption(FF4Text("Swing:   ") + Pad(swing_names.ItemAt(swing), swing_names.Width(),, FF4Text(" ")))
 'main_menu.AddOption(FF4Text("Slash:   ") + Pad(slash_names.ItemAt(slash), slash_names.Width(),, FF4Text(" ")))
 
end constructor


sub WeaponAnimationMenu.Display()
 
 main_menu.ChangeOption(1, FF4Text("Palette: ") + Pad(palette_names.ItemAt(colors), palette_names.Width(),, FF4Text(" ")), 15)
 main_menu.ChangeOption(2, FF4Text("Sprite:  ") + Pad(weapon_sprite_names.ItemAt(sprite), weapon_sprite_names.Width(),, FF4Text(" ")), 15)
 main_menu.ChangeOption(3, FF4Text("Swing:   ") + Pad(swing_names.ItemAt(swing), swing_names.Width(),, FF4Text(" ")), 15)
 main_menu.ChangeOption(4, FF4Text("Slash:   ") + Pad(slash_names.ItemAt(slash), slash_names.Width(),, FF4Text(" ")), 15)
 main_menu.Display()
 
end sub


sub WeaponAnimationMenu.SetTo(index as UInteger)
 
 colors = weapons(index).visual_color + 1
 sprite = weapons(index).visual_sprite + 1
 swing = weapons(index).visual_swing + 1
 slash = weapons(index).visual_slash + 1
 
end sub


sub WeaponAnimationMenu.UserSelect()

 main_menu.cancelled = false
 do until main_menu.cancelled
 
  main_menu.UserSelect()
  if not main_menu.cancelled then
   select case main_menu.selected
    case 1 'Palette
     colors = ListItem(x + 9, y, palette_names, colors)
    case 2 'Sprite
     sprite = ListItem(x + 9, y + 1, weapon_sprite_names, sprite)
    case 3 'Swing
     swing = ListItem(x + 9, y + 2, swing_names, swing)
    case 4 'Slash
     slash = ListItem(x + 9, y + 3, slash_names, slash)
   end select
   Display()
  end if
 
 loop

end sub
