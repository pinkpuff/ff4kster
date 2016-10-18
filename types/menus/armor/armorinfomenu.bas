type ArmorInformationMenu

 x as UByte
 y as UByte
 main_menu as BlueMenu
 name as String
 price as UByte
 metallic as Boolean
 magic_evade as UByte
 defense as UByte
 evade as UByte
 magic_defense as UByte
 description as UByte
 part as UByte
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(index as UByte)
 declare sub UserSelect()

end type
