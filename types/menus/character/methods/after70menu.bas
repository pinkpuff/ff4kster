constructor After70Menu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 stat_menu(1) = StatUpMenu(x, y + 3)
 stat_menu(2) = StatUpMenu(x + 5, y + 3)
 stat_menu(3) = StatUpMenu(x, y + 13)
 stat_menu(4) = StatUpMenu(x + 5, y + 13)
 stat_menu(5) = StatUpMenu(x, y + 23)
 stat_menu(6) = StatUpMenu(x + 5, y + 23)
 stat_menu(7) = StatUpMenu(x, y + 33)
 stat_menu(8) = StatUpMenu(x + 5, y + 33)

end constructor


sub After70Menu.ApplyUpdates(index as UByte)

 for i as Integer = 1 to 8
  for j as Integer = 1 to 5
   characters(index).after70(i).stat(j) = stat_menu(i).stat(j)
  next
  characters(index).after70(i).amount = stat_menu(i).bonus
 next

end sub

sub After70Menu.Display()

 BlueBox(x, y, 8, 1)
 WriteText(FF4Text("After 70"), x + 1, y + 1)
 for i as Integer = 1 to 8
  stat_menu(i).Display()
 next

end sub


sub After70Menu.SetTo(index as UByte)

 for i as Integer = 1 to 8
  stat_menu(i).SetTo(characters(index).after70(i))
 next

end sub


sub After70Menu.UserSelect()

 dim select_menu as BlueMenu
 
 select_menu = BlueMenu(x + 11, y + 3)
 select_menu.columns = 2
 for i as Integer = 1 to 8
  select_menu.AddOption(FF4Text(str(i)))
 next
 
 do
  select_menu.UserSelect()
  if not select_menu.cancelled then
   stat_menu(select_menu.selected).UserSelect() 
  end if
 loop until select_menu.cancelled

end sub
