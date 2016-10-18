constructor CastsMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 main_menu = BlueMenu(x, y)
 
 main_menu.AddOption(FF4Text("Casts:  " + Pad(spells(casts).name, 8)))
 main_menu.AddOption(FF4Text("Visual: " + Pad(spells(visual).name, 8)))
 main_menu.AddOption(FF4Text("Power:  " + Pad(str(power), 3)))
 
end constructor


sub CastsMenu.Display()

 main_menu.ChangeOption(1, FF4Text("Casts:  ") + Pad(spells(casts).name, 8,, FF4Text(" ")))
 main_menu.ChangeOption(2, FF4Text("Visual: ") + Pad(spells(visual).name, 8,, FF4Text(" ")))
 main_menu.ChangeOption(3, FF4Text("Power:  " + Pad(str(power), 3)))

 main_menu.Display()

end sub


sub CastsMenu.SetTo(index as UInteger)

 casts = weapons(index).casts
 visual = weapons(index).spell_gfx
 power = weapons(index).spell_power

end sub


sub CastsMenu.UserSelect()

 dim spellmenu as BlueMenu
 
 spellmenu.max_rows = 1
 for i as Integer = 1 to total_spells
  spellmenu.AddOption(spells(i - 1).name)
 next

 main_menu.cancelled = false
 do until main_menu.cancelled
  main_menu.UserSelect()
  if not main_menu.cancelled then
   select case main_menu.selected
    case 1 'Casts
     spellmenu.x = x + 8
     spellmenu.y = y
     spellmenu.ChangeSelected(casts + 1)
     spellmenu.UserSelect()
     if not spellmenu.cancelled then casts = spellmenu.selected - 1
     'casts = ListItem(x + 8, y, spell_names, casts + 1) - 1
     visual = casts
    case 2 'Visual
     spellmenu.x = x + 8
     spellmenu.y = y + 1
     spellmenu.ChangeSelected(visual + 1)
     spellmenu.UserSelect()
     if not spellmenu.cancelled then
      visual = spellmenu.selected - 1
     end if
     'visual = ListItem(x + 8, y + 1, spell_names, visual + 1) - 1
    case 3 'Power
     dim n as BlueNumberInput
     n = BlueNumberInput(x + 8, y + 2)
     n.starting_number = power
     n.UserSelect()
     power = n.number
   end select
   Display()
  end if
 loop

end sub
