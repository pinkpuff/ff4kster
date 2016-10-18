type Actor

 name_index as UByte
 load_initial as Boolean
 store_shadow as Boolean
 load_slot as UByte
 store_slot as UByte
 level_link as UByte
 menu_command(5) as UByte
 starting_gear(5) as UByte
 right_ammo as UByte
 left_ammo as UByte
 
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte)

end type
