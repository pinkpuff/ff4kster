sub ReadTriggers()

 dim t as Trigger ptr
 dim start as UInteger
 dim address as UInteger
 dim finish as UInteger
 dim total_overworld_triggers as UInteger
 dim total_underground_triggers as UInteger
 dim total_moon_triggers as UInteger
 
 start = &hA8200
 total_triggers = 0
 
 for i as Integer = 1 to total_maps
  address = ByteAt(start + (i - 1) * 2)
  address += ByteAt(start + (i - 1) * 2 + 1) * &h100
  address += &hA8500
  finish = ByteAt(start + i * 2)
  finish += ByteAt(start + i * 2 + 1) * &h100
  finish += &hA8500
  if finish > address then
   for j as Integer = 0 to finish - address - 5 step 5
    t = callocate(SizeOf(Trigger))
    t->ReadFromROM(address + j)
    maps(i).triggers.Append(t)
    total_triggers += 1
   next
  end if
 next
 
 total_overworld_triggers = (ByteAt(&hD0062) + ByteAt(&hD0063) * &h100) \ 5
 total_underground_triggers = ((ByteAt(&hD0064) + ByteAt(&hD0065) * &h100) - (ByteAt(&hD0062) + ByteAt(&hD0063) * &h100)) \ 5
 total_moon_triggers = (&h19A - (ByteAt(&hD0064) + ByteAt(&hD0065) * &h100)) \ 5
 
 start = &hD0066
 
 for i as Integer = 1 to total_overworld_triggers
  t = callocate(SizeOf(Trigger))
  t->ReadFromRom(start + (i - 1) * 5)
  maps(252).triggers.Append(t)
 next
 start += total_overworld_triggers * 5
 
 for i as Integer = 1 to total_underground_triggers
  t = callocate(SizeOf(Trigger))
  t->ReadFromRom(start + (i - 1) * 5)
  maps(253).triggers.Append(t)
 next
 start += total_underground_triggers * 5
 
 for i as Integer = 1 to total_moon_triggers
  if ByteAt(start + (i - 1) * 5) = 0 and ByteAt(start + (i - 1) * 5 + 1) = 0 and ByteAt(start + (i - 1) * 5 + 2) = 0 and ByteAt(start + (i - 1) * 5 + 3) = 0 and ByteAt(start + (i - 1) * 5 + 4) = 0 then
   exit for
  else
   t = callocate(SizeOf(Trigger))
   t->ReadFromRom(start + (i - 1) * 5)
   maps(254).triggers.Append(t)
  end if
 next
 
 'print total_triggers
 'getkey
 'end
 
end sub
