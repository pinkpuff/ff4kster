type Weapon
 
 name as String
 price_code as UByte
 attack as UByte
 hit as UByte
 element_code as UByte
 equip_code as UByte
 casts as UByte
 spell_power as UByte
 spell_gfx as UByte
 visual_color as UByte
 visual_sprite as UByte
 visual_swing as UByte
 visual_slash as UByte
 property_flag(9) as Boolean
 stat_up(5) as Boolean
 stat_amount as UByte
 races(8) as Boolean
 description as UByte
 
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte) 
 
end type
