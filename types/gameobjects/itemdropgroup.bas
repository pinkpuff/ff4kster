type ItemDropGroup

 common_drop as UByte
 uncommon_drop as UByte
 rare_drop as UByte
 mythic_drop as UByte
 
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte)

end type
