type CharacterStartingMenu

 x as UByte
 y as UByte
 character_id as UByte
 left_handed as Boolean
 right_handed as Boolean
 sprite as UByte
 level as UByte
 max_hp as UInteger
 max_mp as UInteger
 stat(5) as UByte
 xp as UInteger
 tnl as UInteger
 starting_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub ApplyUpdates(index as UByte)
 declare sub Display()
 declare sub SetTo(index as UByte)
 declare sub UserSelect()

end type
