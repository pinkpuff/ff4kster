constructor FormationInfoMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 main_menu = BlueMenu(x, y)

end constructor


sub FormationInfoMenu.Display()

 dim temp as String
 
 for i as Integer = 1 to 3
  if formations(index).monster_type(i) = &hFF then
   temp = FF4Text(space(9)) 
  else
   temp = monsters(formations(index).monster_type(i) + 1).name + FF4Text(" ")
  end if
  temp += FF4Text(str(formations(index).monster_qty(i)))
  if formations(index).egg(i) then temp += FF4Text(" in an egg") else temp += FF4Text(space(10))
  main_menu.ChangeOption(i, FF4Text("Monster Type " + str(i) + ": ") + temp, 15)
 next
 main_menu.ChangeOption(4, FF4Text("Arrangement:    " + str(formations(index).arrangement)), 15)
 select case formations(index).battle_music
  case 0
   temp = "Regular"
  case 1
   temp = "Boss"
  case 2
   temp = "Fiend"
  case 3
   temp = "No change / no fanfare"
  case 4
   temp = "No change / play fanfare"
 end select
 main_menu.ChangeOption(5, FF4Text("Battle Music:   " + Pad(temp, 24)), 15)
 main_menu.ChangeOption(6, FF4Text("Floating:       " + YesNo(formations(index).floating)), 15)
 main_menu.ChangeOption(7, FF4Text("Prevent Flee:   " + YesNo(formations(index).no_flee)), 15)
 main_menu.ChangeOption(8, FF4Text("Boss Death:     " + YesNo(formations(index).boss_death)), 15)
 main_menu.ChangeOption(9, FF4Text("Prevent Losing: " + YesNo(formations(index).no_gameover)), 15)
 main_menu.ChangeOption(10, FF4Text("Versus Player:  " + YesNo(formations(index).character_battle)), 15)
 main_menu.ChangeOption(11, FF4Text("Auto Battle:    " + YesNo(formations(index).auto_battle)), 15)
 main_menu.ChangeOption(12, FF4Text("Back Attack:    " + YesNo(formations(index).back_attack)), 15)
 main_menu.ChangeOption(13, FF4Text("Transparent:    " + YesNo(formations(index).transparent)), 15)
 main_menu.ChangeOption(14, FF4Text("Mystery Byte:   " + str(formations(index).mystery_byte)), 15)
 main_menu.ChangeOption(15, FF4Text("Mystery Amount: " + str(formations(index).mystery_qty)), 15)
 main_menu.ChangeOption(16, FF4Text("Mystery Flag 1: " + YesNo(formations(index).mystery_flag1)), 15)
 main_menu.ChangeOption(17, FF4Text("Mystery Flag 2: " + YesNo(formations(index).mystery_flag2)), 15)
 main_menu.ChangeOption(18, FF4Text("Mystery Flag 3: " + YesNo(formations(index).mystery_flag3)), 15)
 main_menu.ChangeOption(19, FF4Text("Gives rewards:  " + YesNo(formations(index).rewards)), 15)
 main_menu.Display()
 
end sub


sub FormationInfoMenu.SetTo(new_index as UInteger)

 index = new_index

end sub


