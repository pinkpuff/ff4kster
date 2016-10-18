type SpellVisualMenu

 x as UByte
 y as UByte
 main_menu as BlueMenu
 colors as UByte
 sprites as UByte
 visual1 as UByte
 visual2 as UByte
 sound as UByte
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(index as UByte)
 declare sub UserSelect()

end type
