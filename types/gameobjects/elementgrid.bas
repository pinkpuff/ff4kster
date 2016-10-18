type ElementGrid
 
 flags(24) as Boolean
 
 declare sub ReadFromROM(index as UByte)
 declare sub SetFlags(byte1 as UByte, byte2 as UByte, byte3 as UByte)
 declare sub WriteToROM(index as UByte)
 
end type
