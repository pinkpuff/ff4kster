type MapGrid

 rom_pointer as UInteger
 tiles(32, 32) as UByte
 no_data as Boolean
 
 declare function BytesUsed() as Integer
 declare function RunLengthEncoding() as String
 
end type
