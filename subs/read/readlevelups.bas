sub ReadLevelups()

 dim start as UInteger
 dim level_ptr(total_characters) as UInteger
 dim temp as UInteger
 dim next_char as UByte
 
 start = &h7B700
 next_char = 1

 for i as Integer = 1 to total_actors
  temp = ByteAt(start + (i - 1) * 2)
  temp += ByteAt(start + (i - 1) * 2 + 1) * &h100
  for j as Integer = 1 to i - 1
   if level_ptr(j) = temp then
    actors(i).level_link = j
   end if
  next
  if actors(i).level_link = 0 then
   level_ptr(next_char) = temp
   actors(i).level_link = next_char
   next_char += 1
  end if
 next

end sub
