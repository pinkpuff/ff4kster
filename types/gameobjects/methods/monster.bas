sub Monster.ReadFromROM(index as UByte)

 dim start as UInteger
 dim ptraddress as UInteger
 dim temp as UByte
 
 start = &h71A00 + (index - 1) * 8
 for i as Integer = 0 to 7
  name += chr(ByteAt(start + i))
 next
 
 start = &h72200 + (index - 1) * 2
 gil = ByteAt(start) + ByteAt(start + 1) * &h100
 
 start = &h723C0 + (index - 1) * 2
 xp = ByteAt(start) + ByteAt(start + 1) * &h100
 
 start = &h7CC00 + (index - 1) * 4
 size = ByteAt(start)
 pal = ByteAt(start + 1)
 gfx_ptr1 = ByteAt(start + 2)
 gfx_ptr2 = ByteAt(start + 3)
 
 ptraddress = &h728A0 + (index - 1) * 2
 start = ByteAt(ptraddress) + ByteAt(ptraddress + 1) * &h100 - &hA860 + &h72A60
 
 temp = ByteAt(start)
 if temp and &h80 then boss = true else boss = false
 level = temp mod &h80
 hp = ByteAt(start + 1) + ByteAt(start + 2) * &h100
 physical_attack_index = ByteAt(start + 3)
 physical_defense_index = ByteAt(start + 4)
 magical_defense_index = ByteAt(start + 5)
 speed_index = ByteAt(start + 6)
 drop_index = ByteAt(start + 7) mod &h40
 drop_rate = ByteAt(start + 7) \ &h40
 attack_sequence_group = ByteAt(start + 8)
 temp = ByteAt(start + 9)
 has_attack_element = temp and &h80
 has_resistances = temp and &h40
 has_weaknesses = temp and &h20
 has_spell_power = temp and &h10
 has_race = temp and 8
 has_reaction = temp and 4
 
 start += 10
 
 if has_attack_element then
  attack_element.SetFlags(ByteAt(start), ByteAt(start + 1), ByteAt(start + 2))
  start += 3
 end if
 
 if has_resistances then
  resistances.SetFlags(ByteAt(start), ByteAt(start + 1), ByteAt(start + 2))
  start += 3
 end if
 
 if has_weaknesses then
  weaknesses.SetFlags(ByteAt(start), 0, 0)
  start += 1
 end if
 
 if has_spell_power then
  spell_power = ByteAt(start)
  start += 1
 end if
 
 if has_race then
  races.SetFlags(ByteAt(start), 0, 0)
  start += 1
 end if
 
 if has_reaction then
  reaction_index = ByteAt(start)
  start += 1
 end if

end sub


sub Monster.WriteToROM(index as UByte)

 dim start as UInteger
 dim ptraddress as UInteger
 dim temp as UByte
 
 start = &h71A00 + (index - 1) * 8
 for i as Integer = 0 to 7
  WriteByte(start + i, asc(mid(name, i + 1, 1)))
 next
 
 start = &h7CC00 + (index - 1) * 4
 'size = ByteAt(start)
 'pal = ByteAt(start + 1)
 'gfx_ptr1 = ByteAt(start + 2)
 'gfx_ptr2 = ByteAt(start + 3)
 WriteByte(start, size)
 WriteByte(start + 1, pal)
 WriteByte(start + 2, gfx_ptr1)
 WriteByte(start + 3, gfx_ptr2)
  
 start = &h72200 + (index - 1) * 2
 WriteByte(start, gil mod &h100)
 WriteByte(start + 1, gil \ &h100)
 
 start = &h723C0 + (index - 1) * 2
 WriteByte(start, xp mod &h100)
 WriteByte(start + 1, xp \ &h100)

 ptraddress = &h728A0 + (index - 1) * 2
 start = ByteAt(ptraddress) + ByteAt(ptraddress + 1) * &h100 - &hA860 + &h72A60
 
 temp = level
 if boss then temp += &h80
 WriteByte(start, temp)
 WriteByte(start + 1, hp mod &h100)
 WriteByte(start + 2, hp \ &h100)
 WriteByte(start + 3, physical_attack_index)
 WriteByte(start + 4, physical_defense_index)
 WriteByte(start + 5, magical_defense_index)
 WriteByte(start + 6, speed_index)
 WriteByte(start + 7, drop_index + drop_rate * &h40)
 WriteByte(start + 8, attack_sequence_group)
 temp = 0
 if has_attack_element then temp += &h80
 if has_resistances then temp += &h40
 if has_weaknesses then temp += &h20
 if has_spell_power then temp += &h10
 if has_race then temp += 8
 if has_reaction then temp += 4
 WriteByte(start + 9, temp)
 
 start += 10
 
 if has_attack_element then
  for i as Integer = 0 to 2
   temp = 0
   for j as Integer = 1 to 8
    if attack_element.flags(i * 8 + j) then temp += 2 ^ (j - 1)
   next
   WriteByte(start + i, temp)
  next
  start += 3
 end if
 
 if has_resistances then
  for i as Integer = 0 to 2
   temp = 0
   for j as Integer = 1 to 8
    if resistances.flags(i * 8 + j) then temp += 2 ^ (j - 1)
   next
   WriteByte(start + i, temp)
  next
  start += 3
 end if
 
 if has_weaknesses then
  temp = 0
  for j as Integer = 1 to 8
   if weaknesses.flags(j) then temp += 2 ^ (j - 1)
  next
  WriteByte(start, temp)
  start += 1
 end if
 
 if has_spell_power then
  WriteByte(start, spell_power)
  start += 1
 end if
 
 if has_race then
  temp = 0
  for j as Integer = 1 to 8
   if races.flags(j) then temp += 2 ^ (j - 1)
  next
  WriteByte(start, temp)
  start += 1
 end if
 
 if has_reaction then
  WriteByte(start, reaction_index)
  start += 1
 end if

 if index < total_monsters then
  start = start - &h72A60 + &hA860
  ptraddress = &h728A0 + (index - 0) * 2
  WriteByte(ptraddress, start mod &h100)
  WriteByte(ptraddress + 1, start \ &h100)
 end if

end sub
