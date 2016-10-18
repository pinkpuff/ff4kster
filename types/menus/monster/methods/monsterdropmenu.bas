constructor MonsterDropMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 main_menu = BlueMenu(x, y)
 
 item_menu = BlueMenu(x + 11, y)
 item_menu.max_rows = 1
 for i as Integer = 1 to total_items
  item_menu.AddOption(item_names.ItemAt(i))
 next

end constructor


sub MonsterDropMenu.Display()

 main_menu.Display()

end sub


sub MonsterDropMenu.SetDropIndex()

 common_drop = item_drops(drop_index + 1).common_drop
 uncommon_drop = item_drops(drop_index + 1).uncommon_drop
 rare_drop = item_drops(drop_index + 1).rare_drop
 mythic_drop = item_drops(drop_index + 1).mythic_drop

end sub


sub MonsterDropMenu.SetTo(new_index as UByte)

 index = new_index
 drop_rate = monsters(index).drop_rate
 drop_index = monsters(index).drop_index
 SetDropIndex()
 UpdateMenu()

end sub


sub MonsterDropMenu.UpdateMenu()

 main_menu.ChangeOption(1, FF4Text("Drop Rate: " + Pad(str(drop_rate), 3)), 15)
 main_menu.ChangeOption(2, FF4Text("Index:     " + Pad(str(drop_index), 3)), 15)
 main_menu.ChangeOption(3, FF4Text("Common:    ") + item_names.ItemAt(common_drop + 1), 15)
 main_menu.ChangeOption(4, FF4Text("Uncommon:  ") + item_names.ItemAt(uncommon_drop + 1), 15)
 main_menu.ChangeOption(5, FF4Text("Rare:      ") + item_names.ItemAt(rare_drop + 1), 15)
 main_menu.ChangeOption(6, FF4Text("Mythic:    ") + item_names.ItemAt(mythic_drop + 1), 15)

end sub


sub MonsterDropMenu.UserSelect()

 do
 
  main_menu.UserSelect()
  
  if not main_menu.cancelled then
  
   select case main_menu.selected
   
    case 1 'Drop rate
     dim n as BlueNumberInput
     n = BlueNumberInput(x + 11, y)
     n.max_value = 3
     n.starting_number = drop_rate
     n.UserSelect()
     drop_rate = n.number
     monsters(index).drop_rate = drop_rate
    
    case 2 'Index
     dim n as BlueNumberInput
     n = BlueNumberInput(x + 11, y + 1)
     n.starting_number = drop_index
     n.UserSelect()
     drop_index = n.number
     SetDropIndex()
     monsters(index).drop_index = drop_index
    
    case 3 'Common
     item_menu.y = y + 2
     item_menu.ChangeSelected(common_drop + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then
      common_drop = item_menu.selected - 1
      item_drops(drop_index + 1).common_drop = common_drop
     end if
    
    case 4 'Uncommon
     item_menu.y = y + 3
     item_menu.ChangeSelected(uncommon_drop + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then
      uncommon_drop = item_menu.selected - 1
      item_drops(drop_index + 1).uncommon_drop = uncommon_drop
     end if
    
    case 5 'Rare
     item_menu.y = y + 4
     item_menu.ChangeSelected(rare_drop + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then
      rare_drop = item_menu.selected - 1
      item_drops(drop_index + 1).rare_drop = rare_drop
     end if
    
    case 6 'Mythic
     item_menu.y = y + 5
     item_menu.ChangeSelected(mythic_drop + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then
      mythic_drop = item_menu.selected - 1
      item_drops(drop_index + 1).mythic_drop = mythic_drop
     end if
   
   end select
   UpdateMenu()
   Display()
  
  end if
  
 loop until main_menu.cancelled

end sub
