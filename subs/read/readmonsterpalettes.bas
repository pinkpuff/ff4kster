sub ReadMonsterPalettes()

 dim start as UInteger
 dim pal as UInteger
 dim r as UByte
 dim g as UByte
 dim b as UByte

 start = &hE7000
 
 for i as Integer = 1 to total_monster_palettes
  for j as Integer = 0 to 7
   pal = ByteAt(start + (i - 1) * 16 + j * 2)
   pal += ByteAt(start + (i - 1) * 16 + j * 2 + 1) * &h100
   r = (pal mod 32) * 8
   g = ((pal \ 32) mod 32) * 8
   b = ((pal \ 1024) mod 32) * 8
   monster_palettes(i, j) = RGB(r, g, b)
  next
 next

end sub
