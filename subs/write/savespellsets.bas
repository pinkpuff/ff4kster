sub SaveSpellSets()

 dim start as UInteger
 dim s as SpellSet ptr
 dim total as UInteger
 
 
 'Write starting spells
 start = &h7CAC0
 for i as Integer = 1 to spellsets.Length()
  s = spellsets.PointerAt(i)
  total += Min(s->starting_spells.Length() + 1, 24)
 next
 if total > &h320 then 
  WarningMessage("Starting spells overflow!")
 else
  for i as Integer = 1 to spellsets.Length()
   s = spellsets.PointerAt(i)
   if s->starting_spells.Length() = 0 then
    WriteByte(start, &hFF)
    start += 1
   else
    for j as Integer = 1 to 24
     if j > s->starting_spells.Length() then
      WriteByte(start, &hFF)
      start += 1
      exit for
     else
      WriteByte(start, asc(s->starting_spells.ItemAt(j)))
      start += 1
     end if
    next
   end if
  next
 end if
 
 'Write learned spells
 start = &h7C900
 for i as Integer = 1 to spellsets.Length()
  s = spellsets.PointerAt(i)
  if start + s->learning_spells.Length() + 1 > &h7CABF then
   WarningMessage(FF4Text("Learned spells overflow!"))
   exit for
  else
   for j as Integer = 1 to s->learning_spells.Length()
    WriteByte(start, asc(s->learning_levels.ItemAt(j)))
    WriteByte(start + 1, asc(s->learning_spells.ItemAt(j)))
    start += 2
   next
   WriteByte(start, &hFF)
   start += 1
  end if
 next

end sub
