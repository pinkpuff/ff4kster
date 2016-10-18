type MonsterInfoMenu

 x as UByte
 y as UByte
 index as UByte
 name as String
 boss as Boolean
 level as Byte
 hp as UInteger
 xp as UInteger
 gil as UInteger
 main_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(new_index as UByte)
 declare sub UpdateMenu()
 declare sub UserSelect()

end type
