type Medicine

 name as String
 price_code as UByte
 casting_time as UByte
 target as UByte
 power as UByte
 boss as Boolean
 hit as UByte
 impact as Boolean
 damage as Boolean
 effect as UByte
 element_code as UByte
 mp_cost as UByte
 reflectable as Boolean
 visual as UByte
 description as UByte
 
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte)

end type
