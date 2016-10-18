sub EditShops()

 'Allows the user to edit the shop data.

 dim select_shop as BlueMenu
 dim edit_wares as BlueMenu
 dim temp as String
 
 for i as Integer = 1 to total_shops
  select_shop.AddOption(shop_names.ItemAt(i))
 next
 
 edit_wares.x = select_shop.options.Width() + 2
 
 cls
 
 do
   
  do
   
   edit_wares.ClearAll()
   for i as Integer = 1 to 8
    temp = FF4Text("Item " + str(i) + ": ")
    if shops(select_shop.selected).wares(i) = &hFF then 
     temp += space(9)
    else
     temp += item_names.ItemAt(shops(select_shop.selected).wares(i) + 1)
    end if
    edit_wares.AddOption(temp)
   next
 
   select_shop.Display()
   edit_wares.Display()
   
  loop until select_shop.UserInput()
  
  if not select_shop.cancelled then
   
   do
    edit_wares.UserSelect()
    if not edit_wares.cancelled then
     shops(select_shop.selected).wares(edit_wares.selected) = ListItem(edit_wares.x + 8, edit_wares.selected - 1, item_names, shops(select_shop.selected).wares(edit_wares.selected) + 1) - 1
     if shops(select_shop.selected).wares(edit_wares.selected) = &hFF then
      edit_wares.ChangeOption(edit_wares.selected, FF4Text("Item " + str(edit_wares.selected) + ": " + space(9)))
     else
      edit_wares.ChangeOption(edit_wares.selected, FF4Text("Item " + str(edit_wares.selected) + ": ") + item_names.ItemAt(shops(select_shop.selected).wares(edit_wares.selected) + 1))
     end if
     edit_wares.Display()
    end if
   loop until edit_wares.cancelled
   edit_wares.cancelled = false
   
  end if
  
 loop until select_shop.cancelled
 
end sub
