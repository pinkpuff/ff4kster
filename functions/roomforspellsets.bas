function RoomForStartingSpells() as Boolean

 dim total_starting as UInteger
 dim s as SpellSet ptr
 
 for i as Integer = 1 to spellsets.Length()
  s = spellsets.PointerAt(i)
  total_starting += s->starting_spells.Length() + 1
 next
 
 return total_starting < 319

end function


function RoomForLearningSpells() as Boolean

 dim total_learning as UInteger
 dim s as SpellSet ptr
 
 for i as Integer = 1 to spellsets.Length()
  s = spellsets.PointerAt(i)
  total_learning += s->learning_spells.Length() * 2 + 1
 next
 
 return total_learning < 318

end function
