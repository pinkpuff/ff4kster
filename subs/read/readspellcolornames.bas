sub ReadSpellColorNames()

 dim start as UInteger
 
 start = &hB3EE
 for i as Integer = 1 to 5
  white_spellset_name += chr(ByteAt(start + i - 1))
 next
 
 start = &hB3F6
 for i as Integer = 1 to 5
  black_spellset_name += chr(ByteAt(start + i - 1))
 next

 start = &hB3FE
 for i as Integer = 1 to 4
  call_spellset_name += chr(ByteAt(start + i - 1))
 next

 start = &hB405
 for i as Integer = 1 to 5
  special_spellset_name += chr(ByteAt(start + i - 1))
 next
 
 special_spellset_actor = ByteAt(&hB1B3)

end sub
