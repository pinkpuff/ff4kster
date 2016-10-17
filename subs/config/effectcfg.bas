sub ReadEffects()

 dim temp as String
 
 for i as Integer = 1 to total_effects
  effect_names.Append(FF4Text("Effect " + Pad(str(i - 1), 3, true)))
 next
 
 open "config/effects.dat" for input as #1
  do until eof(1)
   line input #1, temp
   effect_names.Assign(val(left(temp, 3)) + 1, FF4Text(mid(temp, 6)))
  loop
 close #1

end sub
