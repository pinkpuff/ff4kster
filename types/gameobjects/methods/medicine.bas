sub Medicine.ReadFromROM(index as UByte)

 dim start as UInteger
 dim item_index as Integer
 
 for i as Integer = 0 to 8
  name += chr(ByteAt(&h78830 + (index - 1) * 9 + i))
 next
 
 start = &h79880
 
 casting_time = ByteAt(start + (index - 1) * 6) mod &h20
 target = ByteAt(start + (index - 1) * 6) \ &h20
 power = ByteAt(start + (index - 1) * 6 + 1)
 if ByteAt(start + (index - 1) * 6 + 2) and &h80 then boss = false else boss = true
 hit = ByteAt(start + (index - 1) * 6 + 2) mod &h80
 if ByteAt(start + (index - 1) * 6 + 3) and &h80 then impact = true else impact = false
 effect = ByteAt(start + (index - 1) * 6 + 3) mod &h80
 if ByteAt(start + (index - 1) * 6 + 4) and &h80 then damage = false else damage = true
 element_code = ByteAt(start + (index - 1) * 6 + 4) mod &h80
 if ByteAt(start + (index - 1) * 6 + 5) and &h80 then reflectable = false else reflectable = true
 mp_cost = ByteAt(start + (index - 1) * 6 + 5) mod &h80
 
 visual = ByteAt(&h7D790 + (index - 1))
 price_code = ByteAt(&h7A700 + (index - 1))
 
 item_index = index + total_weapons + total_armors + 2
 if item_index >= descriptions_start and item_index <= descriptions_end then
  description = ByteAt(&h7B000 + item_index - descriptions_start - 1)
 else
  description = &hFF
 end if

end sub


sub Medicine.WriteToROM(index as UByte)

 dim start as UInteger
 dim temp as UByte
 
 for i as Integer = 0 to 8
  WriteByte(&h78830 + (index - 1) * 9 + i, asc(mid(name, i + 1, 1)))
 next
 
 start = &h79880
 
 temp = target * &h20 + casting_time
 WriteByte(start + (index - 1) * 6, temp)
 WriteByte(start + (index - 1) * 6 + 1, power)
 if boss then temp = 0 else temp = &h80
 temp += hit
 WriteByte(start + (index - 1) * 6 + 2, temp)
 if impact then temp = &h80 else temp = 0
 temp += effect
 WriteByte(start + (index - 1) * 6 + 3, temp)
 if not damage then temp = &h80 else temp = 0
 temp += element_code
 WriteByte(start + (index - 1) * 6 + 4, temp)
 if reflectable then temp = 0 else temp = &h80
 temp += mp_cost
 WriteByte(start + (index - 1) * 6 + 5, temp)
 
 WriteByte(&h7D790 + (index - 1), visual)
 WriteByte(&h7A700 + (index - 1), price_code)

end sub
