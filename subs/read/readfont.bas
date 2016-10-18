sub ReadFont()

 dim start as UInteger = &h57200
 dim b as UByte
 dim c(7, 7) as UByte
 
 for i as Integer = 0 to &hFF
  font(i) = ImageCreate(8, 8, 0) ', 2)
 next
 
 for letter as Integer = 0 to &hFF
  
  for i as UByte = 0 to 7
   
   for j as UByte = 0 to 7
    c(i, j) = 0
   next
   
   for j as UByte = 0 to 1
    b = ByteAt(start + letter * 16 + i * 2 + j)
    for k as Byte = 0 to 7
     c(i, (7-k)) += ((b \ 2^k) and 1) * 2^j
    next
   next
   
   for j as UByte = 0 to 7
    select case c(i, j)
     case 0
      pset font(letter), (j, i), RGB(0, 0, 0)
     case 1
      pset font(letter), (j, i), RGB(0, 0, 96)
     case 2
      pset font(letter), (j, i), RGB(127, 127, 127)
     case 3
      pset font(letter), (j, i), RGB(255, 0, 255)
    'else
     'pset font(letter), (j, i), c(i, j)
    end select
   next
   
  next
  
 next
 
end sub
