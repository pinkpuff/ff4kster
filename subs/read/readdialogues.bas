sub ReadDialogues()

 dim start as UInteger
 dim next_line as UInteger
 dim finish as UInteger
 dim temp as UByte
 dim message as String
 
 'Read Bank 1
 start = &h80200
 for i as Integer = 1 to total_dialogues_bank1
  next_line = &h80600 + ByteAt(start + (i - 1) * 2) + ByteAt(start + (i - 1) * 2 + 1) * &h100
  message = ""
  do
   temp = ByteAt(next_line)
   if temp > 0 then message += chr(temp)
   if temp = 4 or temp = 3 then
    next_line += 1
    message += chr(ByteAt(next_line))
   end if
   next_line += 1
  loop until temp = 0
  dialogues_bank1.Append(message)
 next
 
 'Read Bank 2
 start = &h88200
 for i as Integer = 1 to total_maps
  next_line = &h88500 + ByteAt(start + (i - 1) * 2) + ByteAt(start + (i - 1) * 2 + 1) * &h100
  if i = total_maps then start = &h901FE - i * 2
  finish = &h88500 + ByteAt(start + i * 2) + ByteAt(start + i * 2 + 1) * &h100
  if finish = &h88500 + &hFFFF then finish = &h901FB
  do until next_line >= finish
   message = ""
   do
    temp = ByteAt(next_line)
    if temp > 0 then message += chr(temp)
    if temp = 4 or temp = 3 then
     next_line += 1
     message += chr(ByteAt(next_line))
    end if
    next_line += 1
   loop until temp = 0
   maps(i).dialogues.Append(message)
  loop
 next

 'Read Bank 3
 start = &h9A700
 for i as Integer = 1 to total_dialogues_bank3
  next_line = &h9A900 + ByteAt(start + (i - 1) * 2) + ByteAt(start + (i - 1) * 2 + 1) * &h100
  message = ""
  do
   temp = ByteAt(next_line)
   if temp > 0 then message += chr(temp)
   if temp = 4 or temp = 3 then
    next_line += 1
    message += chr(ByteAt(next_line))
   end if
   next_line += 1
  loop until temp = 0
  dialogues_bank3.Append(message)  
 next
 
 'Read battle messages
 start = &h77400
 for i as Integer = 1 to total_dialogues_battle
  next_line = &h68200 + ByteAt(start + (i - 1) * 2) + ByteAt(start + (i - 1) * 2 + 1) * &h100
  message = ""
  do
   temp = ByteAt(next_line)
   if temp > 0 then message += chr(temp)
   if temp = 4 or temp = 3 then
    next_line += 1
    message += chr(ByteAt(next_line))
   end if
   next_line += 1
  loop until temp = 0
  dialogues_battle.Append(message)  
 next
 
 'Read battle alerts
 start = &h7B200
 for i as Integer = 1 to total_dialogues_alerts
  next_line = &h70200 + ByteAt(start + (i - 1) * 2) + ByteAt(start + (i - 1) * 2 + 1) * &h100
  message = ""
  do
   temp = ByteAt(next_line)
   if temp > 0 then message += chr(temp)
   if temp = 4 or temp = 3 then
    next_line += 1
    message += chr(ByteAt(next_line))
   end if
   next_line += 1
  loop until temp = 0
  dialogues_alerts.Append(message)  
 next
 
 'Read status names
 start = &h7B600
 for i as Integer = 1 to total_dialogues_status
  next_line = &h70200 + ByteAt(start + (i - 1) * 2) + ByteAt(start + (i - 1) * 2 + 1) * &h100
  message = ""
  do
   temp = ByteAt(next_line)
   if temp > 0 then message += chr(temp)
   if temp = 4 or temp = 3 then
    next_line += 1
    message += chr(ByteAt(next_line))
   end if
   next_line += 1
  loop until temp = 0
  dialogues_status.Append(message)  
 next
 
 'Read map names
 start = &hA9820
 for i as Integer = 1 to total_map_labels
  message = ""
  do
   temp = ByteAt(start)
   if temp > 0 then message += chr(temp)
   start += 1
  loop until temp = 0
  map_labels.Append(message)
 next
 for i as Integer = total_map_labels + 1 to &h100
  map_labels.Append(FF4Text("MAP " + Pad(str(i), 3, true, "0")))
 next
 
 'Read item descriptions
 '  (links are in a table at 7B000)
 start = &h70200 + ByteAt(&hA9CF) + ByteAt(&hA9D0) * &h100
 'start = &h7B02B
 for i as Integer = 1 to total_descriptions
  message = ""
  do
   temp = ByteAt(start)
   if temp > 0 then message += chr(temp)
   start += 1
  loop until temp = 0
  item_descriptions.Append(message)
 next

end sub
