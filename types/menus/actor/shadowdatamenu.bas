type ShadowDataMenu

 x as UByte
 y as UByte
 load_slot as UByte
 save_slot as UByte
 level_link as UByte
 load_initial as Boolean
 save_shadow as Boolean
 main_menu as BlueMenu
 save_menu as BlueMenu
 load_menu as BlueMenu
 link_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare function LoadString() as String
 declare function SaveString() as String
 
 declare sub Display()
 declare sub SetTo(index as UByte)
 declare sub UserSelect()

end type
