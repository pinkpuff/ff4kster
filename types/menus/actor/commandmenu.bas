type CommandMenu

 x as UByte
 y as UByte
 main_menu as BlueMenu
 command_menu as BlueMenu
 menu_command(5) as UByte
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(index as UByte)
 declare sub UserSelect()

end type
