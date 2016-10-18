sub PlacementGroup.ReadFromROM(index as Integer)

 dim start as UInteger
 dim p as Placement ptr
 dim temp as String
 
 start = ByteAt(&h98200 + (index - 1) * 2) + ByteAt(&h98200 + (index - 1) * 2 + 1) * &h100 + &h98500
 
 for i as Integer = 1 to 12
  if ByteAt(start) = 0 then
   exit for
  else
   p = callocate(SizeOf(Placement))
   p->underground = underground
   temp = ""
   for j as Integer = 0 to 3
    temp += chr(ByteAt(start + j))
   next
   p->Decode(temp)
   placements.Append(p)
  end if
  start += 4
 next

end sub


sub PlacementGroup.WriteToROM(index as Integer)

 dim start as UInteger
 dim p as Placement ptr
 dim temp as String
 
 start = ByteAt(&h98200 + (index - 1) * 2) + ByteAt(&h98200 + (index - 1) * 2 + 1) * &h100 + &h98500
 
 if placements.Length() > 0 then
 
  for i as Integer = 1 to placements.Length()
   p = placements.PointerAt(i)
   temp = p->Encode()
   for j as Integer = 1 to 4 'len(temp)
    WriteByte(start, asc(mid(temp, j, 1)))
    start += 1
   next
  next
  WriteByte(start, 0)
  start += 1
  
  if index < total_maps then
   start -= &h98500
   WriteByte(&h98200 + index * 2, start mod &h100)
   WriteByte(&h98200 + index * 2 + 1, start \ &h100)
  else
   WriteByte(&h98500 + PlacementSpace() + 1, 0)
  end if
  
 else
 
  if index < total_maps then
   start -= &h98500
   WriteByte(&h98200 + index * 2, start mod &h100)
   WriteByte(&h98200 + index * 2 + 1, start \ &h100)
  else
   WriteByte(&h98500 + PlacementSpace() + 1, 0)
  end if
  start = PlacementSpace() + 1
  WriteByte(&h98200 + (index - 1) * 2, start mod &h100)
  WriteByte(&h98200 + (index - 1) * 2 + 1, start \ &h100)
  
 end if

end sub
