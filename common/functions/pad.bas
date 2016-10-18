#include once "../boolean.bas"

function Pad(s as String, length as UInteger, pad_from_front as Boolean = false, letter as String = " ") as String

 dim result as String

 if length > len(s) then
  if pad_from_front then
   result = string(length - len(s), letter) + s
  else
   result = s + string(length - len(s), letter)
  end if
 else
  result = s
 end if

 return result

end function