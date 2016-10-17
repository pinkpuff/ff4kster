function ListItem(x as UByte, y as UByte, list_items as List, starting_item as UInteger = 1) as UInteger
 
 dim result as UInteger
 dim list_item_menu as BlueMenu
 
 list_item_menu.x = x
 list_item_menu.y = y
 list_item_menu.max_rows = 1
 for i as UInteger = 1 to list_items.Length()
  list_item_menu.AddOption(list_items.ItemAt(i))
 next
 list_item_menu.selected = starting_item
 list_item_menu.top_row = starting_item
 
 list_item_menu.UserSelect()
 
 if list_item_menu.cancelled then
  result = starting_item
 else
  result = list_item_menu.selected
 end if
 
 return result

end function
