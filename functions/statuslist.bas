function StatusList(b as UByte, listname as String) as String

 dim result as String
 dim id as UByte = 1
 
 select case lcase(listname)
  case "element":    id = 0
  case "persistent": id = 1
  case "temporary":  id = 2
  case "system":     id = 3
  case "hidden":     id = 4
 end select
 
 for i as Integer = 0 to 7
  if b and 2^i then result += element_names.ItemAt(id * 8 + i + 1) + FF4Text(", ")
 next
 
 if len(result) = 0 then result = FF4Text("none") else result = left(result, len(result) - 2)
 
 return result

end function
