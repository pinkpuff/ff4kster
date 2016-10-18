sub Tool.ReadFromROM(index as UByte)

 dim item_index as Integer
 
 for i as Integer = 0 to 8
  name += chr(ByteAt(&h789CE + (index - 1) * 9 + i))
 next
 
 price_code = ByteAt(&h7A72E + (index - 1))
 
 item_index = index + total_weapons + total_armors + total_medicines + 2
 if item_index >= descriptions_start and item_index <= descriptions_end then
  description = ByteAt(&h7B000 + item_index - descriptions_start - 1)
 else
  description = &hFF
 end if

end sub


sub Tool.WriteToROM(index as UByte)

 for i as Integer = 0 to 8
  WriteByte(&h789CE + (index - 1) * 9 + i, asc(mid(name, i + 1, 1)))
 next
 
 WriteByte(&h7A72E + (index - 1), price_code)

end sub
