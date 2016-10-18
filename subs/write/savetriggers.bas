sub SaveTriggers()

 dim t as Trigger ptr
 dim start as UInteger
 dim address as UInteger
 dim finish as UInteger
 dim temp as UInteger
 dim total_overworld_triggers as UInteger
 
 start = &hA8200
 address = &hA8500
 total_overworld_triggers = 0
 
 for i as Integer = 1 to total_maps
  if address > &hA981F then
   WarningMessage(FF4Text("Triggers Overflow!"))
   exit for
  else
   temp = address - &hA8500
   WriteByte(start, temp mod &h100)
   WriteByte(start + 1, temp \ &h100)
   start += 2
   if i = 252 then
    for j as Integer = 1 to maps(i).triggers.Length()
     t = maps(i).triggers.PointerAt(j)
     t->WriteToROM(&hD0066 + (j - 1) * 5)
    next
    total_overworld_triggers += maps(i).triggers.Length()
   elseif i = 253 then
    for j as Integer = 1 to maps(i).triggers.Length()
     t = maps(i).triggers.PointerAt(j)
     t->WriteToROM(&hD0066 + maps(252).triggers.Length() * 5 + (j - 1) * 5)
    next
    WriteByte(&hD0062, (total_overworld_triggers * 5) mod &h100)
    WriteByte(&hD0063, (total_overworld_triggers * 5) \ &h100)
    total_overworld_triggers += maps(i).triggers.Length()
   elseif i = 254 then
    for j as Integer = &hD01DD to &hD01FF
     WriteByte(j, 0)
    next
    for j as Integer = 1 to maps(i).triggers.Length()
     t = maps(i).triggers.PointerAt(j)
     t->WriteToROM(&hD0066 + maps(252).triggers.Length() * 5 + maps(253).triggers.Length() * 5 + (j - 1) * 5)
    next
    WriteByte(&hD0064, (total_overworld_triggers * 5) mod &h100)
    WriteByte(&hD0065, (total_overworld_triggers * 5) \ &h100)
    total_overworld_triggers += maps(i).triggers.Length()
   else
    for j as Integer = 1 to maps(i).triggers.Length()
     t = maps(i).triggers.PointerAt(j)
     t->WriteToROM(address)
     address += 5
    next
   end if
  end if
 next

end sub
