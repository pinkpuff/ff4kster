type EquipMenu

 x as UInteger
 y as UInteger
 flag_menu as BlueMenu
 index as UByte
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub UserSelect()

end type
