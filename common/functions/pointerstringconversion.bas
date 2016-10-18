function PointerToString(p as Any ptr) as String

 dim result as String
 dim temp as UInteger

 temp = cuint(p)
 for i as Byte = 1 to 4
  result += chr(temp mod 256)
  temp \= 256
 next

 return result

end function


function StringToPointer(s as String) as Any ptr

 dim result as UInteger

 for i as Byte = 1 to 4
  result += asc(mid(s, i, 1)) * 256 ^ (i - 1)
 next

 return cptr(Any ptr, result)

end function


