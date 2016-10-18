sub Trigger.ReadFromROM(address as UInteger)

 dim temp as UByte

 x = ByteAt(address)
 y = ByteAt(address + 1)
 temp = ByteAt(address + 2)
 select case temp
  case &hFF
   event = ByteAt(address + 3)
  case &hFE
   treasure = true
   formation = ByteAt(address + 3) mod 2^6
   if ByteAt(address + 3) and 2^6 then trapped = true
   if ByteAt(address + 3) and 2^7 then item = true
   contents = ByteAt(address + 4)
  case else
   warp = true
   new_map = temp
   new_x = ByteAt(address + 3) mod 2^6
   facing = ByteAt(address + 3) \ 2^6
   new_y = ByteAt(address + 4)
 end select

end sub


sub Trigger.WriteToROM(address as UInteger)

 dim temp as UByte

 WriteByte(address, x)
 WriteByte(address + 1, y)
 if warp then
  WriteByte(address + 2, new_map)
  temp = new_x + facing * 2^6
  WriteByte(address + 3, temp)
  WriteByte(address + 4, new_y)
 elseif treasure then
  WriteByte(address + 2, &hFE)
  temp = formation
  if trapped then temp += 2^6
  if item then temp += 2^7
  WriteByte(address + 3, temp)
  WriteByte(address + 4, contents)
 else
  WriteByte(address + 2, &hFF)
  WriteByte(address + 3, event)
  WriteByte(address + 4, 0)
 end if
 
end sub
