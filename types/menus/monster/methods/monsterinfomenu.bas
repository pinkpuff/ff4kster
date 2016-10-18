constructor MonsterInfoMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 main_menu = BlueMenu(x, y)

end constructor


sub MonsterInfoMenu.Display()

 main_menu.Display()

end sub


sub MonsterInfoMenu.SetTo(new_index as UByte)

 index = new_index
 name = monsters(index).name
 boss = monsters(index).boss
 level = monsters(index).level
 hp = monsters(index).hp
 xp = monsters(index).xp
 gil = monsters(index).gil
 UpdateMenu()

end sub


sub MonsterInfoMenu.UpdateMenu()

 main_menu.ChangeOption(1, FF4Text("Name:  ") + name, 15)
 main_menu.ChangeOption(2, FF4Text("Boss:  " + YesNo(boss)), 15)
 main_menu.ChangeOption(3, FF4Text("Level: " + Pad(str(level), 3)), 15)
 main_menu.ChangeOption(4, FF4Text("HP:    " + Pad(str(hp), 5)), 15)
 main_menu.ChangeOption(5, FF4Text("Exp:   " + Pad(str(xp), 5)), 15)
 main_menu.ChangeOption(6, FF4Text("Gil:   " + Pad(str(gil), 5)), 15)

end sub


sub MonsterInfoMenu.UserSelect()

 do
 
  main_menu.UserSelect()
  
  if not main_menu.cancelled then

   select case main_menu.selected

    case 1 'Name
     dim t as BlueTextInput
     t = BlueTextInput(x + 7, y)
     t.starting_text = name
     t.text_width = 8
     t.UserType()
     name = Pad(t.text, 8,, FF4Text(" "))

    case 2 'Boss
     boss = not boss

    case 3 'Level
     dim n as BlueNumberInput
     n = BlueNumberInput(x + 7, y + 2)
     n.starting_number = level
     n.UserSelect()
     level = n.number

    case 4 'HP
     dim n as BlueNumberInput
     n = BlueNumberInput(x + 7, y + 3)
     n.max_value = 2^16 - 1
     n.starting_number = hp
     n.UserSelect()
     hp = n.number

    case 5 'Exp
     dim n as BlueNumberInput
     n = BlueNumberInput(x + 7, y + 4)
     n.max_value = 2^16 - 1
     n.starting_number = xp
     n.UserSelect()
     xp = n.number

    case 6 'Gil
     dim n as BlueNumberInput
     n = BlueNumberInput(x + 7, y + 5)
     n.max_value = 2^16 - 1
     n.starting_number = gil
     n.UserSelect()
     gil = n.number

   end select
   UpdateMenu()
   Display()

  end if
  
 loop until main_menu.cancelled
 
 monsters(index).name = name
 monsters(index).boss = boss
 monsters(index).level = level
 monsters(index).hp = hp
 monsters(index).xp = xp
 monsters(index).gil = gil

end sub
