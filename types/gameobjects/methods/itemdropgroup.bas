sub ItemDropGroup.ReadFromROM(index as UByte)

 dim start as UInteger
 
 start = &h72100 + (index - 1) * 4
 
 common_drop = ByteAt(start)
 uncommon_drop = ByteAt(start + 1)
 rare_drop = ByteAt(start + 2)
 mythic_drop = ByteAt(start + 3)

end sub


sub ItemDropGroup.WriteToROM(index as UByte)

 dim start as UInteger
 
 start = &h72100 + (index - 1) * 4
 
 WriteByte(start, common_drop)
 WriteByte(start + 1, uncommon_drop)
 WriteByte(start + 2, rare_drop)
 WriteByte(start + 3, mythic_drop)

end sub
