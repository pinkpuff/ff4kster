sub DrawBMP(x as UByte, y as UByte, filename as String, target as Any ptr = 0)

 dim b as Any ptr
 
 b = ImageCreate(16, 16)
 
 bload filename, b
 put target, (x * 8, y * 8), b, pset
 ImageDestroy(b)

end sub
