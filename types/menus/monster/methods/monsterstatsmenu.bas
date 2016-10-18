constructor MonsterStatsMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 main_menu = BlueMenu(x, y)

 indexed_stat_group_menu = BlueMenu(x + 13)
 indexed_stat_group_menu.max_rows = 1
 for i as Integer = 1 to total_stat_groups
  indexed_stat_group_menu.AddOption(FF4Text(Pad(str(i), 3, true) + ": " + Pad(str(stat_groups(i).stat_base), 3, true) + "  x" + Pad(str(stat_groups(i).multiplier), 3) + "  " + Pad(str(stat_groups(i).percentage), 3, true) + "%"))
 next
 
 stat_group_menu = BlueMenu(x + 17)
 stat_group_menu.columns = 3

 indexed_speed_group_menu = BlueMenu(x + 13, y + 3)
 indexed_speed_group_menu.max_rows = 1
 for i as Integer = 1 to total_speed_groups
  indexed_speed_group_menu.AddOption(FF4Text(Pad(str(i), 3, true) + ": " + Pad(str(speed_groups(i).low), 3, true) + " to  " + Pad(str(speed_groups(i).high), 3, true)))
 next
 
 speed_group_menu = BlueMenu(x + 17, y + 3)
 speed_group_menu.columns = 2

end constructor


sub MonsterStatsMenu.Display()

 main_menu.Display()
 
end sub


sub MonsterStatsMenu.SetTo(new_index as UByte)

 index = new_index
 attack = monsters(index).physical_attack_index + 1
 defense = monsters(index).physical_defense_index + 1
 mdef = monsters(index).magical_defense_index + 1
 speed = monsters(index).speed_index + 1
 UpdateMenu()

end sub


sub MonsterStatsMenu.UpdateMenu()

 main_menu.ChangeOption(1, FF4Text("Attack:      ") + indexed_stat_group_menu.options.ItemAt(attack), 15)
 main_menu.ChangeOption(2, FF4Text("Defense:     ") + indexed_stat_group_menu.options.ItemAt(defense), 15)
 main_menu.ChangeOption(3, FF4Text("Mg Defense:  ") + indexed_stat_group_menu.options.ItemAt(mdef), 15)
 main_menu.ChangeOption(4, FF4Text("Speed Index: ") + indexed_speed_group_menu.options.ItemAt(speed), 15)

end sub


