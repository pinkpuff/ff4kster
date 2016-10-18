function MenuCommand.HasParameters(index as UByte) as Boolean

 dim temp as Boolean
 
 select case index
  case 1, 14, 24, 26
   temp = true
  case 8 to 12
   temp = true
  case 16 to 20
   temp = true
 end select
 
 return temp
 

end function


function MenuCommand.TargetsCorrectly(index as UByte) as Boolean

 return index = 8 or index = 9 or index = 11 or index = 12 or index = 16 or index = 17 or index = 22

end function


sub MenuCommand.ReadFromROM(index as UByte)

 dim start as UInteger
 dim total as UInteger
 
 start = &h7A9C6 + (index - 1) * 5
 for i as Integer = 0 to 4
  name += chr(ByteAt(start + i))
 next
 
 target_byte = ByteAt(&h9FFC3 + index - 1)
 target = (target_byte \ &h10) mod 8
 
 delay = ByteAt(&hA0089 + index - 1)
 
 disabling_persistent = ByteAt(&h9FF19 + (index - 1) * 2)
 disabling_temporary = ByteAt(&h9FF19 + (index - 1) * 2  + 1)
 
 charging_stance = ByteAt(&hB7E60 + (index - 1))
 action_stance = &hFF
 action_stance2 = &hFF
 action_stance3 = &hFF
 
 select case index
 
  case 1 'Fight
   misc_bytes(1) = ByteAt(&h1C864) 'Elemental multiplier - extra weak
   misc_bytes(2) = ByteAt(&h1C873) 'Elemental multiplier - weak
   misc_bytes(3) = ByteAt(&h1C882) 'Elemental multiplier - immune
   misc_bytes(4) = ByteAt(&h1C891) 'Elemental multiplier - resist
   misc_bytes(5) = ByteAt(&h1C8A6) 'Racial multiplier - weak
   misc_bytes(6) = ByteAt(&h1C8B9) 'Racial multiplier - resist
   misc_bytes(7) = ByteAt(&h1CA43) 'Caster bonus stat for determining status infliction chance
   misc_bytes(8) = ByteAt(&h1CA46) 'Target penalty stat for determining status infliction chance
   
  case 2 'Item
   action_stance = ByteAt(&h149B3)
   
  case 3 'White
   action_stance = ByteAt(&h148D4)
   
  case 4 'Black
   action_stance = ByteAt(&h148E1)
   
  case 5 'Call
   action_stance = ByteAt(&h1491A)
   
  case 6 'Dark Wave
   action_stance = ByteAt(&h14A5F)
   
  case 7 'Jump
   action_stance = ByteAt(&h14828)
   action_stance2 = ByteAt(&h14833)
   action_stance3 = ByteAt(&h146CD)
   
  case 8 'Recall
   action_stance = ByteAt(&h148E1)
   start = &h1EC22
   total = 0
   for i as Integer = 0 to 7
    success(i + 1) = ByteAt(start + i * 8) - total
    total += success(i + 1)
   next
   start = &h1EC26
   for i as Integer = 0 to 7
    spell(i + 1) = ByteAt(start + i * 8)
   next
   message(1) = ByteAt(&h1EC62)
  
  case 9 'Sing
   action_stance = ByteAt(&h148C7)
   spell(1) = ByteAt(&h1EB1D)
   spell(2) = ByteAt(&h1EB2A)
   spell(3) = ByteAt(&h1EB37)
   spell(4) = ByteAt(&h1EB40)
   spell(5) = ByteAt(&h1EB0D)
   misc_bytes(1) = ByteAt(&h1EB01)
   misc_bytes(2) = ByteAt(&h1EB04)
   message(1) = ByteAt(&h1EB18)
   message(2) = ByteAt(&h1EB25)
   message(3) = ByteAt(&h1EB32)
   message(4) = ByteAt(&h1EB3B)
   message(5) = ByteAt(&h1EB08)
  
  case 10 'Hide
   action_stance = ByteAt(&h147CB)
   misc_bytes(1) = ByteAt(&h1AD57) 'Auto-hide actor
   
  case 11 'Split
   action_stance = ByteAt(&h149B3)
   item_consumed = ByteAt(&h1E4E8)
   item_effect = ByteAt(&h1E532)
   item_visual = ByteAt(&h1E53D)
   message(1) = ByteAt(&h1E4F9)
   
  case 12 'Pray
   action_stance = ByteAt(&h149F3)
   success(1) = ByteAt(&h1EA56)
   spell(1) = ByteAt(&h1EA64)
   message(1) = ByteAt(&h1EA5D)
  
  case 13 'Aim
   action_stance = ByteAt(&h14A8A)
  
  case 14 'Charge
   message(1) = ByteAt(&h1EA1E)
   
  case 15 'Kick
   action_stance = ByteAt(&h1451D)
   
  case 16 'Bear
   spell(1) = ByteAt(&h1E897)
   message(1) = ByteAt(&h1E8A5)
   
  case 17 'Twin
   spell(1) = ByteAt(&h1E793) 'Normally Flare
   spell(2) = ByteAt(&h1E797) 'Normally Comet
   spell(3) = ByteAt(&h1E77C) 'Normally Double Meteor
   success(1) = ByteAt(&h1E783) 'Chance it will fail outright (x or higher)
   success(2) = ByteAt(&h1E78F) 'Chance it will be spell 2 (less than x)
   misc_bytes(1) = ByteAt(&h1E774) 'FuSoYa
   misc_bytes(2) = ByteAt(&h1E778) 'Golbez
   message(1) = ByteAt(&h1E6DC) 'Cancel message
   message(2) = ByteAt(&h1E787) 'Failure message
   
  case 18 'Boast
   action_stance = ByteAt(&h149AB)
   misc_bytes(1) = ByteAt(&h1ECD1) 'Stat
   misc_bytes(2) = ByteAt(&h1ECD4) 'Amount
   message(1) = ByteAt(&h1ECDF)
   
  case 19 'Cry
   action_stance = ByteAt(&h149AB)
   misc_bytes(1) = ByteAt(&h1ECF3) 'Read stat
   misc_bytes(2) = ByteAt(&h1ED0C) 'Write stat
   message(1) = ByteAt(&h1ED22) 'Message
   
  case 20 'Cover
   action_stance = ByteAt(&h149F3)
   disable_actor = ByteAt(&h18F62)
   cover_actor = ByteAt(&h18F66)
   if ByteAt(&h38D5D) = 0 then cover_by_job = false else cover_by_job = true
   
  case 21 'Peep
   action_stance = ByteAt(&h149AB)
   
  case 23 'Throw
   action_stance = ByteAt(&h1434C)
   
  case 24 'Steal
   action_stance = ByteAt(&h149F3)
   misc_bytes(1) = ByteAt(&h1E3F1) 'Base
   misc_bytes(2) = ByteAt(&h1E3F3) 'Bonus stat
   misc_bytes(3) = ByteAt(&h1E3F7) 'Penalty stat
   misc_bytes(4) = ByteAt(&h1E457) 'Slot
   message(1) = ByteAt(&h1E433) 'Damaged by enemy
   message(2) = ByteAt(&h1E43A) 'Couldn't steal
   message(3) = ByteAt(&h1E4CA) 'Stole item
   
  case 25 'Ninja
   action_stance = ByteAt(&h148E1)
   
  case 26 'Regen
   action_stance = ByteAt(&h149AB)
   regen_amount = ByteAt(&h1E5FE)
   if ByteAt(&h1E616) = 1 and ByteAt(&h1E624) = 0 then
    regen_freeze = false
   else
    regen_freeze = true
   end if
   message(1) = ByteAt(&h1E633)
 
 end select

