type FlagMenu

 flags(24) as Boolean
 flag_names as List
 main_menu as BlueMenu
 x as UByte
 y as UByte
 blank as Any ptr
 
 declare constructor()
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0, kind as String)
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0, names as List, settings as String)
 
 declare function FlagOfMenuIndex() as UByte
 declare function MenuIndexOfFlag(flag_index as UByte) as UByte
 
 declare sub CreateMainMenu()
 declare sub Display()
 declare sub Hide()
 declare sub SetFlag(flag_index as UByte, value as Boolean = true)
 declare sub UserSelect()

end type
