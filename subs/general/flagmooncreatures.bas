sub SetMoonFlags(index as UInteger)

 for i as Integer = 1 to 8
  for j as Integer = 1 to 3
   monsters(formations(encounters(encounter_tables(index) + 16 + 1, i) + &h100 + 1).monster_type(j) + 1).lunar = true
  next
 next

end sub

sub FlagMoonCreatures()

 dim t as Trigger ptr
 dim e as EventCall ptr
 dim c as CallComponent ptr
 dim entry as String

 for i as Integer = 1 to total_monsters
  monsters(i).lunar = false
 next

 for i as Integer = 431 to 433
  if encounter_tables(i) > 0 then SetMoonFlags(i)
 next
 
 for i as Integer = 444 to 468
  if encounter_tables(i) > 0 then SetMoonFlags(i)
 next
 
 'for i as Integer = 347 to 349
  'for j as Integer = 1 to maps(i).triggers.Length()
   't = maps(i).triggers.PointerAt(j)
   'if not t->warp and not t->treasure then
    'e = eventcalls.PointerAt(t->event)
    'for k as Integer = 1 to e->components.Length()
     'c = e->components.PointerAt(k)
     'for l as Integer = 1 to events(c->event_reference + 1).script.Length()
      'entry = events(c->event_reference + 1).script.ItemAt(l)
      'if left(entry, 1) = chr(&hEC) then
       'for m as Integer = 1 to 3
        'monsters(formations(asc(mid(entry, 2)) + &h100 + 1).monster_type(m) + 1).lunar = true
       'next
      'end if
     'next
    'next
   'end if
  'next
 'next

 'for i as Integer = 444 to 454
  'SetMoonFlags(i)
 'next
 
 'for i as Integer = 456 to 460
  'SetMoonFlags(i)
 'next
 
 'for i as Integer = 462 to 463
  'SetMoonFlags(i)
 'next
 
 'SetMoonFlags(465)
 
 ''--Debug
 'for i as Integer = 1 to total_monsters
  'if monsters(i).lunar then monsters(i).name = FF4Text("-") + monsters(i).name
 'next

end sub
