sub Shop.ReadFromROM(index as UByte)

 dim start as UInteger

 start = &h9A500

 for i as UByte = 1 to 8
  wares(i) = ByteAt(start + (index - 1) * 8 + (i - 1))
 next

end sub


sub Shop.WriteToROM(index as UByte)
 
 dim start as UInteger

 start = &h9A500

 for i as UByte = 1 to 8
  WriteByte(start + (index - 1) * 8 + (i - 1), wares(i))
 next 
 
end sub
