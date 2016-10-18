constructor CommandMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 main_menu = BlueMenu(x, y)
 command_menu = BlueMenu(x, y)
 command_menu.max_rows = 1
 command_menu.AddOption(FF4Text("-----"))
 for i as Integer = 1 to total_commands
  command_menu.AddOption(menucommands(i).name)
 next

end constructor


sub CommandMenu.Display()

 for i as Integer = 1 to 5
  if menu_command(i) = &hFF then
   main_menu.ChangeOption(i, FF4Text(space(5)), 15)
  else
   main_menu.ChangeOption(i, menucommands(menu_command(i) + 1).name, 15)
  end if
 next
 
 main_menu.Display()

end sub


sub CommandMenu.SetTo(index as UByte)

 for i as Integer = 1 to 5
  menu_command(i) = actors(index).menu_command(i)
 next

end sub


sub CommandMenu.UserSelect()

 main_menu.cancelled = false
 
 do until main_menu.cancelled
 
  main_menu.UserSelect()
  
  if not main_menu.cancelled then
   command_menu.y = main_menu.selected - 1
   if menu_command(main_menu.selected) = &hFF then
    command_menu.ChangeSelected(1)
   else
    command_menu.ChangeSelected(menu_command(main_menu.selected) + 2)
   end if
   command_menu.UserSelect()
   if not command_menu.cancelled then
    if command_menu.selected = 1 then
     menu_command(main_menu.selected) = &hFF
    else
     menu_command(main_menu.selected) = command_menu.selected - 2
    end if
   end if
  end if
  
  Display()
 
 loop

end sub
