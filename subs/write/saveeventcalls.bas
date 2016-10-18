sub SaveEventCalls()

 dim start as UInteger
 dim address as UInteger
 dim finish as UInteger
 dim temp as String
 dim address_pointer as UInteger
 dim e as EventCall ptr
 
 start = &h97462
 address = &h97660
 
 for i as Integer = 1 to eventcalls.Length()
  address_pointer = address - &h97660
  WriteByte(start, address_pointer mod &h100)
  WriteByte(start + 1, address_pointer \ &h100)
  start += 2
  e = eventcalls.PointerAt(i)
  temp = e->Encode()
  for i as Integer = 1 to len(temp)
   WriteByte(address + i - 1, asc(mid(temp, i, 1)))
  next
  address += len(temp)
  'if i = eventcalls.Length() then
   'print hex(address)
   'getkey
   'end
  'end if
 next
 address_pointer = address - &h97660
 WriteByte(start, address_pointer mod &h100)
 WriteByte(start + 1, address_pointer \ &h100)

end sub
