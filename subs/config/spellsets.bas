sub ReadSpellSetNames()

 dim s as SpellSet ptr
 dim temp as String
 dim index as UByte

 for i as Integer = 1 to spellsets.Length()
  spellset_names.Append(FF4Text("Spell set " + Pad(str(i), 3, true, "0")))
 next
 
 open "config/spellsets.dat" for input as #1
  do until eof(1)
   line input #1, temp
   index = val(left(temp, 2))
   spellset_names.Assign(index, FF4Text(mid(temp, 5)))
  loop
 close #1

end sub
