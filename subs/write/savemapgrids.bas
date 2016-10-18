sub SaveMapGrids()

 dim start as UInteger
 dim rle as String
 
 start = &hB8500
 for i as Integer = 1 to total_maps - 1
  'if i < 252 or i > 256 then
   if not mapgrids(i).no_data then
    rle = mapgrids(i).RunLengthEncoding()
    for j as Integer = 1 to len(rle)
     WriteByte(start, asc(mid(rle, j, 1)))
     start += 1
    next
   end if
   if i = 251 then i = 256
   WriteByte(&hB8200 + i * 2, (start - iif(i < &h100, &hB8200, &hC0200)) mod &h100)
   WriteByte(&hB8200 + i * 2 + 1, (start - iif(i < &h100, &hB8200, &hC0200)) \ &h100)
  'end if
 next

end sub
