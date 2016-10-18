sub Character.ReadFromROM(index as UByte)

 dim start as UInteger 
 dim temp as UByte
 dim actor_index as UByte
 dim level_ptr as UInteger
 
 start = &h7AB00 + (index - 1) * &h20
 
 temp = ByteAt(start)
 character_id = temp mod 2^5
 'if temp and 2^5 then mystery_bit = true else mystery_bit = false
 if temp and 2^6 then left_handed = true else left_handed = false
 if temp and 2^7 then right_handed = true else right_handed = false
 
 temp = ByteAt(start + 1)
 sprite = temp mod 2^4
 
 level = ByteAt(start + 2)
 max_hp = ByteAt(start + 9) + ByteAt(start + 10) * &h100
 max_mp = ByteAt(start + 13) + ByteAt(start + 14) * &h100
 
 for i as Integer = 1 to 5
  stat(i) = ByteAt(start + 14 + i)
 next
 
 xp = ByteAt(start + &h17) + ByteAt(start + &h18) * &h100 + ByteAt(start + &h19) * &h10000
 tnl = ByteAt(start + &h1D) + ByteAt(start + &h1E) * &h100 + ByteAt(start + &h1F) * &h10000
 
 '=== DO NOT DELETE THIS PART ===
 'actor_index = 0
 'for i as Integer = 1 to total_actors
 ' if actors(i).load_initial and actors(i).load_slot = index - 1 then 
 '  actor_index = i
 '  exit for
 ' end if
 'next
 '=== I NEED TO TEST WHETHER THE GAME CHECKS LEVELUP DATA BY CHARACTER ID OR FIRST ACTOR ===
 actor_index = character_id
 
 start = &h7B700 + (actor_index - 1) * 2
 
 level_ptr = ByteAt(start) + ByteAt(start + 1) * &h100 + &h70200 + 5 * (level - 1)
 
 for i as Integer = level to 69
  levelup(i).stat_bonus.amount = ByteAt(level_ptr) mod 2^3
  for j as Integer = 1 to 5
   if ByteAt(level_ptr) and 2^(2 + j) then levelup(i).stat_bonus.stat(6-j) = true else levelup(i).stat_bonus.stat(6-j) = false
  next
  levelup(i).hp_bonus = ByteAt(level_ptr + 1)
  levelup(i).mp_bonus = ByteAt(level_ptr + 2) mod 2^5
  levelup(i).tnl = ByteAt(level_ptr + 3) + ByteAt(level_ptr + 4) * &h100 + (ByteAt(level_ptr + 2) \ 2^5) * &h10000
  level_ptr += 5
 next
 
 for i as Integer = 1 to 8
  after70(i).amount = ByteAt(level_ptr) mod 2^3
  for j as Integer = 1 to 5
   if ByteAt(level_ptr) and 2^(j + 2) then after70(i).stat(6 - j) = true else after70(i).stat(6 - j) = false
  next
  level_ptr += 1
 next
 
end sub


sub Character.WriteToROM(index as UByte)

 dim start as UInteger 
 dim temp as UByte
 dim actor_index as UByte
 dim level_ptr as UInteger
 
 start = &h7AB00 + (index - 1) * &h20
 
 temp = character_id
 if left_handed then temp += 2^6
 if right_handed then temp += 2^7
 WriteByte(start, temp)
 
 WriteByte(start + 1, sprite)
 
 WriteByte(start + 2, level)
 WriteByte(start + 7, max_hp mod &h100)
 WriteByte(start + 8, max_hp \ &h100)
 WriteByte(start + 9, max_hp mod &h100)
 WriteByte(start + 10, max_hp \ &h100)
 WriteByte(start + 11, max_mp mod &h100)
 WriteByte(start + 12, max_mp \ &h100)
 WriteByte(start + 13, max_mp mod &h100)
 WriteByte(start + 14, max_mp \ &h100)
 
 for i as Integer = 1 to 5
  WriteByte(start + 14 + i, stat(i))
 next
  
 WriteByte(start + &h17, xp mod &h100)
 WriteByte(start + &h18, (xp \ &h100) mod &h100)
 WriteByte(start + &h19, xp \ &h10000)
 WriteByte(start + &h1D, tnl mod &h100)
 WriteByte(start + &h1E, (tnl \ &h100) mod &h100)
 WriteByte(start + &h1F, tnl \ &h10000)
 
 '=== There's a different routine that saves the level up data
  
end sub
