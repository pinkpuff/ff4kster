function AICondition.TextDescription(include_parameters as Boolean = true) as String

 dim result as String
 dim temp as String
 dim units as List
 
 for i as Integer = 0 to &hFF
  units.Append(FF4Text("unit " + str(i)))
 next
 units.Assign(23 + 1, FF4Text("self"))
 units.Assign(25 + 1, FF4Text("a character"))
 
 select case condition
  
  case 0
   if include_parameters then
    result = units.ItemAt(xx + 1) + FF4Text(" has ")
    for i as Integer = 0 to 7
     if zz and 2^i then temp += element_names.ItemAt(8 + yy * 8 + i + 1) + FF4Text(", ")
     'if zz and 2^i then temp += FF4Text(str(8 + yy * 8 + i + 1)) + FF4Text(", ")
    next
    if len(temp) >= 2 then temp = left(temp, len(temp) - 2)
    result += temp
   else
    result = FF4Text("unit has status")
   end if
  
  case 1
   if include_parameters then
    result = units.ItemAt(xx + 1) + FF4Text(" has " + Pad(str(conditionhp(zz + 1)), 5, true) + " HP or less")
   else
    result = FF4Text("unit has low HP")
   end if
   
  case 2
   if include_parameters then
    if yy = 0 then
     result = FF4Text("condition flag is ")
    else
     result = FF4Text("reaction  flag is ")
    end if
    result += FF4Text(Pad(str(zz), 3, true))
   else
    result = FF4Text("flag index")
   end if
   
  case 3
   if include_parameters then
    result = FF4Text("character " + Pad(str(xx), 3, true) + " is defeated")
   else
    result = FF4Text("character is defeated")
   end if
   
  case 4
   if include_parameters then
    result = FF4Text("monster " + Pad(str(xx), 3, true) + " is defeated")
   else
    result = FF4Text("monster is defeated")
   end if
  
  case 5
   if include_parameters then
    result = FF4Text("formation index is " + Pad(str(yy * &h100 + zz + 1), 3, true))
   else
    result = FF4Text("formation index")
   end if
   
  case 6
   result = FF4Text("all monsters are same type")
   
  case 7, 8
   if include_parameters then
    if xx > 0 then
     result = units.ItemAt(xx + 1)
    else
     result = FF4Text("any unit")
    end if
    result += FF4Text(" uses ")
    if zz > 0 then
     temp = ""
     for i as Integer = 0 to 7
      if zz and 2^i then temp += element_names.ItemAt(i + 1) + FF4Text("/")
     next
     result += left(temp, len(temp) - 1) + FF4Text(" ")
    end if
    select case yy
     case 192
      result += menucommands(1).name
     case 194
      result += FF4Text("magic")
     case 196
      result += menucommands(5).name
     case 197
      result += menucommands(6).name
     case 199
      result += menucommands(8).name
     case 200
      result += menucommands(9).name
     case 204
      result += menucommands(13).name
     case 205
      result += menucommands(14).name
     case 206
      result += menucommands(15).name
     case 208
      result += menucommands(17).name
     case 210
      result += menucommands(19).name
     case 212
      result += menucommands(21).name
     case 214
      result += menucommands(23).name
     case 215
      result += menucommands(24).name
     case 222
      result += menucommands(7).name
     case else
      result += FF4Text(str(yy))
    end select
   else
    result = FF4Text("unit uses command")
   end if
   
  case 9
   result = FF4Text("unknown")
   
  case 10
   result = FF4Text("takes damage")
   
  case 11
   result = FF4Text("only monster left")
   
  case else
   result = FF4Text("no condition")
   
 end select
 
 units.Destroy()
 
 return result

end function
