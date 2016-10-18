type EventMenu

 x as UByte
 y as UByte
 edit_event as BlueMenu
 edit_else as BlueMenu
 edit_entry as ScriptEntryMenu
 really_clear_event as BlueMenu
 blank as Any ptr
 index as Integer
 map_link as UInteger
 actual_maps as List
 actual_maps_else as List

 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(new_index as Integer)
 declare sub UserSelect()

end type
