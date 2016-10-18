sub ReadMapGrids()

 dim start as UInteger
 dim tilesread as Integer
 dim x as UByte
 dim y as UByte
 dim runlength as Integer
 dim temp as UInteger
 dim found as Boolean
 
 start = &hB8200
 for i as Integer = 0 to total_maps - 1
  if i >= 251 and i <= 255 then
   mapgrids(i + 1).no_data = true
   mapgrids(i + 1).rom_pointer = 0
  elseif i = total_maps - 1 then
   mapgrids(i + 1).no_data = true
   mapgrids(i + 1).rom_pointer = 0
  else
   if i < &h100 then temp = &hB8200 else temp = &hC0200
   temp += ByteAt(start + i * 2) + ByteAt(start + i * 2 + 1) * &h100
   for j as Integer = i to 1 + iif(i < &h100, 0, &h100) step -1
    if mapgrids(j).rom_pointer = temp then 
     mapgrids(j).no_data = true
    end if
   next
   mapgrids(i + 1).rom_pointer = temp
  end if
 next

 'start = &hB8500
 for i as Integer = 1 to total_maps
  tilesread = 0
  x = 0
  y = 0
  if not mapgrids(i).no_data then
   start = mapgrids(i).rom_pointer
   do until tilesread = &h400
    temp = ByteAt(start)
    start += 1
    if temp < &h80 then
     runlength = 1
    else
     runlength = ByteAt(start) + 1
     if tilesread + runlength > &h400 then runlength = &h400 - tilesread
     start += 1
    end if
    for j as Integer = 1 to runlength
     mapgrids(i).tiles(x, y) = temp mod &h80
     x += 1
     if x >= 32 then 
      x -= 32
      y += 1
     end if
    next
    tilesread += runlength
   loop
  end if
  'print " Map #"; str(i); " read"
 next
 

end sub
