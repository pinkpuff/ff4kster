type RaceMenu

 x as UByte
 y as UByte
 flags(total_races) as Boolean
 flag_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub UserSelect()

end type
