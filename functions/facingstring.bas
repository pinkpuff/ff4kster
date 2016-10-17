function FacingString(f as UByte) as String

 dim result as String
 
 select case f
  case 0: result = "Up"
  case 1: result = "Right"
  case 2: result = "Down"
  case 3: result = "Left"
 end select
 
 return result

end function
