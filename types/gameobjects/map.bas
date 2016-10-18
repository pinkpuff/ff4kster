type Map

 triggers as List
 dialogues as List
 battle_background as UByte
 warpable as Boolean
 exitable as Boolean
 mystery_bit as Boolean
 magnetic as Boolean
 grid_index as UByte
 tileset_index as UByte
 npc_placement_index as UByte
 border_tile as UByte
 map_palette as UByte
 npc_palette_12 as UByte
 npc_palette_34 as UByte
 music as UByte
 background as UByte
 bg_translucent as Boolean
 bg_scroll_vertical as Boolean
 bg_scroll_horizontal as Boolean
 mystery_bit2 as Boolean
 bg_move_direction as UByte
 bg_move_speed as UByte
 underground as Boolean
 name_index as UByte
 treasure_index as UByte
 encounter_rate as UByte

 declare function BytesUsed() as UInteger
 'declare function RunLengthEncoding as String
 
 declare sub ReadFromROM(index as UInteger)
 declare sub WriteToROM(index as UInteger)

end type
