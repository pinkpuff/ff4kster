type After70Menu

 x as UByte
 y as UByte
 stat(5) as Boolean
 amount as UByte
 stat_menu(8) as StatUpMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub ApplyUpdates(index as UByte)
 declare sub Display()
 declare sub SetTo(index as UByte)
 declare sub UserSelect()

end type
