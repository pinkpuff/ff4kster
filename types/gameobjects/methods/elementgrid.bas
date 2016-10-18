sub ElementGrid.ReadFromROM(index as UByte)
 
 dim start as UInteger = &h7A790
 
 for i as Integer = 0 to 2
  for j as Integer = 0 to 7
   if ByteAt(start + index * 3 + i) and 2^j then flags(j * 3 + i + 1) = true else flags(j * 3 + i + 1) = false
  next
 next
  
end sub


sub ElementGrid.SetFlags(byte1 as UByte, byte2 as UByte, byte3 as UByte)

 for i as Integer = 0 to 7
  if byte1 and 2^i then flags(i + 1) = true else flags(i + 1) = false
 next

 for i as Integer = 0 to 7
  if byte2 and 2^i then flags(i + 1 + 8) = true else flags(i + 1 + 8) = false
 next

 for i as Integer = 0 to 7
  if byte3 and 2^i then flags(i + 1 + 16) = true else flags(i + 1 + 16) = false
 next

end sub


sub ElementGrid.WriteToROM(index as UByte)
 
 dim start as UInteger = &h7A790
 dim temp as UByte
 
 for i as Integer = 0 to 2
  temp = 0
  for j as Integer = 0 to 7
   if flags(j * 3 + i + 1) then temp += 2^j
  next
  WriteByte(start + index * 3 + i, temp)
 next 
 
end sub
