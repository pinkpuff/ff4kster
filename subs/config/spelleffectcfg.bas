sub ReadSpellEffects()

 dim temp as String
 
 for i as Integer = 1 to total_spell_effects
  spell_effects.Append(FF4Text("Effect " + Pad(str(i - 1), 3, true, "0")))
 next
 
 open "config/spelleffects.dat" for input as #1
  do until eof(1)
   line input #1, temp
   spell_effects.Assign(val(left(temp, 3)) + 1, FF4Text(mid(temp, 5)))
  loop
 close #1

end sub