end sub


sub MenuCommand.WriteToROM(index as UByte)

 dim start as UInteger
 dim total as UInteger
 
 start = &h7A9C6 + (index - 1) * 5
 for i as Integer = 0 to 4
  WriteByte(start + i, asc(mid(name, i + 1, 1)))
 next
 
 target_byte = target_byte mod &h10 + target * &h10 + (target_byte \ &h80) * &h80
 WriteByte(&h9FFC3 + index - 1, target_byte)
 WriteByte(&hA0089 + index - 1, delay)
 WriteByte(&h9FF19 + (index - 1) * 2, disabling_persistent)
 WriteByte(&h9FF19 + (index - 1) * 2 + 1, disabling_temporary) 
 WriteByte(&hB7E60 + (index - 1), charging_stance)
 
 select case index
 
  case 1 'Fight
   WriteByte(&h1C864, misc_bytes(1))
   WriteByte(&h1C873, misc_bytes(2))
   WriteByte(&h1C882, misc_bytes(3))
   WriteByte(&h1C891, misc_bytes(4))
   WriteByte(&h1C8A6, misc_bytes(5))
   WriteByte(&h1C8B9, misc_bytes(6))
   WriteByte(&h1CA43, misc_bytes(7))
   WriteByte(&h1CA46, misc_bytes(8))
   
  case 2 'Item
   WriteByte(&h149B3, action_stance)
   
  case 3 'White
   WriteByte(&h148D4, action_stance)
   
  case 4 'Black
   WriteByte(&h148E1, action_stance)
   
  case 5 'Call
   WriteByte(&h1491A, action_stance)
   
  case 6 'Dark Wave
   WriteByte(&h14A5F, action_stance)
  
  case 7 'Jump
   WriteByte(&h14828, action_stance)
   WriteByte(&h14833, action_stance2)
   WriteByte(&h146CD, action_stance3)
 
  case 8 'Recall
   start = &h1EC22
   total = 0
   for i as Integer = 0 to 7
    WriteByte(start + i * 8, success(i + 1) + total)
    total += success(i + 1)
   next
   start = &h1EC26
   for i as Integer = 0 to 7
    WriteByte(start + i * 8, spell(i + 1))
   next
   WriteByte(&h1EC62, message(1))
   if message(1) = &hFF then
    WriteByte(&h1EC63, &hEA)
    WriteByte(&h1EC64, &hEA)
    WriteByte(&h1EC65, &hEA)
   else
    WriteByte(&h1EC63, &h8D)
    WriteByte(&h1EC64, &hCA)
    WriteByte(&h1EC65, &h34)
   end if
   WriteByte(&h148E1, action_stance)
  
  case 9 'Sing
   WriteByte(&h1EB1D, spell(1))
   WriteByte(&h1EB2A, spell(2))
   WriteByte(&h1EB37, spell(3))
   WriteByte(&h1EB40, spell(4))
   WriteByte(&h1EB0D, spell(5))
   WriteByte(&h1EB01, misc_bytes(1))
   WriteByte(&h1EB04, misc_bytes(2))
   WriteByte(&h1EB18, message(1))
   if message(1) = &hFF then
    WriteByte(&h1EB19, &hEA)
    WriteByte(&h1EB1A, &hEA)
    WriteByte(&h1EB1B, &hEA)
   else
    WriteByte(&h1EB19, &h8D)
    WriteByte(&h1EB1A, &hCA)
    WriteByte(&h1EB1B, &h34)
   end if
   WriteByte(&h1EB25, message(2))
   if message(2) = &hFF then
    WriteByte(&h1EB26, &hEA)
    WriteByte(&h1EB27, &hEA)
    WriteByte(&h1EB28, &hEA)
   else
    WriteByte(&h1EB26, &h8D)
    WriteByte(&h1EB27, &hCA)
    WriteByte(&h1EB28, &h34)
   end if
   WriteByte(&h1EB32, message(3))
   if message(3) = &hFF then
    WriteByte(&h1EB33, &hEA)
    WriteByte(&h1EB34, &hEA)
    WriteByte(&h1EB35, &hEA)
   else
    WriteByte(&h1EB33, &h8D)
    WriteByte(&h1EB34, &hCA)
    WriteByte(&h1EB35, &h34)
   end if
   WriteByte(&h1EB3B, message(4))
   if message(4) = &hFF then
    WriteByte(&h1EB3C, &hEA)
    WriteByte(&h1EB3D, &hEA)
    WriteByte(&h1EB3E, &hEA)
   else
    WriteByte(&h1EB3C, &h8D)
    WriteByte(&h1EB3D, &hCA)
    WriteByte(&h1EB3E, &h34)
   end if
   WriteByte(&h1EB08, message(5))
   if message(5) = &hFF then
    WriteByte(&h1EB09, &hEA)
    WriteByte(&h1EB0A, &hEA)
    WriteByte(&h1EB0B, &hEA)
   else
    WriteByte(&h1EB09, &h8D)
    WriteByte(&h1EB0A, &hCA)
    WriteByte(&h1EB0B, &h34)
   end if
   WriteByte(&h148C7, action_stance)
   
  case 10 'Hide
   WriteByte(&h1AD57, misc_bytes(1))
   WriteByte(&h1A608, misc_bytes(1))
   WriteByte(&h147CB, action_stance)
   
  case 11 'Split
   WriteByte(&h1E4E8, item_consumed)
   WriteByte(&h1E532, item_effect)
   WriteByte(&h1E53D, item_visual)
   WriteByte(&h1E4F9, message(1))
   if message(1) = &hFF then
    WriteByte(&h1E4FA, &hEA)
    WriteByte(&h1E4FB, &hEA)
    WriteByte(&h1E4FC, &hEA)
   else
    WriteByte(&h1E4FA, &h8D)
    WriteByte(&h1E4FB, &hCA)
    WriteByte(&h1E4FC, &h34)
   end if
   WriteByte(&h149B3, action_stance)
   
  case 12 'Pray
   WriteByte(&h1EA56, success(1))
   WriteByte(&h1EA64, spell(1))
   WriteByte(&h1EA5D, message(1))
   if message(1) = &hFF then
    WriteByte(&h1EA5E, &hEA)
    WriteByte(&h1EA5F, &hEA)
    WriteByte(&h1EA60, &hEA)
   else
    WriteByte(&h1EA5E, &h8D)
    WriteByte(&h1EA5F, &hCA)
    WriteByte(&h1EA60, &h34)
   end if
   WriteByte(&h149F3, action_stance)
  
  case 13 'Aim
   WriteByte(&h14A8A, action_stance)
   
  case 14 'Charge
   WriteByte(&h1EA1E, message(1))
   if message(1) = &hFF then
    WriteByte(&h1EA1F, &hEA)
    WriteByte(&h1EA20, &hEA)
    WriteByte(&h1EA21, &hEA)
   else
    WriteByte(&h1EA1F, &h8D)
    WriteByte(&h1EA20, &hCA)
    WriteByte(&h1EA21, &h34)
   end if
   
  case 15
   WriteByte(&h1451D, action_stance)
   
  case 16 'Bear
   WriteByte(&h1E897, spell(1))
   WriteByte(&h1E8A5, message(1))
   if message(1) = &hFF then
    WriteByte(&h1E8A6, &hEA)
    WriteByte(&h1E8A7, &hEA)
    WriteByte(&h1E8A8, &hEA)
   else
    WriteByte(&h1E8A6, &h8D)
    WriteByte(&h1E8A7, &hCA)
    WriteByte(&h1E8A8, &h34)
   end if
   
  case 17 'Twin
   WriteByte(&h1E793, spell(1))
   WriteByte(&h1E797, spell(2))
   WriteByte(&h1E77C, spell(3))
   WriteByte(&h1E783, success(1))
   WriteByte(&h1E78F, success(2))
   WriteByte(&h1E774, misc_bytes(1))
   WriteByte(&h1E778, misc_bytes(2))
   WriteByte(&h1E6DC, message(1))
   if message(1) = &hFF then
    WriteByte(&h1E6DD, &hEA)
    WriteByte(&h1E6DE, &hEA)
    WriteByte(&h1E6DF, &hEA)
   else
    WriteByte(&h1E6DD, &h8D)
    WriteByte(&h1E6DE, &hCA)
    WriteByte(&h1E6DF, &h34)
   end if
   WriteByte(&h1E787, message(2))
   if message(2) = &hFF then
    WriteByte(&h1E788, &hEA)
    WriteByte(&h1E789, &hEA)
    WriteByte(&h1E78A, &hEA)
   else
    WriteByte(&h1E788, &h8D)
    WriteByte(&h1E789, &hCA)
    WriteByte(&h1E78A, &h34)
   end if
   
  case 18 'Boast
   WriteByte(&h1ECD1, misc_bytes(1))
   WriteByte(&h1ECDC, misc_bytes(1))
   WriteByte(&h1ECD4, misc_bytes(2))
   WriteByte(&h1ECDF, message(1))
   if message(1) = &hFF then
    WriteByte(&h1ECE0, &hEA)
    WriteByte(&h1ECE1, &hEA)
    WriteByte(&h1ECE2, &hEA)
   else
    WriteByte(&h1ECE0, &h8D)
    WriteByte(&h1ECE1, &hCA)
    WriteByte(&h1ECE2, &h34)
   end if
   WriteByte(&h149AB, action_stance)
   
  case 19 'Cry
   WriteByte(&h1ECF3, misc_bytes(1))
   WriteByte(&h1ED0C, misc_bytes(2))
   WriteByte(&h1ED17, misc_bytes(2))
   WriteByte(&h1ED22, message(1))
   if message(1) = &hFF then
    WriteByte(&h1ED23, &hEA)
    WriteByte(&h1ED24, &hEA)
    WriteByte(&h1ED25, &hEA)
   else
    WriteByte(&h1ED23, &h8D)
    WriteByte(&h1ED24, &hCA)
    WriteByte(&h1ED25, &h34)
   end if
   WriteByte(&h149AB, action_stance)
   
  case 20 'Cover
   WriteByte(&h18F62, disable_actor)
   WriteByte(&h18F66, cover_actor)
   if cover_by_job then WriteByte(&h38D5D, 1) else WriteByte(&h38D5D, 0)
   WriteByte(&h149F3, action_stance)
   
  case 21 'Peep
   WriteByte(&h149AB, action_stance)
  
  case 23 'Throw
   WriteByte(&h1434C, action_stance)
   
  case 24 'Steal
   WriteByte(&h1E3F1, misc_bytes(1)) 'Base
   WriteByte(&h1E3F3, misc_bytes(2)) 'Bonus stat
   WriteByte(&h1E3F7, misc_bytes(3)) 'Penalty stat
   WriteByte(&h1E457, misc_bytes(4)) 'Slot
   WriteByte(&h1E433, message(1)) 'Damaged by enemy
   if message(1) = &hFF then
    WriteByte(&h1E434, &hEA)
    WriteByte(&h1E435, &hEA)
    WriteByte(&h1E436, &hEA)
   else
    WriteByte(&h1E434, &h8D)
    WriteByte(&h1E435, &hCA)
    WriteByte(&h1E436, &h34)
   end if
   WriteByte(&h1E43A, message(2)) 'Couldn't steal
   if message(2) = &hFF then
    WriteByte(&h1E43B, &hEA)
    WriteByte(&h1E43C, &hEA)
    WriteByte(&h1E43D, &hEA)
   else
    WriteByte(&h1E43B, &h8D)
    WriteByte(&h1E43C, &hCA)
    WriteByte(&h1E43D, &h34)
   end if
   WriteByte(&h1E4CA, message(3)) 'Stole item
   if message(3) = &hFF then
    WriteByte(&h1E4CB, &hEA)
    WriteByte(&h1E4CC, &hEA)
    WriteByte(&h1E4CD, &hEA)
   else
    WriteByte(&h1E4CB, &h8D)
    WriteByte(&h1E4CC, &hCA)
    WriteByte(&h1E4CD, &h34)
   end if
   WriteByte(&h149F3, action_stance)
   
  case 25
   WriteByte(&h148E1, action_stance)
   
  case 26 'Regen
   WriteByte(&h1E5FE, regen_amount)
   if regen_freeze then
    WriteByte(&h1E616, &h0C)
    WriteByte(&h1E624, &h08)
   else
    WriteByte(&h1E616, 1)
    WriteByte(&h1E624, 0)
   end if
   WriteByte(&h1E633, message(1))
   if message(1) = &hFF then
    WriteByte(&h1E634, &hEA)
    WriteByte(&h1E635, &hEA)
    WriteByte(&h1E636, &hEA)
   else
    WriteByte(&h1E634, &h8D)
    WriteByte(&h1E635, &hCA)
    WriteByte(&h1E636, &h34)
   end if
   WriteByte(&h149AB, action_stance)
 
 end select

end sub
