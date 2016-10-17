function AsciiText(s as String) as String

 dim result as String
 
 for i as Integer = 1 to len(s)
  for j as Integer = 1 to len(asc2ff4)
   if mid(asc2ff4, j, 1) = mid(s, i, 1) then
    result += chr(j)
    exit for
   end if
  next
 next
 
 return result

end function
