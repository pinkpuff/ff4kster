constructor ArmorInformationMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 main_menu = BlueMenu(x, y)

end constructor


sub ArmorInformationMenu.Display()

 dim temp as String
 
 main_menu.ChangeOption(1, FF4Text("Name:        ") + name, 15)
 main_menu.ChangeOption(2, FF4Text("Price:       " + Pad(PriceName(price), 6)), 15)
 main_menu.ChangeOption(3, FF4Text("Defense:     " + Pad(str(defense), 3)), 15)
 main_menu.ChangeOption(4, FF4Text("Evade:       " + Pad(str(evade), 3)), 15)
 main_menu.ChangeOption(5, FF4Text("M.Defense:   " + Pad(str(magic_defense), 3)), 15)
 main_menu.ChangeOption(6, FF4Text("M.Evade:     " + Pad(str(magic_evade), 3)), 15)
 main_menu.ChangeOption(7, FF4Text("Metallic:    " + YesNo(metallic)), 15)
 'main_menu.ChangeOption(8, FF4Text("Part:        " + str(part)), 15)
 if description + 1 <= item_descriptions.Length() then
  temp = item_descriptions.ItemAt(description + 1)
 else
  temp = FF4Text("N/A")
 end if
 main_menu.ChangeOption(8, FF4Text("Description: ") + Pad(temp, 19,, FF4Text(" ")), 15)
 
 main_menu.Display()

end sub


sub ArmorInformationMenu.SetTo(index as UByte)

 name = armors(index).name
 price = armors(index).price_code
 defense = armors(index).defense
 evade = armors(index).evade
 magic_defense = armors(index).magic_defense
 magic_evade = armors(index).magic_evade
 metallic = armors(index).metallic
 part = armors(index).part
 description = armors(index).description
 
end sub


sub ArmorInformationMenu.UserSelect()

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

    case 3 'Defense
     dim edit_defense as BlueNumberInput
     edit_defense = BlueNumberInput(x + 13, y + 2)
     edit_defense.starting_number = defense
     edit_defense.UserSelect()
     defense = edit_defense.number

    case 4 'Evade
     dim edit_evade as BlueNumberInput
     edit_evade = BlueNumberInput(x + 13, y + 3)
     edit_evade.starting_number = evade
     edit_evade.UserSelect()
     evade = edit_evade.number

    case 5 'Magic Defense
     dim edit_mdef as BlueNumberInput
     edit_mdef = BlueNumberInput(x + 13, y + 4)
     edit_mdef.starting_number = magic_defense
     edit_mdef.UserSelect()
     magic_defense = edit_mdef.number

    case 6 'Magic Evade
     dim edit_mev as BlueNumberInput
     edit_mev = BlueNumberInput(x + 13, y + 5)
     edit_mev.starting_number = magic_evade
     edit_mev.UserSelect()
     magic_evade = edit_mev.number

    case 7 'Metallic
     metallic = not metallic
     
    'case 8 'Part
     'dim edit_part as BlueNumberInput
     'edit_part = BlueNumberInput(x + 13, y + 7)
     'edit_part.max_value = 3
     'edit_part.starting_number = part
     'edit_part.UserSelect()
     'part = edit_part.number
     
    case 8 'Description
     if description + 1 <= item_descriptions.Length() then description = ListItem(x + 13, y + 7, item_descriptions, description + 1) - 1

   end select

   Display()

  end if

 loop

end sub

