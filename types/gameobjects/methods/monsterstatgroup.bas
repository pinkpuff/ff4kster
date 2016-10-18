sub MonsterStatGroup.ReadFromROM(index as UByte)

 dim start as UInteger
 
 start = &h72580 + (index - 1) * 3
 
 multiplier = ByteAt(start)
 percentage = ByteAt(start + 1)
 stat_base = ByteAt(start + 2)

end sub


sub MonsterStatGroup.WriteToROM(index as UByte)

 dim start as UInteger
 
 start = &h72580 + (index - 1) * 3
 
 WriteByte(start, multiplier)
 WriteByte(start + 1, percentage)
 WriteByte(start + 2, stat_base)

end sub
