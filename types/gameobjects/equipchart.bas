type EquipChart

 flags(total_jobs) as Boolean
 
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte)

end type
