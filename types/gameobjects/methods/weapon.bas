sub Weapon.ReadFromROM(index as UByte)
 
 dim start as UInteger

 start = &h79300

 for i as UByte = 1 to 8
  if ByteAt(start + index * 8) and 2^(i - 1) then property_flag(i) = true else property_flag(i) = false
 next

 attack = ByteAt(start + index * 8 + 1)
 hit = ByteAt(start + index * 8 + 2) mod &h80
 casts = ByteAt(start + index * 8 + 3)
 element_code = ByteAt(start + index * 8 + 4)

 for i as UByte = 1 to 8
  if ByteAt(start + index * 8 + 5) and 2^(i - 1) then races(i) = true else races(i) = false
 next

 equip_code = ByteAt(start + index * 8 + 6) mod &h20
 if ByteAt(start + index * 8 + 6) and &h40 then
  property_flag(9) = true
 else
  property_flag(9) = false
 end if
 
 stat_amount = ByteAt(start + index * 8 + 7) mod 8
 for i as UByte = 0 to 4
  if ByteAt(start + index * 8 + 7) and 2^(i + 3) then
   stat_up(5 - i) = true
  else
   stat_up(5 - i) = false
  end if
 next

 start = &h7A010

 visual_color = ByteAt(start + index * 4)
 visual_sprite = ByteAt(start + index * 4 + 1)
 visual_slash = ByteAt(start + index * 4 + 2)
 visual_swing = ByteAt(start + index * 4 + 3)

 for i as UByte = 0 to 8
  name += chr(ByteAt(&h78200 + index * 9 + i))
 next

 spell_power = ByteAt(&h79270 + index)
 spell_gfx = ByteAt(&h7D6E0 + index)
 price_code = ByteAt(&h7A650 + index)
 
end sub


sub Weapon.WriteToROM(index as UByte)
 
 dim temp as UByte
 dim start as UInteger

 start = &h79300

 temp = 0
 for i as UByte = 1 to 8
  if property_flag(i) then temp += 2^(i - 1)
 next
 WriteByte(start + index * 8, temp)

 WriteByte(start + index * 8 + 1, attack)
 WriteByte(start + index * 8 + 2, hit)
 WriteByte(start + index * 8 + 3, casts)
 WriteByte(start + index * 8 + 4, element_code)

 temp = 0
 for i as UByte = 1 to 8
  if races(i) then temp += 2^(i - 1)
 next
 WriteByte(start + index * 8 + 5, temp)

 temp = equip_code
 if index >= arrow_start and index <= arrow_end then temp += &h40
 if index >= bow_start and index < arrow_start then temp += &h80
 WriteByte(start + index * 8 + 6, temp)

 temp = stat_amount
 for i as UByte = 0 to 4
  if stat_up(5 - i) then temp += 2^(i + 3)
 next
 WriteByte(start + index * 8 + 7, temp)

 start = &h7A010

 WriteByte(start + index * 4, visual_color)
 WriteByte(start + index * 4 + 1, visual_sprite)
 WriteByte(start + index * 4 + 2, visual_slash)
 WriteByte(start + index * 4 + 3, visual_swing)

 for i as UByte = 0 to 8
  WriteByte(&h78200 + index * 9 + i, asc(mid(name, i + 1, 1)))
 next

 WriteByte(&h79270 + index, spell_power)
 WriteByte(&h7D6E0 + index, spell_gfx)
 WriteByte(&h7A650 + index, price_code)
 
end sub
