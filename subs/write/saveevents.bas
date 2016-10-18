sub SaveEvents()

 dim offset as UInteger
 dim total_space as UInteger
 
 for i as Integer = 1 to total_events
  total_space += events(i).Length()
 next
 
 if total_space > &h6E00 then 
 
  WarningMessage(FF4Text("Events overflow!"))
  
 else
 
  offset = &h90400
  
  for i as Integer = 1 to total_events
   WriteByte(&h90202 + (i - 1) * 2, (offset - &h90400) mod &h100)
   WriteByte(&h90202 + (i - 1) * 2 + 1, (offset - &h90400) \ &h100)
   events(i).WriteToROM(i, offset)
   offset += events(i).Length()
  next
  
 end if

end sub
