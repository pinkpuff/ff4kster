constructor ToolInformationMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 main_menu = BlueMenu(x, y)

end constructor


sub ToolInformationMenu.Display()

 dim temp as String
 
 main_menu.ChangeOption(1, FF4Text("Name:        ") + name, 15)
 main_menu.ChangeOption(2, FF4Text("Price:       " + Pad(PriceName(price), 6)), 15)
 if description + 1 <= item_descriptions.Length() then 
  temp = item_descriptions.ItemAt(description + 1)
 else
  temp = FF4Text("N/A")
 end if
 main_menu.ChangeOption(3, FF4Text("Description: ") + Pad(temp, 19,, FF4Text(" ")), 15)
 
 main_menu.Display()

end sub


sub ToolInformationMenu.SetTo(index as UByte)

 name = tools(index).name
 price = tools(index).price_code
 description = tools(index).description

end sub


sub ToolInformationMenu.UserSelect()

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
     
    case 3 'Description
     if description + 1 <= item_descriptions.Length() then description = ListItem(x + 13, y + 2, item_descriptions, description + 1) - 1
   
   end select
   
   Display()
   
  end if
 
 loop

end sub
