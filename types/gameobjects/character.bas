type Character

 character_id as UByte
 'mystery_bit as Boolean
 left_handed as Boolean
 right_handed as Boolean
 sprite as UByte
 level as UByte
 max_hp as UInteger
 max_mp as UInteger
 stat(5) as UByte
 xp as UInteger
 tnl as UInteger
 levelup(70) as LevelUpBonus
 after70(8) as StatLevelUp
 
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte)

end type
