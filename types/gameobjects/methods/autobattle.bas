function AutoBattle.TranslateEntry(index as UInteger, s as UByte = 1) as String

 dim result as String

 select case asc(mid(script(s), (index - 1) * 2 + 1, 1))
  case 0
   result = FF4Text("Cast ") + spells(asc(mid(script(s), index * 2, 1))).name
  case 1
   result = FF4Text("Use  ") + item_names.ItemAt(asc(mid(script(s), index * 2, 1)) + 1)
  case &hC0 to &hDF
   result = menucommands(asc(mid(script(s), (index - 1) * 2 + 1, 1)) - &hC0 + 1).name
  case else
   result = FF4Text("Unknown")
 end select
 
 return Pad(result, 14,, FF4Text(" "))

end function


sub AutoBattle.ReadFromROM(index as UByte)

 dim start as UInteger
 dim p as UInteger
 dim finish as UInteger
 
 index -= 1
 
 start = &hA000D
 formation_index = ByteAt(start + index * 2) + ByteAt(start + index * 2 + 1) * &h100
 
 start = &hA001D
 p = ByteAt(start + index * 2) + ByteAt(start + index * 2 + 1) * &h100 + &h90200
 
 do until ByteAt(p) = &hFF
  script(1) += chr(ByteAt(p))
  p += 1
 loop
 
 if index >= 6 then
  p += 1
  do until ByteAt(p) = &hFF
   script(2) += chr(ByteAt(p))
   p += 1
  loop
 end if 

end sub


sub AutoBattle.WriteToROM(index as UByte)

 dim start as UInteger
 dim p as UInteger
 
 index -= 1
 
 start = &hA000D
 'formation_index = ByteAt(start + index * 2) + ByteAt(start + index * 2 + 1) * &h100
 WriteByte(start + index * 2, formation_index mod &h100)
 WriteByte(start + index * 2 + 1, formation_index \ &h100)
 
 'start = &hA001D
 'p = ByteAt(start + index * 2) + ByteAt(start + index * 2 + 1) * &h100 + &h90200
 
 'do until ByteAt(p) = &hFF
  'script += chr(ByteAt(p))
  'p += 1
 'loop

 start = &hA001D
 p = ByteAt(start + index * 2) + ByteAt(start + index * 2 + 1) * &h100 + &h90200
 for i as Integer = 1 to len(script(1))
  WriteByte(p, asc(mid(script(1), i, 1)))
  p += 1
 next
 WriteByte(p, &hFF)
 p += 1

 if index >= 6 then
  for i as Integer = 1 to len(script(2))
   WriteByte(p, asc(mid(script(2), i, 1)))
   p += 1
  next
  WriteByte(p, &hFF)
  p += 1
 end if 

 if index + 1 < total_autobattles then
  if not warning and p > &hA0064 then WarningMessage(FF4Text("Autobattle script overflow"))
  p -= &h90200
  WriteByte(start + index * 2 + 2, p mod &h100)
  WriteByte(start + index * 2 + 3, p \ &h100)
 else
  if not warning and p > &hA0067 then WarningMessage(FF4Text("Autobattle script overflow"))
 end if

end sub

