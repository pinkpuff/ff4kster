type MonsterDropMenu

 x as UByte
 y as UByte
 index as UByte
 drop_rate as UByte
 drop_index as UByte
 common_drop as UByte
 uncommon_drop as UByte
 rare_drop as UByte
 mythic_drop as UByte
 item_menu as BlueMenu
 main_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetDropIndex()
 declare sub SetTo(new_index as UByte)
 declare sub UpdateMenu()
 declare sub UserSelect()

end type
