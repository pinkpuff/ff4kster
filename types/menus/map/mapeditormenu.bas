type MapEditorMenu

 x as UByte
 y as UByte
 palette_menu as GridMenu
 map_menu as GridMenu
 spaceused as UInteger
 map_index as UInteger
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 'declare function BytesUsed()
 
 declare sub Display()
 declare sub SetTo(map_index as UInteger)
 declare sub UserSelect()

end type
