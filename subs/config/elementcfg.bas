sub ReadElementNames()
 
 dim temp as String
 
 for i as Integer = 1 to total_elements
  element_names.Append("Element " + str(i))
 next
 
 open "config\elements.dat" for input as #1
  do until eof(1)
   input #1, temp
   if val(left(temp, 2)) <= total_elements + total_extended_elements then
    element_names.Assign(val(left(temp, 2)), FF4Text(right(temp, len(temp) - 3)))
   end if
  loop
 close #1
 
end sub
