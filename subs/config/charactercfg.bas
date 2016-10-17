sub ReadCharacterLabels()

 dim temp as String
 
 for i as Integer = 1 to total_characters
  character_labels.Append(FF4Text("Character " + Pad(str(i), 2, true, "0")))
 next
 
 open "config/characters.dat" for input as #1
  do until eof(1)
   line input #1, temp
   character_labels.Assign(val(left(temp, 2)), FF4Text(mid(temp, 5)))
  loop
 close #1

end sub
