function Roundup(n as Double) as Integer

 dim result as Integer
 
 if frac(n) > 0 then result = fix(n) + 1 else result = fix(n)
 
 return result

end function
