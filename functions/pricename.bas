function PriceName(index as UByte) as String

 dim result as UInteger
 
 if index < &h80 then
  result = index * 10
 else
  result = (index - 128) * 1000
 end if
 
 return str(result)

end function
