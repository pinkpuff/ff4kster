sub Job.ReadFromROM(index as UByte)

 dim start as UInteger
 dim temp as String

 if index > usable_jobs then
  name = FF4Text("Extra " + str(index - usable_jobs))
 else
  for i as Integer = 0 to 6
   temp += chr(ByteAt(&h7A964 + (index - 1) * 7 + i))
  next
  name = temp
 end if

 start = &h9FFDD + (index - 1) * 3
 
 white = ByteAt(start)
 black = ByteAt(start + 1)
 summon = ByteAt(start + 2)

 if index <= usable_jobs then
  start = &hA81A2 + (index - 1) * 3
  menu_white = ByteAt(start)
  menu_black = ByteAt(start + 1)
  menu_summon = ByteAt(start + 2) 
 end if
 
end sub


sub Job.WriteToROM(index as UByte)

 dim start as UInteger
 dim temp as UByte
 
 if index <= usable_jobs then
  for i as Integer = 0 to 6
   temp = asc(mid(name, i + 1, 1))
   WriteByte(&h7A964 + (index - 1) * 7 + i, temp)
  next
 end if
 
 start = &hA81A2 + (index - 1) * 3
 
 if index <= usable_jobs then 
  WriteByte(start, menu_white)
  WriteByte(start + 1, menu_black)
  WriteByte(start + 2, menu_summon)
 end if
 
 start = &h9FFDD + (index - 1) * 3
 WriteByte(start, white)
 WriteByte(start + 1, black)
 WriteByte(start + 2, summon)

end sub
