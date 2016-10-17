function StatName(index as UByte) as String
 
 dim result as String
 
 select case index
 case 1: result = "STR"
 case 2: result = "AGI"
 case 3: result = "VIT"
 case 4: result = "WIS"
 case 5: result = "WIL"
 end select
 
 return result
 
end function
