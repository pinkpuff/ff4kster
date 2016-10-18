type Tool

 name as String
 price_code as UByte
 description as UByte
 
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte)

end type
