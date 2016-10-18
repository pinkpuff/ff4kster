type Armor

 name as String
 price_code as UByte
 metallic as Boolean
 magic_evade as UByte
 defense as UByte
 evade as UByte
 magic_defense as UByte
 element_code as UByte
 races(total_races) as Boolean
 equip_code as UByte
 part as UByte
 stat_mod as UByte
 stat_bonus(5) as Boolean
 description as UByte
 
 declare sub ReadFromROM(index as UByte)
 
 declare sub WriteToROM(index as UByte)

end type
