sub MonsterSpeedGroup.ReadFromROM(index as UByte)

 dim start as UInteger
 
 start = &h72820 + (index - 1) * 2
 
 low = ByteAt(start)
 high = ByteAt(start + 1)

end sub


sub MonsterSpeedGroup.WriteToROM(index as UByte)

 dim start as UInteger
 
 start = &h72820 + (index - 1) * 2
 
 WriteByte(start, low)
 WriteByte(start + 1, high)

end sub
