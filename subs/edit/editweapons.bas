sub EditWeapons()
 
 dim select_weapon as BlueMenu
 dim edit_weapon as BlueMenu
 dim information_menu as WeaponInformationMenu
 dim element_menu as ElementMenu
 dim stat_menu as StatMenu
 dim race_menu as RaceMenu
 dim casts_menu as CastsMenu
 dim animation_menu as WeaponAnimationMenu
 dim equip_menu as EquipMenu
 dim properties_menu as WeaponPropertiesMenu
 dim immutables as BlueMenu

 'Set up weapon selection menu
 select_weapon.swap_enabled = true
 select_weapon.max_rows = screen_height
 for i as Integer = 1 to total_weapons
  select_weapon.AddOption(weapons(i).name)
 next
 
 'Set up edit menu
 edit_weapon.AddOption(FF4Text("Information"))
 edit_weapon.AddOption(FF4Text("Element/Status"))
 edit_weapon.AddOption(FF4Text("Stat Bonuses"))
 edit_weapon.AddOption(FF4Text("Races"))
 edit_weapon.AddOption(FF4Text("Properties"))
 edit_weapon.AddOption(FF4Text("Equip"))
 edit_weapon.AddOption(FF4Text("Visuals"))
 edit_weapon.AddOption(FF4Text("Casts"))
 edit_weapon.x = 78 - edit_weapon.options.Width()
 
 'Position menu items on screen.
 information_menu = WeaponInformationMenu(11, 0)
 element_menu = ElementMenu(11, 7)
 stat_menu = StatMenu(11, 20)
 race_menu = RaceMenu(21, 20)
 properties_menu = WeaponPropertiesMenu(30, 20)
 equip_menu = EquipMenu(11, 30)
 animation_menu = WeaponAnimationMenu(11, 43)
 casts_menu = CastsMenu(11, 49)
 'immutables = BlueMenu(11, 52)
 
 ''Immutables can't be edited but they are displayed
 'immutables.AddOption(FF4Text("Two-handed"), 0)
 'immutables.AddOption(FF4Text("Auto-Berserk"), 0)
 'immutables.AddOption(FF4Text("Equips as Bow"), 0)
 'immutables.AddOption(FF4Text("Equips as Arrow"), 0)
 'immutables.AddOption(FF4Text("Key Item"), 0)
 
 do until select_weapon.cancelled

  do
  
   'Update menus with information for currently selected weapon
   information_menu.SetTo(select_weapon.selected)
   animation_menu.SetTo(select_weapon.selected)
   casts_menu.SetTo(select_weapon.selected)
   element_menu.index = weapons(select_weapon.selected).element_code
   equip_menu.index = weapons(select_weapon.selected).equip_code
     
   stat_menu.mod_index = weapons(select_weapon.selected).stat_amount
   for i as Integer = 1 to 5
    stat_menu.flags(i) = weapons(select_weapon.selected).stat_up(i)
   next
   
   for i as Integer = 1 to 8
    race_menu.flags(i) = weapons(select_weapon.selected).races(i)
   next
   
   for i as Integer = 1 to 8
    properties_menu.flags(i) = weapons(select_weapon.selected).property_flag(i)
   next
   
   'select case select_weapon.selected
    'case 25
     ''immutables.ChangeOption(1,, 0)
     'immutables.ChangeOption(2,, 0)
     'immutables.ChangeOption(3,, 0)
     'immutables.ChangeOption(4,, 0)
     ''immutables.ChangeOption(5,, 13)
    'case 68 to 75
     ''immutables.ChangeOption(1,, 13)
     'immutables.ChangeOption(2,, 0)
     'immutables.ChangeOption(3,, 0)
     'immutables.ChangeOption(4,, 0)
     ''immutables.ChangeOption(5,, 0)
    'case 76
     ''immutables.ChangeOption(1,, 13)
     'immutables.ChangeOption(2,, 13)
     'immutables.ChangeOption(3,, 0)
     'immutables.ChangeOption(4,, 0)
     ''immutables.ChangeOption(5,, 0)
    'case 77 to 83
     ''immutables.ChangeOption(1,, 0)
     'immutables.ChangeOption(2,, 0)
     'immutables.ChangeOption(3,, 13)
     'immutables.ChangeOption(4,, 0)
     ''immutables.ChangeOption(5,, 0)
    'case 84 to 95
     ''immutables.ChangeOption(1,, 0)
     'immutables.ChangeOption(2,, 0)
     'immutables.ChangeOption(3,, 0)
     'immutables.ChangeOption(4,, 13)
     ''immutables.ChangeOption(5,, 0)
    'case else
     ''immutables.ChangeOption(1,, 0)
     'immutables.ChangeOption(2,, 0)
     'immutables.ChangeOption(3,, 0)
     'immutables.ChangeOption(4,, 0)
     ''immutables.ChangeOption(5,, 0)
   'end select
   
   'if select_weapon.selected < twohanded_start or select_weapon.selected > twohanded_end then
    'immutables.ChangeOption(1,, 0)
   'else
    'immutables.ChangeOption(1,, 13)
   'end if
   
   'if select_weapon.selected = keyitem_special1 or select_weapon.selected = keyitem_special2 or select_weapon.selected >= keyitem_start then
    'immutables.ChangeOption(5,, 13)
   'else
    'immutables.ChangeOption(5,, 0)
   'end if
   
   'Display information for currently selected weapon
   stat_menu.Display()
   element_menu.Display()
   race_menu.Display()
   casts_menu.Display()
   animation_menu.Display()
   equip_menu.Display()
   information_menu.Display()
   properties_menu.Display()
   'immutables.Display()
   
  loop until select_weapon.UserInput()
  
  'Bring up editing menu  
  if not select_weapon.cancelled then
  
   if select_weapon.highlighted > 0 then
    
    swap weapons(select_weapon.highlighted), weapons(select_weapon.selected)
    select_weapon.options.Exchange(select_weapon.highlighted, select_weapon.selected)
    select_weapon.highlighted = 0
    
   else

    edit_weapon.cancelled = false
    edit_weapon.UserSelect()
    
    if not edit_weapon.cancelled then
    
     select case edit_weapon.selected
      
      case 1 'Information
       information_menu.UserSelect()
       weapons(select_weapon.selected).name = information_menu.name
       item_names.Assign(select_weapon.selected + 1, information_menu.name)
       weapons(select_weapon.selected).price_code = information_menu.price
       weapons(select_weapon.selected).attack = information_menu.attack
       weapons(select_weapon.selected).hit = information_menu.hit
       select_weapon.ChangeOption(select_weapon.selected, weapons(select_weapon.selected).name) 
       weapons(select_weapon.selected).description = information_menu.description
       
      case 2 'Element/Status
       element_menu.UserSelect()
       weapons(select_weapon.selected).element_code = element_menu.index
      
      case 3 'Stat Bonuses
       stat_menu.UserSelect()
       weapons(select_weapon.selected).stat_amount = stat_menu.mod_index
       for i as Integer = 1 to 5
        weapons(select_weapon.selected).stat_up(i) = stat_menu.flags(i)
       next
      
      case 4 'Races
       race_menu.UserSelect()
       for i as Integer = 1 to total_races
        weapons(select_weapon.selected).races(i) = race_menu.flags(i)
       next
       
      case 5 'Properties
       properties_menu.UserSelect()
       for i as Integer = 1 to total_weapon_properties
        weapons(select_weapon.selected).property_flag(i) = properties_menu.flags(i)
       next
       
      case 6 'Equip
       equip_menu.UserSelect()
       weapons(select_weapon.selected).equip_code = equip_menu.index
       
      case 7 'Visuals
       animation_menu.UserSelect()
       weapons(select_weapon.selected).visual_color = animation_menu.colors - 1
       weapons(select_weapon.selected).visual_sprite = animation_menu.sprite - 1
       weapons(select_weapon.selected).visual_swing = animation_menu.swing - 1
       weapons(select_weapon.selected).visual_slash = animation_menu.slash - 1
       
      case 8 'Casts
       casts_menu.UserSelect()
       weapons(select_weapon.selected).casts = casts_menu.casts
       weapons(select_weapon.selected).spell_gfx = casts_menu.visual
       weapons(select_weapon.selected).spell_power = casts_menu.power
      
     end select
     
    end if
   
   end if
    
  end if
  
 loop
 
end sub
