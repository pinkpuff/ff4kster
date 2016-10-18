sub NPC.ReadFromROM(index as UInteger)

 dim start as UInteger
 dim finish as UInteger
 dim temp as String
 
 sprite = ByteAt(&h97200 + index)
 if ByteAt(&h97400 + (index) \ 8) and 2 ^ (((index) mod 8)) then
  visible = true
 else
  visible = false
 end if
 
 start = ByteAt(&h99A00 + 2 * index)
 start += ByteAt(&h99A00 + 2 * index + 1) * &h100
 start += &h99E00
 finish = ByteAt(&h99A00 + 2 * (index + 1))
 finish += ByteAt(&h99A00 + 2 * (index + 1) + 1) * &h100
 finish += &h99E00
 for i as UInteger = start to finish - 1
  temp += chr(ByteAt(i))
 next
 if temp <> "" then speech.Decode(temp)

end sub


sub NPC.WriteToROM(index as UInteger)

 dim start as UInteger
 dim temp as UByte
 dim s as String
 dim filter as UByte

 WriteByte(&h97200 + index, sprite) 
 temp = ByteAt(&h97400 + index \ 8) 
 'filter = &hFF
 'if not visible then filter -= 2 ^ (7 - (index mod 8))
 'temp = temp and filter
 if visible then
  temp = temp or 2 ^ ((index mod 8))
 else
  temp = temp and &hFF - 2 ^ ((index mod 8))
 end if
 WriteByte(&h97400 + index \ 8, temp)
 
 start = ByteAt(&h99A00 + 2 * index)
 start += ByteAt(&h99A00 + 2 * index + 1) * &h100
 start += &h99E00
 s = speech.Encode()
 for i as Integer = 1 to len(s)
  WriteByte(start, asc(mid(s, i, 1)))
  start += 1
 next
 if index < total_npcs then
  start -= &h99E00
  WriteByte(&h99A00 + 2 * (index + 1), start mod &h100)
  WriteByte(&h99A00 + 2 * (index + 1) + 1, start \ &h100)
 end if
 
end sub
