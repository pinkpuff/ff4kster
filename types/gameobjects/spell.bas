type Spell

 name as String
 casting_time as UByte
 target as UByte
 power as UByte
 hit as UByte
 boss as Boolean
 effect as UByte
 damage as Boolean
 element_code as UByte
 impact as Boolean
 mp_cost as UByte
 reflectable as Boolean
 colors as UByte
 sprites as UByte
 visual1 as UByte
 visual2 as UByte
 sound as UByte
 
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte)

end type
