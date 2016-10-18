sub SaveLevelups()

 dim start as UInteger
 dim temp as UByte
 dim level_ptr(total_characters) as UInteger
 
 start = &h7B728

 for i as Integer = 1 to total_characters
  level_ptr(i) = start - &h70200 - (characters(i).level - 1) * 5
  for j as Integer = characters(i).level to 69
   temp = characters(i).levelup(j).stat_bonus.amount
   for k as Integer = 1 to 5
    if characters(i).levelup(j).stat_bonus.stat(6 - k) then temp += 2^(2 + k)
   next
   WriteByte(start, temp)
   WriteByte(start + 1, characters(i).levelup(j).hp_bonus)
   temp = characters(i).levelup(j).mp_bonus
   temp += (characters(i).levelup(j).tnl \ &h10000) * 2^5
   WriteByte(start + 2, temp)
   WriteByte(start + 3, characters(i).levelup(j).tnl mod &h100)
   WriteByte(start + 4, (characters(i).levelup(j).tnl \ &h100) mod &h100)
   start += 5
  next
  for j as Integer = 1 to 8
   temp = characters(i).after70(j).amount
   for k as Integer = 1 to 5
    if characters(i).after70(j).stat(6 - k) then temp += 2^(2 + k)
   next
   WriteByte(start, temp)
   start += 1
  next
 next
 
 start = &h7B700
 
 for i as Integer = 1 to total_actors
  WriteByte(start + (i - 1) * 2, level_ptr(actors(i).level_link) mod &h100)
  WriteByte(start + (i - 1) * 2 + 1, level_ptr(actors(i).level_link) \ &h100)
 next

end sub
