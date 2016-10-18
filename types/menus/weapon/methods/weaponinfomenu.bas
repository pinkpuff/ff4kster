constructor WeaponInformationMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 main_menu = BlueMenu(x, y)

end constructor


sub WeaponInformationMenu.Display()

 dim temp as String
 
 main_menu.ChangeOption(1, FF4Text("Name:        ") + name, 15)
 main_menu.ChangeOption(2, FF4Text("Price:       " + Pad(PriceName(price), 6)), 15)
 main_menu.ChangeOption(3, FF4Text("Attack:      " + Pad(str(attack), 3)), 15)
 main_menu.ChangeOption(4, FF4Text("Hit:         " + Pad(str(hit), 3)), 15)
 if description + 1 <= item_descriptions.Length() then
  temp = item_descriptions.ItemAt(description + 1)
 else
  temp = FF4Text("N/A")
 end if
 main_menu.ChangeOption(5, FF4Text("Description: ") + Pad(temp, 19,, FF4Text(" ")), 15)

 main_menu.Display()

end sub


sub WeaponInformationMenu.SetTo(index as UByte)

 name = weapons(index).name
 price = weapons(index).price_code
 attack = weapons(index).attack
 hit = weapons(index).hit
 description = weapons(index).description

end sub


sub WeaponInformationMenu.UserSelect()

 main_menu.cancelled = false

 do until main_menu.cancelled
 
  main_menu.UserSelect()

  if not main_menu.cancelled then

   select case main_menu.selected

    case 1 'Name
     dim t as BlueTextInput
     t = BlueTextInput(x + 13, y)
     t.starting_text = name
     t.text_width = 9
     t.UserType()
     name = Pad(t.text, 9,, FF4Text(" "))
    
    case 2 'Price
     dim price_list as List
     for i as Integer = 0 to &hFF
      price_list.Append(FF4Text(PriceName(&hFF - i)))
     next
     price = &h100 - ListItem(x + 13, y + 1, price_list, &h100 - price)
     price_list.Destroy()
     
    case 3 'Attack
     dim edit_attack as BlueNumberInput
     edit_attack = BlueNumberInput(x + 13, y + 2)
     edit_attack.starting_number = attack
     edit_attack.UserSelect()
     attack = edit_attack.number
     
    case 4 'Hit
     dim edit_hit as BlueNumberInput
     edit_hit = BlueNumberInput(x + 13, y + 3)
     edit_hit.starting_number = hit
     edit_hit.max_value = 99
     edit_hit.UserSelect()
     hit = edit_hit.number
     
    case 5 'Description
     if description + 1 <= item_descriptions.Length() then description = ListItem(x + 13, y + 4, item_descriptions, description + 1) - 1

   end select
   
   Display()

  end if

 loop

end sub
