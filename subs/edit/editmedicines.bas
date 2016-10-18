sub EditMedicines()

 dim select_medicine as BlueMenu
 dim edit_medicine as BlueMenu
 dim information_menu as MedicineInformationMenu
 dim effect_menu as SpellEffectMenu
 dim element_menu as ElementMenu
 
 for i as Integer = 1 to total_medicines
  select_medicine.AddOption(medicines(i).name)
 next
 
 edit_medicine.AddOption(FF4Text("Information"))
 edit_medicine.AddOption(FF4Text("Effect"))
 edit_medicine.AddOption(FF4Text("Element/Status"))
 edit_medicine.x = 78 - edit_medicine.options.Width()
 
 information_menu = MedicineInformationMenu(11, 0)
 effect_menu = SpellEffectMenu(11, 6)
 element_menu = ElementMenu(11, 18)
 
 do until select_medicine.cancelled
 
  do
  
   information_menu.SetTo(select_medicine.selected)
   effect_menu.casting_time = medicines(select_medicine.selected).casting_time
   effect_menu.target = medicines(select_medicine.selected).target
   effect_menu.power = medicines(select_medicine.selected).power
   effect_menu.hit = medicines(select_medicine.selected).hit
   effect_menu.effect = medicines(select_medicine.selected).effect
   effect_menu.mp_cost = medicines(select_medicine.selected).mp_cost
   effect_menu.reflectable = medicines(select_medicine.selected).reflectable
   effect_menu.boss = medicines(select_medicine.selected).boss
   effect_menu.impact = medicines(select_medicine.selected).impact
   effect_menu.damage = medicines(select_medicine.selected).damage
   element_menu.index = medicines(select_medicine.selected).element_code
   
   information_menu.Display()
   effect_menu.Display()
   element_menu.Display()
  
  loop until select_medicine.UserInput()
  
  if not select_medicine.cancelled then
  
   edit_medicine.cancelled = false
   edit_medicine.UserSelect()
   
   if not edit_medicine.cancelled then
   
    select case edit_medicine.selected
    
     case 1 'Information 
      information_menu.UserSelect()
      medicines(select_medicine.selected).name = information_menu.name
      item_names.Assign(select_medicine.selected + total_weapons + total_armors + 2, information_menu.name)
      select_medicine.ChangeOption(select_medicine.selected, information_menu.name)
      medicines(select_medicine.selected).price_code = information_menu.price
      medicines(select_medicine.selected).visual = information_menu.visual
      medicines(select_medicine.selected).description = information_menu.description
      
     case 2 'Effect
      effect_menu.UserSelect()
      medicines(select_medicine.selected).casting_time = effect_menu.casting_time
      medicines(select_medicine.selected).target = effect_menu.target
      medicines(select_medicine.selected).power = effect_menu.power
      medicines(select_medicine.selected).hit = effect_menu.hit
      medicines(select_medicine.selected).effect = effect_menu.effect
      medicines(select_medicine.selected).mp_cost = effect_menu.mp_cost
      medicines(select_medicine.selected).reflectable = effect_menu.reflectable
      medicines(select_medicine.selected).boss = effect_menu.boss
      medicines(select_medicine.selected).impact = effect_menu.impact
      medicines(select_medicine.selected).damage = effect_menu.damage
      
     case 3 'Element/Status
      element_menu.UserSelect()
      medicines(select_medicine.selected).element_code = element_menu.index
      
    end select
    
   end if
   
  end if
 
 loop
 
end sub
