sub SaveDialogues()

 dim start as UInteger
 dim temp as String
 dim total as UInteger
 
 'Write Bank 1
 start = &h80600
 for i as Integer = 1 to total_dialogues_bank1
  WriteByte(&h80200 + (i - 1) * 2, (start - &h80600) mod &h100)
  WriteByte(&h80200 + (i - 1) * 2 + 1, (start - &h80600) \ &h100)
  if start + len(dialogues_bank1.ItemAt(i)) + 1 > &h881FF then
   WarningMessage(FF4Text("Bank 1 overflow!"))
   exit for
  end if
  temp = dialogues_bank1.ItemAt(i)
  for j as Integer = 1 to len(temp)
   WriteByte(start, asc(mid(temp, j, 1)))
   start += 1
  next
  WriteByte(start, 0)
  start += 1
 next
 
 'Write Bank 2
 start = &h88500
 for i as Integer = 1 to total_maps
  total = 0
  for j as Integer = 1 to maps(i).dialogues.Length()
   total += len(maps(i).dialogues.ItemAt(j)) + 1
  next
  if start + total > &h901FB then
   WarningMessage(FF4Text("Bank 2 overflow!"))
   exit for
  else
   WriteByte(&h88200 + (i - 1) * 2, (start - &h88500) mod &h100)
   WriteByte(&h88200 + (i - 1) * 2 + 1, (start - &h88500) \ &h100)
   for j as Integer = 1 to maps(i).dialogues.Length()
    temp = maps(i).dialogues.ItemAt(j)
    for k as Integer = 1 to len(temp)
     WriteByte(start, asc(mid(temp, k, 1)))
     start += 1
    next
    WriteByte(start, 0)
    start += 1
   next
  end if
  if i = total_maps then
   WriteByte(&h901FE, (start - &h88500) mod &h100)
   WriteByte(&h901FF, (start - &h88500) \ &h100)
  end if
 next
 
 'Write Bank 3
 start = &h9A900
 for i as Integer = 1 to total_dialogues_bank3
  WriteByte(&h9A700 + (i - 1) * 2, (start - &h9A900) mod &h100)
  WriteByte(&h9A700 + (i - 1) * 2 + 1, (start - &h9A900) \ &h100)
  if start + len(dialogues_bank3.ItemAt(i)) + 1 > &h9D3FF then
   WarningMessage(FF4Text("Bank 3 overflow!"))
   exit for
  end if
  temp = dialogues_bank3.ItemAt(i)
  for j as Integer = 1 to len(temp)
   WriteByte(start, asc(mid(temp, j, 1)))
   start += 1
  next
  WriteByte(start, 0)
  start += 1
 next
 
 'Write battle messages
 start = &h77574
 for i as Integer = 1 to total_dialogues_battle
  WriteByte(&h77400 + (i - 1) * 2, (start - &h68200) mod &h100)
  WriteByte(&h77400 + (i - 1) * 2 + 1, (start - &h68200) \ &h100)
  if start + len(dialogues_battle.ItemAt(i)) + 1 > &h781FF then
   WarningMessage(FF4Text("Battle messages overflow!"))
   exit for
  end if
  temp = dialogues_battle.ItemAt(i)
  for j as Integer = 1 to len(temp)
   WriteByte(start, asc(mid(temp, j, 1)))
   start += 1
  next
  WriteByte(start, 0)
  start += 1
 next
 
 'Write battle alerts
 start = &h7B276
 for i as Integer = 1 to total_dialogues_alerts
  WriteByte(&h7B200 + (i - 1) * 2, (start - &h70200) mod &h100)
  WriteByte(&h7B200 + (i - 1) * 2 + 1, (start - &h70200) \ &h100)
  if start + len(dialogues_alerts.ItemAt(i)) + 1 > &h7B5FF then
   WarningMessage(FF4Text("Battle alerts overflow!"))
   exit for
  end if  
  temp = dialogues_alerts.ItemAt(i)
  for j as Integer = 1 to len(temp)
   WriteByte(start, asc(mid(temp, j, 1)))
   start += 1
  next
  WriteByte(start, 0)
  start += 1
 next
 
 'Write status names
 start = &h7B640
 for i as Integer = 1 to total_dialogues_status
  WriteByte(&h7B600 + (i - 1) * 2, (start - &h70200) mod &h100)
  WriteByte(&h7B600 + (i - 1) * 2 + 1, (start - &h70200) \ &h100)
  if start + len(dialogues_status.ItemAt(i)) + 1 > &h7B6FF then
   WarningMessage(FF4Text("Status names overflow!"))
   exit for
  end if
  temp = dialogues_status.ItemAt(i)
  for j as Integer = 1 to len(temp)
   WriteByte(start, asc(mid(temp, j, 1)))
   start += 1
  next
  WriteByte(start, 0)
  start += 1
 next
 
 'Write map names
 start = &hA9820
 for i as Integer = 1 to total_map_labels
  if start + len(map_labels.ItemAt(i)) + 1 > &hA9E7F then
   WarningMessage(FF4Text("Map labels overflow!"))
   exit for
  end if
  for j as Integer = 1 to len(map_labels.ItemAt(i))
   WriteByte(start, asc(mid(map_labels.ItemAt(i), j, 1)))
   start += 1
  next
  WriteByte(start, 0)
  start += 1
 next
 
 'Write item descriptions
 start = &h7B000
 for i as Integer = 1 to total_weapons
  if i >= descriptions_start and i < descriptions_end then 
   WriteByte(start, weapons(i).description)
   start += 1
  end if
 next
 for i as Integer = 1 to total_armors
  if i + total_weapons + 2 > descriptions_start and i + total_weapons + 2 <= descriptions_end then
   WriteByte(start, armors(i).description)
   start += 1
  end if
 next
 for i as Integer = 1 to total_medicines
  if i + total_weapons + total_armors + 2 > descriptions_start and i + total_weapons + total_armors + 2 <= descriptions_end then
   WriteByte(start, medicines(i).description)
   start += 1
  end if
 next
 for i as Integer = 1 to total_tools
  if i + total_weapons + total_armors + total_medicines + 2 > descriptions_start and i + total_weapons + total_armors + total_medicines + 2 <= descriptions_end then
   WriteByte(start, tools(i).description)
   start += 1
  end if
 next
 'start = &h7B02B
 WriteByte(&hA9CF, (start - &h70200) mod &h100)
 WriteByte(&hA9D0, (start - &h70200) \ &h100)
 for i as Integer = 1 to total_descriptions
  if start + len(item_descriptions.ItemAt(i)) + 1 > &h7B1FF then
   WarningMessage(FF4Text("Item descriptions overflow!"))
   exit for
  end if
  temp = item_descriptions.ItemAt(i)
  for j as Integer = 1 to len(temp)
   WriteByte(start, asc(mid(temp, j, 1)))
   start += 1
  next
  WriteByte(start, 0)
  start += 1
 next

end sub
