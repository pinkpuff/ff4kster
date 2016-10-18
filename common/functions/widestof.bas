function WidestOf(s() as String)

 dim result as UInteger = 0
 
 for i as Integer = 1 to Length()
  if len(s(i)) > result then result = len(s(i))
 next
 
 return result

end function
