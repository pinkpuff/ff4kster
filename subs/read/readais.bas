sub ReadAIs()

 dim start as UInteger
 dim entry as AIScriptEntry ptr
 
 'Read the AI groups; each group is a series of pairs:
 ' The first item in the pair is the index of a condition set.
 ' The second item in the pair is the index of a script.
 start = &h76230
 for i as Integer = 1 to total_ai_groups
  do until ByteAt(start) = &hFF
   aigroupconditions(i) += chr(ByteAt(start))
   start += 1
   aigroupscripts(i) += chr(ByteAt(start))
   if ByteAt(start) < &hFF then start += 1
  loop
  start += 1
 next
 
 'Regular scripts
 start = &h76B00
 for i as Integer = 1 to &h100
  do until ByteAt(start) = &hFF
   entry = callocate(sizeof(AIScriptEntry))
   entry->function_call = ByteAt(start)
   start += 1
   if ScriptTakesParameter(entry->function_call) then
    entry->parameter = ByteAt(start)
    start += 1
   end if
   scripts(i).Append(entry)
  loop
  start += 1
 next
 
 'Lunar scripts
 start = &h738C0
 for i as Integer = &h101 to total_scripts
  do until ByteAt(start) = &hFF
   entry = callocate(sizeof(AIScriptEntry))
   entry->function_call = ByteAt(start)
   start += 1
   if ScriptTakesParameter(entry->function_call) then
    entry->parameter = ByteAt(start)
    start += 1
   end if
   scripts(i).Append(entry)
  loop
  start += 1
 next
 
 start = &h76800
 for i as Integer = 1 to total_condition_sets
  do until ByteAt(start) = &hFF
   conditionsets(i) += chr(ByteAt(start))
   start += 1
  loop
  start += 1
 next
 
 start = &h76900
 for i as Integer = 1 to total_conditions
  conditions(i).condition = ByteAt(start)
  conditions(i).xx = ByteAt(start + 1)
  conditions(i).yy = ByteAt(start + 2)
  conditions(i).zz = ByteAt(start + 3)
  start += 4
 next 
 
 start = &h76200
 for i as Integer = 1 to total_condition_hps
  conditionhp(i) = ByteAt(start) + ByteAt(start + 1) * &h100
  start += 2
 next

 'open "output.txt" for output as #1
  'for i as Integer = 1 to total_conditions
   'print #1, Pad(hex(i - 1), 2, true, "0"); ": ";
   'print #1, Pad(hex(conditions(i).condition), 2, true, "0"); " ";
   'print #1, Pad(hex(conditions(i).xx), 2, true, "0"); " ";
   'print #1, Pad(hex(conditions(i).yy), 2, true, "0"); " ";
   'print #1, Pad(hex(conditions(i).zz), 2, true, "0"); ": ";
   'print #1, conditions(i).TextDescription()
  'next
 'close #1
 'print "done"
 'getkey
 'end

end sub
