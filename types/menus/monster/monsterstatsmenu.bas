type MonsterStatsMenu

 x as UByte
 y as UByte
 index as UByte
 attack as UByte
 defense as UByte
 mdef as UByte
 speed as UByte
 main_menu as BlueMenu
 indexed_stat_group_menu as BlueMenu
 stat_group_menu as BlueMenu
 indexed_speed_group_menu as BlueMenu
 speed_group_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(new_index as UByte)
 declare sub UpdateMenu()
 declare sub UserSelect()

end type
