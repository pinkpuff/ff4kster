sub SaveAIs()

 dim start as UInteger
 dim entry as AIScriptEntry ptr
 
 'dim debug as UInteger

 'AI groups
 start = &h76230
 for i as Integer = 1 to total_ai_groups
  for j as Integer = 1 to len(aigroupconditions(i))
   WriteByte(start, asc(mid(aigroupconditions(i), j, 1)))
   'if i = 1 and j = 3 then debug = start + 1
   WriteByte(start + 1, asc(mid(aigroupscripts(i), j, 1)))
   start += 2
  next
  if right(aigroupscripts(i), 1) <> chr(&hFF) then 
   WriteByte(start, &hFF)
   start += 1
  end if
 next
 
 'Regular scripts
 start = &h76B00
 for i as Integer = 1 to &h100
  for j as Integer = 1 to scripts(i).Length()
   entry = scripts(i).PointerAt(j)
   WriteByte(start, entry->function_call)
   start += 1
   if ScriptTakesParameter(entry->function_call) then
    WriteByte(start, entry->parameter)
    start += 1
   end if
  next
  WriteByte(start, &hFF)
  start += 1
 next

 'Lunar scripts
 start = &h738C0
 for i as Integer = &h101 to total_scripts
  for j as Integer = 1 to scripts(i).Length()
   entry = scripts(i).PointerAt(j)
   WriteByte(start, entry->function_call)
   start += 1
   if ScriptTakesParameter(entry->function_call) then
    WriteByte(start, entry->parameter)
    start += 1
   end if
  next
  WriteByte(start, &hFF)
  start += 1
 next

 start = &h76800
 for i as Integer = 1 to total_condition_sets
  for j as Integer = 1 to len(conditionsets(i))
   WriteByte(start, asc(mid(conditionsets(i), j, 1)))
   start += 1
  next
  WriteByte(start, &hFF)
  start += 1
 next
 
 start = &h76900
 for i as Integer = 1 to total_conditions
  WriteByte(start, conditions(i).condition)
  WriteByte(start + 1, conditions(i).xx)
  WriteByte(start + 2, conditions(i).yy)
  WriteByte(start + 3, conditions(i).zz)
  start += 4
 next

 start = &h76200
 for i as Integer = 1 to total_condition_hps
  WriteByte(start, conditionhp(i) mod &h100)
  WriteByte(start + 1, conditionhp(i) \ &h100)
  start += 2
 next

end sub
