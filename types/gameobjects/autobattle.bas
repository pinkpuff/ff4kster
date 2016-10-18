type AutoBattle

 formation_index as UInteger
 script(2) as String
 
 declare function TranslateEntry(index as UInteger, s as UByte) as String
 
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte)

end type
