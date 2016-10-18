type Event

 script as List
 else_script as List
 map_link as UInteger = 1
 
 declare function ScriptEntry(entry as String, actual_map as UInteger = 0) as String
 declare function Length() as UInteger
 
 declare sub IfParameterBytesToInstructions()
 declare sub IfParameterInstructionsToBytes()
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte, offset as UInteger)

end type
