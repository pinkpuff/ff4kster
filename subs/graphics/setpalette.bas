sub SetPalette(start as UInteger, index as UInteger = 0)

 dim total_pals as Integer
 dim total_cols as Integer
 dim pal as Integer
 dim r as UByte
 dim g as UByte
 dim b as UByte
 
 total_pals = 8
 total_cols = 8
 
 for i as Integer = 0 to total_pals - 1
  for j as Integer = 0 to total_cols - 1
   pal = ByteAt(start + index * &h80 + i * total_cols * 2 + j * 2)
   pal += ByteAt(start + index * &h80 + i * total_cols * 2 + j * 2 + 1) * &h100
   r = (pal mod 32) * 8
   g = ((pal \ 32) mod 32) * 8
   b = ((pal \ 1024) mod 32) * 8
   map_palettes(index, i, j) = RGB(r, g, b)
  next
 next
 
end sub
