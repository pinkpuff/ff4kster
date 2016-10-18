type WeaponInformationMenu

 x as UByte
 y as UByte
 name as String
 price as UByte
 attack as UByte
 hit as UByte
 description as UByte
 main_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(index as UByte)
 declare sub UserSelect()

end type
