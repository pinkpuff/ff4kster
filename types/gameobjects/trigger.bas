type Trigger

 x as UByte
 y as UByte
 warp as Boolean
 new_map as UByte
 new_x as UByte
 new_y as UByte
 facing as UByte
 treasure as Boolean
 trapped as Boolean
 formation as UByte
 item as Boolean
 contents as UByte
 event as UByte
 
 declare sub ReadFromROM(address as UInteger)
 declare sub WriteToROM(address as UInteger)

end type
