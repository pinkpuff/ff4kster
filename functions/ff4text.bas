function FF4Text(s as String) as String
 
 'Converts an ASCII string into the corresponding FF4 string.
 
 dim result as String
 
 for i as UInteger = 1 to len(s)
  result += mid(asc2ff4, asc(mid(s, i, 1)), 1)
 next
 
 return result
 
end function
