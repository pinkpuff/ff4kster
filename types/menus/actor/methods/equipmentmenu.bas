constructor EquipmentMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 main_menu = BlueMenu(x, y)
 hand_menu = BlueMenu(x, y)
 head_menu = BlueMenu(x, y + 2)
 body_menu = BlueMenu(x, y + 3)
 arms_menu = BlueMenu(x, y + 4)
 hand_menu.max_rows = 1
 head_menu.max_rows = 1
 body_menu.max_rows = 1
 arms_menu.max_rows = 1
 hand_menu.AddOption(FF4Text("-----"))
 head_menu.AddOption(FF4Text("-----"))
 body_menu.AddOption(FF4Text("-----"))
 arms_menu.AddOption(FF4Text("-----"))
 for i as Integer = 1 to total_items
  if i = total_weapons + 1 then
   hand_menu.AddOption(FF4Text("-----"))
  elseif EquipsHand(i) then
   hand_menu.AddOption(item_names.ItemAt(i + 1))
  elseif IsHeadArmor(i) then
   head_menu.AddOption(item_names.ItemAt(i + 1))
  elseif IsBodyArmor(i) then
   body_menu.AddOption(item_names.ItemAt(i + 1))
  elseif IsArmsArmor(i) then
   arms_menu.AddOption(item_names.ItemAt(i + 1))
  end if
  'select case i
   'case 1 to total_weapons
    'hand_menu.Append(item_names.ItemAt(i))
   'case total_weapons + 1
    'hand_menu.Append(FF4Text("-----"))
   'case total_weapons + 2 to total_weapons + 14
    'hand_menu.Append(item_names.ItemAt(i))
   'case total_weapons + 15 to total_weapons + 34
    'head_menu.Append(item_names.ItemAt(i))
   'case total_weapons + 35 to total_weapons + 61
    'body_menu.Append(item_names.ItemAt(i))
   'case total_weapons + 62 to total_weapons + 81
    'arms_menu.Append(item_names.ItemAt(i))
  'end select
 next
 ammo_input = BlueNumberInput(x + 10, y)
 ammo_input.min_value = 1
 ammo_input.max_value = 99

end constructor


sub EquipmentMenu.Display()

 dim temp as String
 
 if starting_gear(1) = 0 then
  main_menu.ChangeOption(1, FF4Text(space(12)))
 else
  temp = FF4Text("   ")
  if right_ammo > 1 then temp = FF4Text(Pad(str(right_ammo), 3, true))
  main_menu.ChangeOption(1, item_names.ItemAt(starting_gear(1) + 1) + temp, 15)
 end if
 
 if starting_gear(2) = 0 then
  main_menu.ChangeOption(2, FF4Text(space(12)))
 else
  temp = FF4Text("   ")
  if left_ammo > 1 then temp = FF4Text(Pad(str(left_ammo), 3, true))
  main_menu.ChangeOption(2, item_names.ItemAt(starting_gear(2) + 1) + temp, 15)
 end if
 
 for i as Integer = 3 to 5
  if starting_gear(i) = 0 then
   main_menu.ChangeOption(i, FF4Text(space(12)))
  else
   main_menu.ChangeOption(i, item_names.ItemAt(starting_gear(i) + 1), 15)
  end if
 next
 
 main_menu.Display()

end sub


sub EquipmentMenu.SetTo(index as UByte)

 for i as Integer = 1 to 5
  starting_gear(i) = actors(index).starting_gear(i)
 next
 right_ammo = actors(index).right_ammo
 left_ammo = actors(index).left_ammo

end sub


sub EquipmentMenu.UserSelect()

 main_menu.cancelled = false
 
 do until main_menu.cancelled
 
  main_menu.UserSelect()
  
  if not main_menu.cancelled then
  
   select case main_menu.selected
   
    case 1 'Right hand
     hand_menu.y = y
     hand_menu.ChangeSelected(starting_gear(1) + 1)
     hand_menu.UserSelect()
     if not hand_menu.cancelled then
      starting_gear(1) = hand_menu.selected - 1
      if starting_gear(1) = 0 or starting_gear(1) = total_weapons + 1 then
       starting_gear(1) = 0
       right_ammo = 0
      else
       if IsArrow(starting_gear(1)) then
        ammo_input.y = y
        if right_ammo > 1 then ammo_input.starting_number = right_ammo else ammo_input.starting_number = 20
        Display()
        ammo_input.UserSelect()
        right_ammo = ammo_input.number
       else
        right_ammo = 1
       end if
      end if
     end if
   
    case 2 'Left hand
     hand_menu.y = y + 1
     hand_menu.ChangeSelected(starting_gear(2) + 1)
     hand_menu.UserSelect()
     if not hand_menu.cancelled then
      starting_gear(2) = hand_menu.selected - 1
      if starting_gear(2) = 0 or starting_gear(2) = total_weapons + 1 then
       starting_gear(2) = 0
       left_ammo = 0
      else
       if IsArrow(starting_gear(2)) then
        ammo_input.y = y + 1
        if right_ammo > 1 then ammo_input.starting_number = left_ammo else ammo_input.starting_number = 20
        Display()
        ammo_input.UserSelect()
        left_ammo = ammo_input.number
       else
        left_ammo = 1
       end if
      end if
     end if
     
    case 3 'Head
     if starting_gear(3) = 0 then
      head_menu.ChangeSelected(1)
     else
      head_menu.ChangeSelected(starting_gear(3) - (head_start - 1) + 1)
     end if
     head_menu.UserSelect()
     if not head_menu.cancelled then
      starting_gear(3) = head_menu.selected - 1 
      if starting_gear(3) > 0 then starting_gear(3) += (head_start - 1) 
     end if

    case 4 'Body
     if starting_gear(4) = 0 then
      body_menu.ChangeSelected(1)
     else
      body_menu.ChangeSelected(starting_gear(4) - (body_start - 1) + 1)
     end if
     body_menu.UserSelect()
     if not body_menu.cancelled then
      starting_gear(4) = body_menu.selected - 1
      if starting_gear(4) > 0 then starting_gear(4) += (body_start - 1) 
     end if

    case 5 'Arms
     if starting_gear(5) = 0 then
      arms_menu.ChangeSelected(1)
     else
      arms_menu.ChangeSelected(starting_gear(5) - (arms_start - 1) + 1)
     end if
     arms_menu.UserSelect()
     if not arms_menu.cancelled then
      starting_gear(5) = arms_menu.selected - 1
      if starting_gear(5) > 0 then starting_gear(5) += (arms_start - 1) 
     end if

   end select
   
   Display()
  
  end if
 
 loop

end sub
