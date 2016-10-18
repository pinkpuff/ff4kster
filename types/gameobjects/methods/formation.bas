function Formation.Preview() as String

 dim result as String
 
 for i as Integer = 1 to 3
  if monster_type(i) <= total_monsters then
   if i > 1 then result += FF4Text(", ")
   result += FF4Text(str(monster_qty(i)) + " ") + monsters(monster_type(i) + 1).name
  end if
 next
 
 return result

end function


sub Formation.ReadFromROM(index as UInteger)

 dim start as UInteger
 dim temp as UByte
 
 start = &h70200 + (index - 1) * 8
 
 temp = ByteAt(start)
 if temp and 1 then mystery_flag1 = true else mystery_flag1 = false
 if temp and 2 then mystery_flag2 = true else mystery_flag2 = false
 if temp and 4 then mystery_flag3 = true else mystery_flag3 = false
 if temp and 8 then back_attack = true else back_attack = false
 if temp and &h10 then boss_death = true else boss_death = false
 if temp and &h20 then egg(3) = true else egg(1) = false
 if temp and &h40 then egg(2) = true else egg(2) = false
 if temp and &h80 then egg(1) = true else egg(3) = false
 
 for i as Integer = 1 to 3
  monster_type(i) = ByteAt(start + i)
 next
 
 temp = ByteAt(start + 4)
 mystery_qty = temp mod 4
 for i as Integer = 1 to 3
  monster_qty(4 - i) = (temp \ 4^i) mod 4
 next
 
 arrangement = ByteAt(start + 5)
 
 temp = ByteAt(start + 6)
 if temp and 1 then no_flee = true else no_flee = false
 if temp and 2 then no_gameover = true else no_gameover = false
 if temp and 4 then battle_music = 1 else battle_music = 0
 if temp and 8 then battle_music += 2
 if temp and &h10 then character_battle = true else character_battle = false
 if temp and &h20 then auto_battle = true else auto_battle = false
 if temp and &h40 then floating = true else floating = false
 if temp and &h80 then transparent = true else transparent = false
 
 mystery_byte = ByteAt(start + 7)
 rewards = true
 
end sub


sub Formation.WriteToROM(index as UInteger)

 dim start as UInteger
 dim temp as UByte
 
 start = &h70200 + (index - 1) * 8
 
 temp = 0
 if mystery_flag1 then temp += 1
 if mystery_flag2 then temp += 2
 if mystery_flag3 then temp += 4
 if back_attack then temp += 8
 if boss_death then temp += &h10
 if egg(3) then temp += &h20
 if egg(2) then temp += &h40
 if egg(1) then temp += &h80
 WriteByte(start, temp)
 
 for i as Integer = 1 to 3
  WriteByte(start + i, monster_type(i))
 next
 
 temp = mystery_qty
 for i as Integer = 1 to 3
  temp += monster_qty(4 - i) * 4^i
 next
 WriteByte(start + 4, temp)
 
 WriteByte(start + 5, arrangement)
 
 temp = 0
 if no_flee then temp += 1
 if no_gameover then temp += 2
 if battle_music = 4 then temp += 3 * 4 else temp += battle_music * 4
 if character_battle then temp += &h10
 if auto_battle then temp += &h20
 if floating then temp += &h40
 if transparent then temp += &h80
 WriteByte(start + 6, temp)
 
 WriteByte(start + 7, mystery_byte)
 
end sub
