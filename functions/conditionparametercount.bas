function ConditionParameterCount(condition as UByte) as UByte

 dim result as UByte

 select case condition
  case 0: result = 3
  case 1: result = 2
  case 2: result = 2
  case 3: result = 1
  case 4: result = 1
  case 5: result = 2
  case 6: result = 0
  case 7: result = 3
  case 8: result = 3
  case 9: result = 0
  case 10: result = 0
  case 11: result = 0
 end select
 
 return result

end function