sub MonsterStatsMenu.UserSelect()

 do
 
  main_menu.UserSelect()
  
  if not main_menu.cancelled then
  
   select case main_menu.selected
   
    case 1 'Attack
     indexed_stat_group_menu.y = y
     indexed_stat_group_menu.ChangeSelected(attack)
     indexed_stat_group_menu.UserSelect()
     if not indexed_stat_group_menu.cancelled then 
      attack = indexed_stat_group_menu.selected
      stat_group_menu.y = indexed_stat_group_menu.y
      dim n as BlueNumberInput
      n.y = indexed_stat_group_menu.y
      do
       stat_group_menu.ChangeOption(1, FF4Text(" " + Pad(str(stat_groups(attack).stat_base), 3, true)), 15)
       stat_group_menu.ChangeOption(2, FF4Text("x" + Pad(str(stat_groups(attack).multiplier), 3)), 15)
       stat_group_menu.ChangeOption(3, FF4Text(Pad(str(stat_groups(attack).percentage), 3, true) + "%"), 15)
       stat_group_menu.Display()
       stat_group_menu.UserSelect()
       if not stat_group_menu.cancelled then
        select case stat_group_menu.selected
         case 1 'Base
          n.x = x + 18
          n.max_value = 255
          n.starting_number = stat_groups(attack).stat_base
          n.UserSelect()
          stat_groups(attack).stat_base = n.number
         case 2 'Multiplier
          n.x = x + 24
          n.max_value = 255
          n.starting_number = stat_groups(attack).multiplier
          n.UserSelect()
          stat_groups(attack).multiplier = n.number
         case 3 'Percentage
          n.x = x + 30
          n.max_value = 99
          n.starting_number = stat_groups(attack).percentage
          n.UserSelect()
          stat_groups(attack).percentage = n.number
        end select
       end if
      loop until stat_group_menu.cancelled
      indexed_stat_group_menu.ChangeOption(attack, FF4Text(Pad(str(attack), 3, true) + ": " + Pad(str(stat_groups(attack).stat_base), 3, true) + "  x" + Pad(str(stat_groups(attack).multiplier), 3) + "  " + Pad(str(stat_groups(attack).percentage), 3, true) + "%"))
     end if
    
    case 2 'Defense
     indexed_stat_group_menu.y = y + 1
     indexed_stat_group_menu.ChangeSelected(defense)
     indexed_stat_group_menu.UserSelect()
     if not indexed_stat_group_menu.cancelled then
      defense = indexed_stat_group_menu.selected
      stat_group_menu.y = indexed_stat_group_menu.y
      dim n as BlueNumberInput
      n.y = indexed_stat_group_menu.y
      do
       stat_group_menu.ChangeOption(1, FF4Text(" " + Pad(str(stat_groups(defense).stat_base), 3, true)), 15)
       stat_group_menu.ChangeOption(2, FF4Text("x" + Pad(str(stat_groups(defense).multiplier), 3)), 15)
       stat_group_menu.ChangeOption(3, FF4Text(Pad(str(stat_groups(defense).percentage), 3, true) + "%"), 15)
       stat_group_menu.Display()
       stat_group_menu.UserSelect()
       if not stat_group_menu.cancelled then
        select case stat_group_menu.selected
         case 1 'Base
          n.x = x + 18
          n.max_value = 255
          n.starting_number = stat_groups(defense).stat_base
          n.UserSelect()
          stat_groups(defense).stat_base = n.number
         case 2 'Multiplier
          n.x = x + 24
          n.max_value = 255
          n.starting_number = stat_groups(defense).multiplier
          n.UserSelect()
          stat_groups(defense).multiplier = n.number
         case 3 'Percentage
          n.x = x + 30
          n.max_value = 99
          n.starting_number = stat_groups(defense).percentage
          n.UserSelect()
          stat_groups(defense).percentage = n.number
        end select
       end if
      loop until stat_group_menu.cancelled
      indexed_stat_group_menu.ChangeOption(defense, FF4Text(Pad(str(defense), 3, true) + ": " + Pad(str(stat_groups(defense).stat_base), 3, true) + "  x" + Pad(str(stat_groups(defense).multiplier), 3) + "  " + Pad(str(stat_groups(defense).percentage), 3, true) + "%"))
     end if
    
    case 3 'Magic defense
     indexed_stat_group_menu.y = y + 2
     indexed_stat_group_menu.ChangeSelected(mdef)
     indexed_stat_group_menu.UserSelect()
     if not indexed_stat_group_menu.cancelled then
      mdef = indexed_stat_group_menu.selected
      stat_group_menu.y = indexed_stat_group_menu.y
      dim n as BlueNumberInput
      n.y = indexed_stat_group_menu.y
      do
       stat_group_menu.ChangeOption(1, FF4Text(" " + Pad(str(stat_groups(mdef).stat_base), 3, true)), 15)
       stat_group_menu.ChangeOption(2, FF4Text("x" + Pad(str(stat_groups(mdef).multiplier), 3)), 15)
       stat_group_menu.ChangeOption(3, FF4Text(Pad(str(stat_groups(mdef).percentage), 3, true) + "%"), 15)
       stat_group_menu.Display()
       stat_group_menu.UserSelect()
       if not stat_group_menu.cancelled then
        select case stat_group_menu.selected
         case 1 'Base
          n.x = x + 18
          n.max_value = 255
          n.starting_number = stat_groups(mdef).stat_base
          n.UserSelect()
          stat_groups(mdef).stat_base = n.number
         case 2 'Multiplier
          n.x = x + 24
          n.max_value = 255
          n.starting_number = stat_groups(mdef).multiplier
          n.UserSelect()
          stat_groups(mdef).multiplier = n.number
         case 3 'Percentage
          n.x = x + 30
          n.max_value = 99
          n.starting_number = stat_groups(mdef).percentage
          n.UserSelect()
          stat_groups(mdef).percentage = n.number
        end select
       end if
      loop until stat_group_menu.cancelled
      indexed_stat_group_menu.ChangeOption(mdef, FF4Text(Pad(str(mdef), 3, true) + ": " + Pad(str(stat_groups(mdef).stat_base), 3, true) + "  x" + Pad(str(stat_groups(mdef).multiplier), 3) + "  " + Pad(str(stat_groups(mdef).percentage), 3, true) + "%"))
     end if
    
    case 4 'Speed Index
     indexed_speed_group_menu.ChangeSelected(speed)
     indexed_speed_group_menu.UserSelect()
     if not indexed_speed_group_menu.cancelled then
      speed = indexed_speed_group_menu.selected
      dim n as BlueNumberInput
      n.y = indexed_speed_group_menu.y
      do
       speed_group_menu.ChangeOption(1, FF4Text(" " + Pad(str(speed_groups(speed).low), 3, true) + " to"), 15)
       speed_group_menu.ChangeOption(2, FF4Text(Pad(str(speed_groups(speed).high), 3, true)), 15)
       speed_group_menu.Display()
       speed_group_menu.UserSelect()
       if not speed_group_menu.cancelled then
        select case speed_group_menu.selected
         case 1 'Low
          n.x = x + 18
          n.starting_number = speed_groups(speed).low
          n.UserSelect()
          speed_groups(speed).low = n.number
         case 2 'High
          n.x = x + 26
          n.starting_number = speed_groups(speed).high
          n.UserSelect()
          speed_groups(speed).high = n.number
        end select
       end if
      loop until speed_group_menu.cancelled
      indexed_speed_group_menu.ChangeOption(speed, FF4Text(Pad(str(speed), 3, true) + ": " + Pad(str(speed_groups(speed).low), 3, true) + " to  " + Pad(str(speed_groups(speed).high), 3, true)))
     end if
   
   end select
   UpdateMenu()
   Display()
  
  end if
  
 loop until main_menu.cancelled
 
 monsters(index).physical_attack_index = attack - 1
 monsters(index).physical_defense_index = defense - 1
 monsters(index).magical_defense_index = mdef - 1
 monsters(index).speed_index = speed - 1
 
end sub
