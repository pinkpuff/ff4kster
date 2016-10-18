sub EditArmors()

 dim select_armor as BlueMenu
 dim edit_armor as BlueMenu
 
 dim information_menu as ArmorInformationMenu
 dim element_menu as ElementMenu
 dim race_menu as RaceMenu
 dim equip_menu as EquipMenu
 dim stat_menu as StatMenu
 
 select_armor.swap_enabled = true
 select_armor.max_rows = screen_height
 for i as Integer = 1 to total_armors
  select_armor.AddOption(armors(i).name)
 next
 
 edit_armor.AddOption(FF4Text("Information"))
 edit_armor.AddOption(FF4Text("Element/status"))
 edit_armor.AddOption(FF4Text("Races"))
 edit_armor.AddOption(FF4Text("Equip"))
 edit_armor.AddOption(FF4Text("Stat Bonuses"))
 edit_armor.x = 78 - edit_armor.options.Width()
 
 information_menu = ArmorInformationMenu(11, 0)
 element_menu = ElementMenu(11, 10)
 stat_menu = StatMenu(11, 23)
 race_menu = RaceMenu(21, 23)
 equip_menu = EquipMenu(11, 33)
 
 do until select_armor.cancelled
 
  do
  
   information_menu.SetTo(select_armor.selected)
   element_menu.index = armors(select_armor.selected).element_code
   equip_menu.index = armors(select_armor.selected).equip_code
   
   for i as Integer = 1 to total_races
    race_menu.flags(i) = armors(select_armor.selected).races(i)
   next
   
   stat_menu.mod_index = armors(select_armor.selected).stat_mod
   for i as Integer = 1 to 5
    stat_menu.flags(i) = armors(select_armor.selected).stat_bonus(i)
   next
   
   information_menu.Display()
   element_menu.Display()
   race_menu.Display()
   equip_menu.Display()
   stat_menu.Display()

  loop until select_armor.UserInput()
  
  if not select_armor.cancelled then
  
   if select_armor.highlighted > 0 then
   
    swap armors(select_armor.selected), armors(select_armor.highlighted)
    item_names.Exchange(select_armor.selected + total_weapons + 2, select_armor.highlighted + total_weapons + 2)
    select_armor.options.Exchange(select_armor.selected, select_armor.highlighted)
    select_armor.highlighted = 0
   
   else
  
    edit_armor.UserSelect()
    
    if not edit_armor.cancelled then
    
     select case edit_armor.selected
     
      case 1 'Information
       information_menu.UserSelect()
       armors(select_armor.selected).name = information_menu.name
       item_names.Assign(select_armor.selected + total_weapons + 2, information_menu.name)
       select_armor.ChangeOption(select_armor.selected, information_menu.name)
       armors(select_armor.selected).price_code = information_menu.price
       armors(select_armor.selected).metallic = information_menu.metallic
       armors(select_armor.selected).defense = information_menu.defense
       armors(select_armor.selected).evade = information_menu.evade
       armors(select_armor.selected).magic_defense = information_menu.magic_defense
       armors(select_armor.selected).magic_evade = information_menu.magic_evade
       armors(select_armor.selected).part = information_menu.part
       armors(select_armor.selected).description = information_menu.description
       
      case 2 'Element/status
       element_menu.UserSelect()
       armors(select_armor.selected).element_code = element_menu.index
       
      case 3 'Races
       race_menu.UserSelect()
       for i as Integer = 1 to total_races
        armors(select_armor.selected).races(i) = race_menu.flags(i)
       next
       
      case 4 'Equip
       equip_menu.UserSelect()
       armors(select_armor.selected).equip_code = equip_menu.index
       
      case 5 'Stat Bonuses
       stat_menu.UserSelect()
       armors(select_armor.selected).stat_mod = stat_menu.mod_index
       for i as Integer = 1 to 5
        armors(select_armor.selected).stat_bonus(i) = stat_menu.flags(i)
       next
       
     end select
    
    end if
    
   end if
  
  end if

 loop

end sub
