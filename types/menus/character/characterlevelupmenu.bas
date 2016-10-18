type CharacterLevelUpMenu

 x as UByte
 y as UByte
 character_id as UByte
 level_menu as BlueMenu
 category_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub ApplyUpdates(index as UByte)
 declare sub Display()
 declare sub SetTo(index as UByte)
 declare sub UserSelect()

end type
