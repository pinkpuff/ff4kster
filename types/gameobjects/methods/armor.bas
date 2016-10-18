sub Armor.ReadFromROM(index as UByte)

 dim start as UInteger
 dim item_index as Integer
 
 start = &h79600

 if ByteAt(start + index * 8) and &h80 then metallic = true else metallic = false
 magic_evade = ByteAt(start + index * 8) mod &h80
 defense = ByteAt(start + index * 8 + 1)
 evade = ByteAt(start + index * 8 + 2)
 magic_defense = ByteAt(start + index * 8 + 3)
 part = ByteAt(start + index * 8 + 4) \ &h40
 element_code = ByteAt(start + index * 8 + 4) mod &h40
 for i as Integer = 1 to total_races
  if ByteAt(start + index * 8 + 5) and 2^(i - 1) then races(i) = true else races(i) = false
 next
 equip_code = ByteAt(start + index * 8 + 6) mod &h20
 stat_mod = ByteAt(start + index * 8 + 7) mod 8
 for i as Integer = 0 to 4
  if ByteAt(start + index * 8 + 7) and 2^(i + 3) then stat_bonus(5 - i) = true
 next
 
 for i as Integer = 0 to 8
  name += chr(ByteAt(&h78560 + index * 9 + i))
 next
 
 price_code = ByteAt(&h7A6B0 + index)
 
 item_index = index + total_weapons + 2
 if item_index >= descriptions_start and item_index <= descriptions_end then
  description = ByteAt(&h7B000 + item_index - descriptions_start - 1)
 else
  description = &hFF
 end if 
 
end sub


sub Armor.WriteToROM(index as UByte)

 dim start as UInteger
 dim temp as UByte
 
 start = &h79600
 
 if metallic then temp = &h80
 temp += magic_evade
 WriteByte(start + index * 8, temp)
 WriteByte(start + index * 8 + 1, defense)
 WriteByte(start + index * 8 + 2, evade)
 WriteByte(start + index * 8 + 3, magic_defense)
 if index + total_weapons + 2 <= head_start then
  part = 2
 else
  part = 0
 end if
 WriteByte(start + index * 8 + 4, part * &h40 + element_code)
 temp = 0
 for i as Integer = 1 to total_races
  if races(i) then temp += 2^(i - 1)
 next
 WriteByte(start + index * 8 + 5, temp)
 WriteByte(start + index * 8 + 6, equip_code)
 temp = stat_mod
 for i as Integer = 0 to 4
  if stat_bonus(5 - i) then temp += 2^(i + 3)
 next
 WriteByte(start + index * 8 + 7, temp)
 
 for i as Integer = 0 to 8
  WriteByte(&h78560 + index * 9 + i, asc(mid(name, i + 1, 1)))
 next
 
 WriteByte(&h7A6B0 + index, price_code)
 
end sub
