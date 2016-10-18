sub ReadEventCalls()

 dim start as UInteger
 dim address as UInteger
 dim finish as UInteger
 dim temp as String
 dim e as EventCall ptr
 
 start = &h97460
 
 do while start < &h9765E
  address = ByteAt(start)
  address += ByteAt(start + 1) * &h100
  address += &h97660
  finish = ByteAt(start + 2)
  finish += ByteAt(start + 3) * &h100
  finish += &h97660
  temp = ""
  for i as Integer = address to finish - 1
   temp += chr(ByteAt(i))
  next
  if temp <> "" then
   e = callocate(SizeOf(EventCall))
   e->Decode(temp)
   eventcalls.Append(e)
  end if
  start += 2
 loop

end sub
