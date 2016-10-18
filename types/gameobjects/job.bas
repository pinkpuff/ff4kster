type Job

 name as String
 white as UByte
 black as UByte
 summon as UByte
 menu_white as UByte
 menu_black as UByte
 menu_summon as UByte
 
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte)

end type
