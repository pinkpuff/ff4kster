function ScriptTakesParameter(function_call as UByte) as Boolean

 dim result as Boolean
 
 select case function_call
  case &hE8 to &hF9
   result = true
  case else
   result = false
 end select
 
 return result

end function