sub FormationInfoMenu.UserSelect()

 dim monster_names as BlueMenu
 dim qty_input as BlueNumberInput
 dim egg_menu as BlueMenu
 
 monster_names.x = x + 16
 monster_names.max_rows = 1
 for i as Integer = 1 to total_monsters
  monster_names.AddOption(monsters(i).name)
 next
 monster_names.AddOption(FF4Text("--none--"))
 
 qty_input.x = monster_names.x + 9
 qty_input.max_value = 3
 
 egg_menu.x = qty_input.x + 2
 egg_menu.max_rows = 1
 egg_menu.AddOption(FF4Text("normal"))
 egg_menu.AddOption(FF4Text("in an egg"))

 do
 
  main_menu.UserSelect()
  
  if not main_menu.cancelled then
  
   select case main_menu.selected
   
    case 1 to 3 'Monster types
     dim n as UByte
     n = main_menu.selected
     monster_names.y = y + n - 1
     if formations(index).monster_type(n) <= total_monsters then
      monster_names.ChangeSelected(formations(index).monster_type(n) + 1)
     else
      monster_names.ChangeSelected(monster_names.options.Length())
     end if
     monster_names.UserSelect()
     if not monster_names.cancelled then
      if monster_names.selected < monster_names.options.Length() then
       formations(index).monster_type(n) = monster_names.selected - 1
      else
       formations(index).monster_type(n) = &hFF
      end if
      Display()
      qty_input.y = monster_names.y
      qty_input.starting_number = formations(index).monster_qty(n)
      qty_input.UserSelect()
      formations(index).monster_qty(n) = qty_input.number
      Display()
      egg_menu.y = qty_input.y
      if formations(index).egg(n) then egg_menu.ChangeSelected(2) else egg_menu.ChangeSelected(1)
      egg_menu.UserSelect()
      if not egg_menu.cancelled then
       if egg_menu.selected = 1 then formations(index).egg(n) = false else formations(index).egg(n) = true
      end if
     end if
    
    case 2 'Monster type 2
    
    
    case 3 'Monster type 3
    
    
    case 4 'Arrangement
     dim enter_arrangement as BlueNumberInput
     enter_arrangement = BlueNumberInput(x + 16, y + 3)
     'enter_arrangement.max_value = &h91
     enter_arrangement.starting_number = formations(index).arrangement
     enter_arrangement.UserSelect()
     formations(index).arrangement = enter_arrangement.number
    
    case 5 'Battle music
     dim enter_music as BlueMenu
     enter_music = BlueMenu(x + 16, y + 4)
     enter_music.max_rows = 1
     enter_music.AddOption(FF4Text("Regular"))
     enter_music.AddOption(FF4Text("Boss"))
     enter_music.AddOption(FF4Text("Fiend"))
     enter_music.AddOption(FF4Text("No change / no fanfare"))
     enter_music.AddOption(FF4Text("No change / play fanfare"))
     enter_music.ChangeSelected(formations(index).battle_music + 1)
     enter_music.UserSelect()
     if not enter_music.cancelled then formations(index).battle_music = enter_music.selected - 1
    
    case 6 'Floating
     formations(index).floating = not formations(index).floating
    
    case 7 'Prevent flee
     formations(index).no_flee = not formations(index).no_flee
    
    case 8 'Boss death
     formations(index).boss_death = not formations(index).boss_death
    
    case 9 'Prevent losing
     formations(index).no_gameover = not formations(index).no_gameover
    
    case 10 'Versus player
     formations(index).character_battle = not formations(index).character_battle
    
    case 11 'Auto battle
     formations(index).auto_battle = not formations(index).auto_battle
    
    case 12 'Back attack
     formations(index).back_attack = not formations(index).back_attack
    
    case 13 'Transparent
     formations(index).transparent = not formations(index).transparent
    
    case 14 'Mystery byte
     dim enter_byte as BlueNumberInput
     enter_byte = BlueNumberInput(x + 16, y + 13)
     enter_byte.starting_number = formations(index).mystery_byte
     enter_byte.UserSelect()
     formations(index).mystery_byte = enter_byte.number
    
    case 15 'Mystery amount
     dim enter_byte as BlueNumberInput
     enter_byte = BlueNumberInput(x + 16, y + 14)
     enter_byte.max_value = 3
     enter_byte.starting_number = formations(index).mystery_qty
     enter_byte.UserSelect()
     formations(index).mystery_qty = enter_byte.number
    
    case 16 'Mystery flag 1
     formations(index).mystery_flag1 = not formations(index).mystery_flag1
    
    case 17 'Mystery flag 2
     formations(index).mystery_flag2 = not formations(index).mystery_flag2
    
    case 18 'Mystery flag 3
     formations(index).mystery_flag3 = not formations(index).mystery_flag3
     
    case 19 'Gives rewards
     formations(index).rewards = not formations(index).rewards
   
   end select
   
   Display()
   
  end if
 
 loop until main_menu.cancelled

end sub
