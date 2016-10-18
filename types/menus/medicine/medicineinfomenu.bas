type MedicineInformationMenu

 x as UByte
 y as UByte
 main_menu as BlueMenu
 name as String
 price as UByte
 visual as UByte
 description as UByte
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(index as UByte)
 declare sub UserSelect()

end type
