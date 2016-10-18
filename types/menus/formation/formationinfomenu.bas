type FormationInfoMenu

 x as UByte
 y as UByte
 index as UInteger
 main_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(new_index as UInteger)
 declare sub UserSelect()

end type
