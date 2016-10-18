sub SpellSet.Sort()

 dim bucket(99) as List
 dim new_levels as List
 dim new_spells as List
 
 for i as Integer = 1 to learning_levels.Length()
  bucket(asc(learning_levels.ItemAt(i))).Append(learning_spells.ItemAt(i))
 next
 
 for i as Integer = 1 to 99
  for j as Integer = 1 to bucket(i).Length()
   new_levels.Append(chr(i))
   new_spells.Append(bucket(i).ItemAt(j))
  next
 next
 
 learning_levels = new_levels
 learning_spells = new_spells

end sub
