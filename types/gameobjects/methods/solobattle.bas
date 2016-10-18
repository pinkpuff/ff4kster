sub SoloBattle.ReadFromROM(index as UByte)

 formation = ByteAt(&h6716 + 2 * (index - 1)) + &h100 * ByteAt(&h6716 + 2 * (index - 1) + 1)
 actor = ByteAt(&h6709 + index - 1) 

end sub


sub SoloBattle.WriteToROM(index as UByte)

 WriteByte(&h6716 + 2 * (index - 1), formation mod &h100)
 WriteByte(&h6716 + 2 * (index - 1) + 1, formation \ &h100)
 WriteByte(&h6709 + index - 1, actor)

end sub
