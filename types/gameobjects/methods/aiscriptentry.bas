function AIScriptEntry.TextDescription(include_parameter as Boolean = true) as String

 dim result as String
 dim temp as String
 
 select case function_call
 
  case 0 to &h30
   result = FF4Text("Cast ")
   if include_parameter then
    if function_call > 0 then result += spells(function_call).name + FF4Text(" on single")
   else
    result += FF4Text("a single-targeted spell")
   end if
   
  case &h31 to &h5E
   result = FF4Text("Cast ")
   if include_parameter then
    result += spells(function_call - &h30).name + FF4Text(" on group")
   else
    result += FF4Text("a group-targeted spell")
   end if
   
  case &h5F to &hBF
   result = FF4Text("Use ")
   if include_parameter then
    result += spells(function_call).name
   else
    result += FF4Text("a monster technique")
   end if
   
  case &hC0 to &hE7
   if function_call = &hE1 then
    result = FF4Text("Do nothing")
   else
    if include_parameter then
     result = menucommands(function_call - &hBF).name
    else
     result = FF4Text("Use a menu command")
    end if
   end if
   
  case &hE8
   result = FF4Text("Change race")
   if include_parameter then
    result += FF4Text(" to ")
    for i as Integer = 0 to 7
     if parameter and 2^i then temp += race_names.ItemAt(i + 1) + FF4Text(" ")
    next
    if len(temp) > 0 then temp = left(temp, len(temp) - 1) else temp = FF4Text("None")
    result += temp
   end if
   
  case &hE9
   result = FF4Text("Change attack")
   if include_parameter then
    result += FF4Text(" to ")
    result += FF4Text(str(parameter + 1))
    result += FF4Text(": " + str(stat_groups(parameter + 1).percentage) + "% " + str(stat_groups(parameter + 1).stat_base) + " x" + str(stat_groups(parameter + 1).multiplier))
   end if
   
  case &hEA
   result = FF4Text("Change defense")
   if include_parameter then
    result += FF4Text(" to ")
    result += FF4Text(str(parameter + 1))
    result += FF4Text(": " + str(stat_groups(parameter + 1).percentage) + "% " + str(stat_groups(parameter + 1).stat_base) + " x" + str(stat_groups(parameter + 1).multiplier))
   end if
   
  case &hEB
   result = FF4Text("Change magic defense")
   if include_parameter then
    result += FF4Text(" to ")
    result += FF4Text(str(parameter + 1))
    result += FF4Text(": " + str(stat_groups(parameter + 1).percentage) + "% " + str(stat_groups(parameter + 1).stat_base) + " x" + str(stat_groups(parameter + 1).multiplier))
   end if
   
  case &hEC
   result = FF4Text("Modify speed")
   if include_parameter then
    result += FF4Text(" by ")
    if parameter and &h80 then result += FF4Text("-") 'else result += FF4Text("+")
    result += FF4Text(str(parameter mod &h80))
   end if
   
  case &hED
   result = FF4Text("Set resistances")
   if include_parameter then
    result += FF4Text(" to ")
    for i as Integer = 0 to 7
     if parameter and 2^i then temp += element_names.ItemAt(i + 1) + FF4Text(", ")
    next
    if len(temp) >= 2 then temp = left(temp, len(temp) - 2) else temp = FF4Text("None")
    result += temp
   end if
   
  case &hEE
   result = FF4Text("Set spell power")
   if include_parameter then
    result += FF4Text(" to " + str(parameter))
   end if
   
  case &hEF
   result = FF4Text("Set weakness")
   if include_parameter then
    result += FF4Text(" to ")
    for i as Integer = 0 to 7
     if parameter and 2^i then temp += element_names.ItemAt(i + 1) + FF4Text(", ")
    next
    if len(temp) >= 2 then temp = left(temp, len(temp) - 2) else temp = FF4Text("None")
    result += temp
   end if
   
  case &hF0
   result = FF4Text("Set sprite")
   if include_parameter then
    result += FF4Text(" to " + str(parameter))
   end if
   
  case &hF1
   result = FF4Text("Show message")
   if include_parameter then
    result += FF4Text(" " + str(parameter + 1))
   end if
   
  case &hF2
   result = FF4Text("Next action, show message")
   if include_parameter then
    result += FF4Text(" " + str(parameter + 1))
   end if
   
  case &hF3
   result = FF4Text("Change music")
   if include_parameter then
    result += FF4Text(" to ") + song_names.ItemAt(parameter + 1)
   end if
   
  case &hF4
   result = FF4Text("Set condition flag")
   if include_parameter then
    if parameter = 1 then 
     result += FF4Text(" to current flag +1")
    elseif parameter >= &h80 then
     result += FF4Text(" to " + str(parameter - &h80))
    else
     result += FF4Text(" to ??")
    end if
   end if
   
  case &hF5
   result = FF4Text("Set reaction")
   if include_parameter then
    if parameter >= &h80 then
     result += FF4Text(" to " + str(parameter - &h80))
    else
     result += FF4Text(" to ??")
    end if
   end if
   
  case &hF7
   result = FF4Text("Darken screen")
   if include_parameter then result += FF4Text(": " + str(parameter))
 
  case &hF8
   result = FF4Text("Debug display")
   if include_parameter then result += FF4Text(": " + str(parameter))
   
  case &hF9
   result = FF4Text("Target")
   if include_parameter then
    result += FF4Text(" ")
    select case parameter
     case 0 to &h15
      'result += FF4Text("character " + str(parameter))
      result += actor_names.ItemAt(parameter)
     case &h16
      result += FF4Text("self")
     case &h17
      result += FF4Text("all monsters")
     case &h18
      result += FF4Text("all other monsters")
     case &h19
      result += FF4Text("all Type 1 monsters")
     case &h1A
      result += FF4Text("all Type 2 monsters")
     case &h1B
      result += FF4Text("all Type 3 monsters")
     case &h1C
      result += FF4Text("all front row characters")
     case &h1D
      result += FF4Text("all back row characters")
     case &h1E
      result += FF4Text("a stunned monster")
     case &h1F
      result += FF4Text("an asleep monster")
     case &h20
      result += FF4Text("a charmed monster")
     case &h21
      result += FF4Text("a critical monster")
     case &h22
      result += FF4Text("random monster or character")
     case &h23
      result += FF4Text("random other monster or character")
     case &h24
      result += FF4Text("random monster")
     case &h25
      result += FF4Text("random other monster")
     case &h26
      result += FF4Text("random front row character")
     case &h27
      result += FF4Text("random back row character")
     case &h28
      result += FF4Text("all characters")
     case &h29
      result += FF4Text("all KO monsters")
    end select
   end if
   
  case &hFB
   result += FF4Text("Chain into")
   
  case &hFC
   result += FF4Text("End chain")
   
  case &hFD
   result += FF4Text("Start a chain")
   
  case &hFE
   result += FF4Text("Wait")
  
  case &hFF
   result += FF4Text("End and repeat")
   
  case else
   result = FF4Text("- UNKNOWN -")
 
 end select
 
 return result

end function


function AIScriptEntry.FunctionToIndex() as UByte

 dim result as UByte
 
 select case function_call
  case 0 to &h30
   result = 1
  case &h31 to &h5E
   result = 2
  case &h5F to &hBF
   result = 3
  case &hC0 to &hE7
   if function_call = &hE1 then
    result = 5
   else
    result = 4
   end if
  case else
   result = function_call + 6 - &hE8
 end select
 
 return result

end function


sub AIScriptEntry.IndexToFunction(n as UByte, p as UByte = 0)

 select case n
  case 1
   function_call = p
  case 2
   function_call = &h31 + p
  case 3
   function_call = &h5F + p
  case 4
   function_call = &hC0 + p
  case 5
   function_call = &hE1
  case else
   function_call = n - 6 + &hE8
   parameter = p
 end select
 
end sub
