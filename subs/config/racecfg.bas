sub ReadRaceNames()
 
 dim temp as String
 
 for i as Integer = 1 to 8
  race_names.Append(FF4Text("Race " + str(i)))
 next
  
 open "config\races.dat" for input as #1
  do until eof(1)
   input #1, temp
   if val(left(temp, 1)) <= 8 then
    race_names.Assign(val(left(temp, 1)), FF4Text(mid(temp, 3)))
   end if
  loop
 close #1
  
end sub
