sub SpecialSize.ReadFromROM(index as UByte)

 dim start as UInteger
 dim temp as UByte
 
 start = &h7D000 + (index - 1) * 5
 
 temp = ByteAt(start)
 x = temp mod &h10
 mystery_amount = temp \ &h10
 temp = ByteAt(start + 1)
 size_table_pointer = temp mod &h40
 mystery_bit1 = iif(temp and &h40, true, false)
 mystery_bit2 = iif(temp and &h80, true, false)
 palette_index = ByteAt(start + 2)
 mystery_byte = ByteAt(start + 3)
 arrangement_pointer = ByteAt(start + 4)

end sub


sub SpecialSize.WriteToROM(index as UByte)

 dim start as UInteger
 dim temp as UByte
 
 start = &h7D000 + (index - 1) * 5
 
 temp = x + mystery_amount * &h10
 WriteByte(start, temp)
 temp = size_table_pointer + iif(mystery_bit1, &h40, 0) + iif(mystery_bit2, &h80, 0)
 WriteByte(start + 1, temp)
 WriteByte(start + 2, palette_index)
 WriteByte(start + 3, mystery_byte)
 WriteByte(start + 4, arrangement_pointer)

end sub
