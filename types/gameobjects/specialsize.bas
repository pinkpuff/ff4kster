type SpecialSize

 x as UByte
 mystery_amount as UByte
 size_table_pointer as UByte
 mystery_bit1 as Boolean
 mystery_bit2 as Boolean
 palette_index as UByte
 mystery_byte as UByte
 arrangement_pointer as UByte
  
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte)

end type
