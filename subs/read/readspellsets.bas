sub ReadSpellSets()

 dim s as SpellSet ptr
 dim start as UInteger
 dim temp as UByte
 'dim i as Integer
 'dim current as UByte
 
 start = &h7CAC0
 
 for i as Integer = 1 to total_spell_sets
  s = callocate(SizeOf(SpellSet))
  for j as Integer = 1 to 24
   temp = ByteAt(start)
   start += 1
   if temp = &hFF then exit for
   s->starting_spells.Append(chr(temp))
  next
  spellsets.Append(s)
 next

 'start = &h7CAC0
 
 'do
  's = callocate(SizeOf(SpellSet))
  'for i = 0 to 23
   'if ByteAt(start + i) = &hFF then 
    'i += 1
    'exit for
   'end if
   's->starting_spells.Append(chr(ByteAt(start + i)))
  'next
  'start += i
  'spellsets.Append(s)
 'loop until start >= &h7CBFF or spellsets.Length() = 256
 
 start = &h7C900
 
 for i as Integer = 1 to total_spell_sets
  s = spellsets.PointerAt(i)
  temp = ByteAt(start)
  start += 1
  do until temp = &hFF
   s->learning_levels.Append(chr(temp))
   s->learning_spells.Append(chr(ByteAt(start)))
   start += 1
   temp = ByteAt(start)
   start += 1
  loop
 next
 
 'start = &h7C900
 'i = 1
 
 'do
  'if ByteAt(start) = &hFF then
   'i += 1
   'start += 1
  'else
   'if i > spellsets.Length() then
    's = callocate(SizeOf(SpellSet))
   'else
    's = spellsets.PointerAt(i)
   'end if
   's->learning_levels.Append(chr(ByteAt(start)))
   's->learning_spells.Append(chr(ByteAt(start + 1)))
   'start += 2
  'end if
 'loop until start >= &h7CABF or spellsets.Length() = 256
 
 'i = spellsets.Length()
 's = spellsets.PointerAt(i)
 'do while s->starting_spells.Length() = 0 and s->learning_spells.Length() = 0
  'spellsets.Remove(i)
  'i = spellsets.Length()
  's = spellsets.PointerAt(i)
 'loop
 
 ReadSpellSetNames()
 
end sub
