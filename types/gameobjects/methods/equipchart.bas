sub EquipChart.ReadFromROM(index as UByte)

 dim start as UInteger = &h7a750
 
 for j as Integer = 0 to 7
  if ByteAt(start + (index - 1) * 2) and 2^j then flags(j + 1) = true else flags(j + 1) = false
 next
 for j as Integer = 0 to 7
  if ByteAt(start + (index - 1) * 2 + 1) and 2^j then flags(8 + j + 1) = true else flags(8 + j + 1) = false
 next
 
end sub


sub EquipChart.WriteToROM(index as UByte)

 dim start as UInteger = &h7A750
 dim temp as UByte
 
 for i as Integer = 0 to 7
  if flags(i + 1) then temp += 2^i
 next
 WriteByte(start + (index - 1) * 2, temp)
 
 temp = 0
 for i as Integer = 0 to 7
  if flags(8 + i + 1) then temp += 2^i
 next
 WriteByte(start + (index - 1) * 2 + 1, temp)
 
 'for j as Integer = 0 to 7
  'flags(j + 1) = ByteAt(start + (index - 1) * 2) and 2^j
 'next
 'for j as Integer = 0 to 5
  'flags(8 + j + 1) = ByteAt(start + (index - 1) * 2 + 1) and 2^j
 'next
 
end sub
