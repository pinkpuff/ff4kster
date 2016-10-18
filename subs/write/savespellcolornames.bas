sub SaveSpellColorNames()

 dim start as UInteger
 
 start = &hB3EE
 for i as Integer = 1 to 5
  WriteByte(start + i - 1, asc(mid(white_spellset_name, i)))
 next
 
 start = &hB3F6
 for i as Integer = 1 to 5
  WriteByte(start + i - 1, asc(mid(black_spellset_name, i)))
 next

 start = &hB3FE
 for i as Integer = 1 to 4
  WriteByte(start + i - 1, asc(mid(call_spellset_name, i)))
 next

 start = &hB405
 for i as Integer = 1 to 5
  WriteByte(start + i - 1, asc(mid(special_spellset_name, i)))
 next
 
 WriteByte(&hB1B3, special_spellset_actor)

end sub
