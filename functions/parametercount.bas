function ParameterCount(script_code as UByte) as UByte

 dim result as UByte
 
 select case script_code
  case &h00 to &hDA, &hFF: result = 0
  case &hE2, &hEB: result = 2
  case &hFC: if ifpatch then result = 2 else result = 1
  case &hFE: result = 4
  case else: result = 1
 end select
 
 return result

end function
