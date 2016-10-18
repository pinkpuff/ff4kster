type StatMenu
 
 x as UByte
 y as UByte
 flags(5) as Boolean
 flag_menu as BlueMenu
 mod_index as UByte
 index_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare function Bonus(index as UByte) as String
 declare function Penalty(index as UByte) as String
 
 declare sub Display()
 declare sub UserSelect()
 
end type
