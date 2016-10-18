constructor SpellEffectMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y

 main_menu = BlueMenu(x, y)
 main_menu.AddOption(FF4Text("Effect:    "))
 main_menu.AddOption(FF4Text("Target:    "))
 main_menu.AddOption(FF4Text("Power:     "))
 main_menu.AddOption(FF4Text("Hit:       "))
 main_menu.AddOption(FF4Text("Delay:     "))
 main_menu.AddOption(FF4Text("MP Cost:   "))
 main_menu.AddOption(FF4Text("Reflects:  "))
 main_menu.AddOption(FF4Text("Hits Boss: "))
 main_menu.AddOption(FF4Text("Impact:    "))
 main_menu.AddOption(FF4Text("???:       "))

end constructor


sub SpellEffectMenu.Display()

 main_menu.ChangeOption(1, FF4Text("Effect:    ") + Pad(spell_effects.ItemAt(effect + 1), spell_effects.Width(),, FF4Text(" ")))
 main_menu.ChangeOption(2, FF4Text("Target:    ") + targets.ItemAt(target + 1))
 main_menu.ChangeOption(3, FF4Text("Power:     " + Pad(str(power), 3)))
 main_menu.ChangeOption(4, FF4Text("Hit:       " + Pad(str(hit), 3)))
 main_menu.ChangeOption(5, FF4Text("Delay:     " + Pad(str(casting_time), 3)))
 main_menu.ChangeOption(6, FF4Text("MP Cost:   " + Pad(str(mp_cost), 2)))
 main_menu.ChangeOption(7, FF4Text("Reflects:  " + YesNo(reflectable)))
 main_menu.ChangeOption(8, FF4Text("Hits Boss: " + YesNo(boss)))
 main_menu.ChangeOption(9, FF4Text("Impact:    " + YesNo(impact)))
 main_menu.ChangeOption(10, FF4Text("Damage:    " + YesNo(damage)))
 
 main_menu.Display()

end sub


sub SpellEffectMenu.SetTo(index as UByte)

 casting_time = spells(index).casting_time
 target = spells(index).target
 power = spells(index).power
 hit = spells(index).hit
 effect = spells(index).effect
 mp_cost = spells(index).mp_cost
 reflectable = spells(index).reflectable
 boss = spells(index).boss
 impact = spells(index).impact
 damage = spells(index).damage
 
end sub


sub SpellEffectMenu.UserSelect()

 main_menu.cancelled = false
 
 do until main_menu.cancelled
 
  main_menu.UserSelect()
  
  if not main_menu.cancelled then
  
   select case main_menu.selected
    
    case 1 'Effect
     effect = ListItem(x + 11, y, spell_effects, effect + 1) - 1
    
    case 2 'Target
     target = ListItem(x + 11, y + 1, targets, target + 1) - 1
    
    case 3 'Power
     dim n as BlueNumberInput
     n = BlueNumberInput(x + 11, y + 2)
     n.starting_number = power
     n.UserSelect()
     power = n.number
    
    case 4 'Hit
     dim n as BlueNumberInput
     n = BlueNumberInput(x + 11, y + 3)
     n.starting_number = hit
     n.max_value = 127
     n.UserSelect()
     hit = n.number
     
    case 5 'Delay
     dim n as BlueNumberInput
     n = BlueNumberInput(x + 11, y + 4)
     n.starting_number = casting_time
     n.max_value = 31
     n.UserSelect()
     casting_time = n.number
     
    case 6 'MP Cost
     dim n as BlueNumberInput
     n = BlueNumberInput(x + 11, y + 5)
     n.starting_number = mp_cost
     n.max_value = 99
     n.UserSelect()
     mp_cost = n.number
    
    case 7 'Reflects
     reflectable = not reflectable
    
    case 8 'Hits Boss
     boss = not boss
     
    case 9 'Impact
     impact = not impact
     
    case 10 'Damage
     damage = not damage
    
   end select
   
   Display()
   
  end if
 
 loop

end sub
