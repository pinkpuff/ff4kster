type Monster

 name as String
 boss as Boolean
 level as UByte
 hp as UInteger
 gil as UInteger
 xp as UInteger
 physical_attack_index as UByte
 physical_defense_index as UByte
 magical_defense_index as UByte
 speed_index as UByte
 drop_rate as UByte
 drop_index as UByte
 attack_sequence_group as UByte
 lunar as Boolean
 has_attack_element as Boolean
 has_resistances as Boolean
 has_weaknesses as Boolean
 has_spell_power as Boolean
 has_race as Boolean
 has_reaction as Boolean
 attack_element as ElementGrid
 resistances as ElementGrid
 weaknesses as ElementGrid
 spell_power as UByte
 races as ElementGrid
 reaction_index as UByte
 size as UByte
 pal as UByte
 gfx_ptr1 as UByte
 gfx_ptr2 as UByte
 
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte)

end type
