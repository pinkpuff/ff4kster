type NPC

 sprite as UByte
 visible as Boolean
 speech as EventCall
 
 declare sub ReadFromROM(index as UInteger)
 declare sub WriteToROM(index as UInteger)

end type
