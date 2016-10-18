type MonsterGfxMenu

 x as UByte
 y as UByte
 index as UByte
 gfx_ptr as UInteger
 size as UByte
 pal as UByte
 main_menu as BlueMenu
 gfx_menu as BlueMenu
 size_menu as BlueMenu
 special_size_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(new_index as UByte)
 declare sub UpdateMenu()
 declare sub UserSelect()

end type
