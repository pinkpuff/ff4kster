sub ShowPalette(x as UByte, y as UByte)

 for i as Integer = 0 to 7
  for j as Integer = 1 to 8
   line ((x + i * 8 + j) * 8, y * 8)-((x + i * 8 + j + 1) * 8 - 1, (y + 1) * 8 - 1), 16 + i * 8 + j, bf
  next
 next

end sub
