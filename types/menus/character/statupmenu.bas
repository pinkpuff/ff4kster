type StatUpMenu

 x as UByte
 y as UByte
 stat(5) as Boolean
 bonus as UByte
 statflags as BlueMenu
 amount as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(s as StatLevelUp)
 declare sub UserSelect()

end type
