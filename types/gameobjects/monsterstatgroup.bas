type MonsterStatGroup

 multiplier as UByte
 percentage as UByte
 stat_base as UByte
 
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte)

end type
