sub Spell.ReadFromROM(index as UByte)

 dim start as UInteger
 
 if index <= total_player_spells then
  for i as Integer = 0 to 5
   name += chr(ByteAt(&h78B06 + (index - 1) * 6 + i))
  next
 else
  for i as Integer = 0 to 7
   name += chr(ByteAt(&h78B06 + (total_player_spells) * 6 + (index - total_player_spells - 1) * 8 + i))
  next
 end if
 
 start = &h799A6
 
 casting_time = ByteAt(start + (index - 1) * 6) mod &h20
 target = ByteAt(start + (index - 1) * 6) \ &h20
 power = ByteAt(start + (index - 1) * 6 + 1)
 if ByteAt(start + (index - 1) * 6 + 2) and &h80 then boss = false else boss = true
 hit = ByteAt(start + (index - 1) * 6 + 2) mod &h80
 if ByteAt(start + (index - 1) * 6 + 3) and &h80 then damage = false else damage = true
 effect = ByteAt(start + (index - 1) * 6 + 3) mod &h80
 if ByteAt(start + (index - 1) * 6 + 4) and &h80 then impact = true else impact = false
 element_code = ByteAt(start + (index - 1) * 6 + 4) mod &h80
 if ByteAt(start + (index - 1) * 6 + 5) and &h80 then reflectable = false else reflectable = true
 mp_cost = ByteAt(start + (index - 1) * 6 + 5) mod &h80

 start = &h7A250
 
 colors = ByteAt(start + (index - 1) * 4)
 sprites = ByteAt(start + (index - 1) * 4 + 1)
 visual1 = ByteAt(start + (index - 1) * 4 + 2)
 visual2 = ByteAt(start + (index - 1) * 4 + 3)
 
 sound = ByteAt(&h7A550 + (index - 1))

end sub


sub Spell.WriteToROM(index as UByte)

 dim temp as UByte
 dim start as UInteger
 
 if index <= total_player_spells then
  for i as Integer = 0 to 5
   WriteByte(&h78B06 + (index - 1) * 6 + i, asc(mid(name, i + 1, 1)))
  next
 else
  for i as Integer = 0 to 7
   WriteByte(&h78B06 + (total_player_spells) * 6 + (index - total_player_spells - 1) * 8 + i, asc(mid(name, i + 1, 1)))
  next
 end if
 
 start = &h799A6
 
 temp = target * &h20 + casting_time
 WriteByte(start + (index - 1) * 6, temp)
 WriteByte(start + (index - 1) * 6 + 1, power)
 temp = hit
 if not boss then temp += &h80
 WriteByte(start + (index - 1) * 6 + 2, temp)
 temp = effect
 if not damage then temp += &h80
 WriteByte(start + (index - 1) * 6 + 3, temp)
 temp = element_code
 if impact then temp += &h80
 WriteByte(start + (index - 1) * 6 + 4, temp)
 temp = mp_cost
 if not reflectable then temp += &h80
 WriteByte(start + (index - 1) * 6 + 5, temp)

 start = &h7A250
 
 WriteByte(start + (index - 1) * 4, colors)
 WriteByte(start + (index - 1) * 4 + 1, sprites)
 WriteByte(start + (index - 1) * 4 + 2, visual1)
 WriteByte(start + (index - 1) * 4 + 3, visual2)
 
 WriteByte(&h7A550 + (index - 1), sound)

end sub
