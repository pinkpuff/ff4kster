type ElementMenu
 
 x as UByte
 y as UByte
 flag_menu as BlueMenu
 index as UByte
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 'declare function UserInput() as Boolean
 
 declare sub Display()
 declare sub UserSelect()
 
end type
