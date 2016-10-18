function Event.Length() as UInteger

 dim result as UInteger
 
 for i as Integer = 1 to script.Length()
  result += len(script.ItemAt(i))
 next
 
 for i as Integer = 1 to else_script.Length()
  result += len(else_script.ItemAt(i))
 next
 
 return result

end function


function Event.ScriptEntry(entry as String, actual_map as UInteger = 0) as String

 dim result as String
 dim function_call as UByte
 dim xx as UByte
 dim yy as UByte
 dim zz as UByte
 dim ww as UByte
 dim p as Placement ptr
 dim temp as Integer
 dim underground as Integer
 
 if actual_map = 0 then actual_map = map_link
 if actual_map < 256 then underground = 0 else underground = &h100
 
 function_call = asc(left(entry, 1))
 if len(entry) > 1 then xx = asc(mid(entry, 2))
 if len(entry) > 2 then yy = asc(mid(entry, 3))
 if len(entry) > 3 then zz = asc(mid(entry, 4))
 if len(entry) > 4 then ww = asc(mid(entry, 5))
 
 select case function_call
  case &hFF
   result = FF4Text("--END--")
  case &hFE
   result = FF4Text("Load ")
   if (ww and &h80) and xx + &h101 <= map_names.Length() then
    result += map_names.ItemAt(xx + &h101)
   else
    result += map_names.ItemAt(xx + 1)
   end if
   result += FF4Text(" at " + str(yy))
   result += FF4Text(", " + str(zz))
   select case ww mod &h20
    case &h1: result += FF4Text(" on yellow chocobo")
    case &h2: result += FF4Text(" on black chocobo")
    case &h3: result += FF4Text(" on hovercraft")
    case &h4: result += FF4Text(" on Enterprise")
    case &h5: result += FF4Text(" on Falcon")
    case &h6: result += FF4Text(" on Lunar Whale")
    case is >= &h7: result += FF4Text(" on ship")
   end select
   'if ww and &h80 then result += FF4Text(", on moon")
   if ww and &h20 then result += FF4Text(", no transition")
   if ww and &h40 then result += FF4Text(", no dust")
  case &hFD
   result = FF4Text("Visual effect: ") + vfx.ItemAt(xx + 1)
  case &hFC
   if ifpatch then
    result = FF4Text("If ") + flag_names.ItemAt((xx mod &h80) + 1) + FF4Text(" is " + iif(xx and &h80, "OFF", "ON") + " do the next " + str(yy) + " actions")
   else
    result = FF4Text("Crash game " + str(xx))
   end if
  case &hFB
   result = FF4Text("Sound effect: ") + sound_effects.ItemAt(xx + 1)
  case &hFA
   result = FF4Text("Play song: ") + song_names.ItemAt(xx + 1)
  case &hF9
   result = FF4Text("Toggle screen tint: " + str(xx))
  case &hF8
   result = FF4Text("Show message " + str(xx + &h101) + " with Yes/No box. If YES:")
  case &hF7
   result = FF4Text("Item selection window looking for ") + item_names.ItemAt(xx + 1)
  case &hF6
   result = FF4Text("Show message " + str(xx + 1) + " from bank 3")
  case &hF5
   result = FF4Text("Deactivate ") + npc_names.ItemAt(xx + 1 + underground)
  case &hF4
   result = FF4Text("Activate ") + npc_names.ItemAt(xx + 1 + underground)
  case &hF3
   result = FF4Text("Clear flag: ") + flag_names.ItemAt(xx + 1)
  case &hF2
   result = FF4Text("Set flag: ") + flag_names.ItemAt(xx + 1)
  case &hF1
   result = FF4Text("Show message " + str(xx + &h101) + " from bank 1")
  case &hF0
   result = FF4Text("Show message " + str(xx + 1) + " from bank 1")
  case &hEF
   result = FF4Text("Show message " + str(xx + 1) + " from bank 2, starting from map pointer")
  case &hEE
   result = FF4Text("Show message " + str(xx + 1) + " from event call, from bank 2")
  case &hED
   result = FF4Text("Shop: ") + shop_names.ItemAt(xx + 1)
  case &hEC
   result = FF4Text("Fight battle: ") + formation_names.ItemAt(xx + 1 + underground)
  case &hEB
   result = FF4Text("Simultaneously do the next " + str(yy) + " actions")
   if xx > 1 then result += FF4Text(" " + str(xx) + " times")
   result += FF4Text(":")
  case &hEA
   result = FF4Text("Fade in song: ") + song_names.ItemAt(xx + 1)
  case &hE9
   result = FF4Text("Pause " + str(xx) + " cycles")
  case &hE8
   result = FF4Text("Remove actor from party: ") + actor_names.ItemAt(xx)
  case &hE7
   result = FF4Text("Add actor to party: ") + actor_names.ItemAt(xx)
  case &hE6
   result = FF4Text("Subtract " + str(xx * 100) + " Gil")
  case &hE5
   result = FF4Text("Add " + str(xx * 100) + " Gil")
  case &hE4
   result = FF4Text("Add statuses: ")
   if xx = 0 then
    result += "None"
   else
    for i as Integer = 0 to 7
     if xx and 2^i then result += element_names.ItemAt(i + 9) + ", "
    next
    result = left(result, len(result) - 2)
   end if
  case &hE3
   result = FF4Text("Remove all statuses")
   if xx > 0 then
    result += FF4Text(" but ")
    for i as Integer = 0 to 7
     if xx and 2^i then result += element_names.ItemAt(i + 9) + ", "
    next
    result = left(result, len(result) - 2)
   end if
  case &hE2
   result = FF4Text("Put ") + spells(yy).name + FF4Text(" into ") + spellset_names.ItemAt(xx + 1)
  case &hE1
   result = FF4Text("Remove ") + item_names.ItemAt(xx + 1) + FF4Text(" from inventory")
  case &hE0
   result = FF4Text("Add ") + item_names.ItemAt(xx + 1) + FF4Text(" to inventory")
  case &hDF
   result = FF4Text("Restore " + str(xx * 10) + " MP")
  case &hDE
   result = FF4Text("Restore " + str(xx * 10) + " HP")
  case &hDD
   result = FF4Text("Change character graphic to " + str(xx))
  case &hDC
   result = FF4Text("Inn with cost index " + str(xx))
  case &hDB
   result = FF4Text("Toggle statuses: ")
   if xx = 0 then
    result += "None"
   else
    for i as Integer = 0 to 7
     if xx and 2^i then result += element_names.ItemAt(i + 9) + FF4Text(", ")
    next
    result = left(result, len(result) - 2)
   end if
  case &hDA
   result = FF4Text("Toggle screen fade")
  case &hD9
   result = FF4Text("Open namingway screen")
  case &hD8
   result = FF4Text("Toggle music fade")
  case &hD7
   result = FF4Text("Toggle running")
  case &hD6
   result = FF4Text("Move screen up and down one tile")
  case &hD5
   result = FF4Text("Open a door")
  case &hD4
   result = FF4Text("Open fat chocobo screen")
  case &hD3
   result = FF4Text("Travel to/from moon")
  case &hD2
   result = FF4Text("Screen blur and unblur")
  case &hD1
   result = FF4Text("Screen flash")
  case &hD0
   result = FF4Text("Toggle screen shake")
  case else
   if function_call \ &h10 = &hC then 
    result = "You "
    select case function_call mod &h10
     case 0: result += "move up"
     case 1: result += "move right"
     case 2: result += "move down"
     case 3: result += "move left"
     case 4: result += "face up"
     case 5: result += "face right"
     case 6: result += "face down"
     case 7: result += "face left"
     case 8: result += "become invisible"
     case 9: result += "become visible"
     case 10: result += "wave in"
     case 11: result += "wave out"
     case 12: result += "bow head"
     case 13: result += "lie down"
     case 14: result += "toggle turning"
     case 15: result += "toggle spinning"
    end select
    result = FF4Text(result)
   else 
    result = FF4Text("Placement " + str(function_call \ &h10 + 1) + ": ")
    if function_call \ &h10 + 1 <= placement_groups(actual_map).placements.Length() then
     p = placement_groups(actual_map).placements.PointerAt(function_call \ &h10 + 1)
     temp = p->npc_index
     if p->underground then temp += &h100
     result += npc_names.ItemAt(temp + 1) + FF4Text(" ")
    else
     result += FF4Text("-N/A- ")
    end if
    select case function_call mod &h10
     case 0: result += FF4Text("moves up")
     case 1: result += FF4Text("moves right")
     case 2: result += FF4Text("moves down")
     case 3: result += FF4Text("moves left")
     case 4: result += FF4Text("faces up")
     case 5: result += FF4Text("faces right")
     case 6: result += FF4Text("faces down")
     case 7: result += FF4Text("faces left")
     case 8: result += FF4Text("toggles visibility")
     case 9: result += FF4Text("jumps sideways")
     case 10: result += FF4Text("spins")
     case 11: result += FF4Text("does a spin-jump")
     case 12: result += FF4Text("waves in")
     case 13: result += FF4Text("waves out")
     case 14: result += FF4Text("bows head")
     case 15: result += FF4Text("lies down")
    end select
   end if
 end select
 
 return Pad(left(result, 78), 78, false, FF4Text(" "))

end function


sub Event.ReadFromROM(index as UByte)

 dim start as UInteger
 dim else_clause as Boolean
 dim temp as UByte
 dim entry as String
 dim i as Integer
 
 start = ByteAt(&h90200 + (index) * 2) + ByteAt(&h90200 + (index) * 2 + 1) * &h100 + &h90400
 
 i = 0
 else_clause = false
 do
  temp = ByteAt(start + i)
  if temp = &hF8 then else_clause = true
  entry = chr(temp)
  i += 1
  for j as Integer = 1 to ParameterCount(temp)
   entry += chr(ByteAt(start + i))
   i += 1
  next
  script.Append(entry)
 loop until temp = &hFF
 
 if else_clause then
  do
   temp = ByteAt(start + i)
   'if temp = &hF8 then else_clause = true
   entry = chr(temp)
   i += 1
   for j as Integer = 1 to ParameterCount(temp)
    entry += chr(ByteAt(start + i))
    i += 1
   next
   else_script.Append(entry)
  loop until temp = &hFF  
 end if

 if ifpatch then IfParameterBytesToInstructions()
 
end sub


sub Event.IfParameterBytesToInstructions()

 dim i as Integer
 dim p as Integer
 dim entry as String
 dim temp as UByte

 for j as Integer = 1 to script.Length()
  entry = script.ItemAt(j)
  if asc(left(entry, 1)) = &hFC then
   p = asc(right(entry, 1))
   i = 1
   do while i < p
    entry = script.ItemAt(j + i)
    temp = asc(left(entry, 1))
    p -= ParameterCount(temp)
    i += 1
   loop
   entry = script.ItemAt(j)
   mid(entry, 3, 1) = chr(p)
   script.Assign(j, entry)
  end if
 next

 for j as Integer = 1 to else_script.Length()
  entry = else_script.ItemAt(j)
  if asc(left(entry, 1)) = &hFC then
   p = asc(right(entry, 1))
   i = 1
   do while i < p
    entry = else_script.ItemAt(j + i)
    temp = asc(left(entry, 1))
    p -= ParameterCount(temp)
    i += 1
   loop
   entry = else_script.ItemAt(j)
   mid(entry, 3, 1) = chr(p)
   else_script.Assign(j, entry)
  end if
 next

end sub


sub Event.IfParameterInstructionsToBytes()

 dim entry as String
 dim temp as Integer
 dim p as Integer
 
 for i as Integer = 1 to script.Length()
  entry = script.ItemAt(i)
  if asc(left(entry, 1)) = &hFC then
   temp = asc(right(entry, 1))
   p = temp
   for j as Integer = 1 to temp
    if i + j > script.Length() then
     exit for
    else
     p += ParameterCount(asc(left(script.ItemAt(i + j), 1)))
    end if
   next
   mid(entry, 3, 1) = chr(Min(p, &hFF))
   script.Assign(i, entry)
  end if
 next

 for i as Integer = 1 to else_script.Length()
  entry = else_script.ItemAt(i)
  if asc(left(entry, 1)) = &hFC then
   temp = asc(right(entry, 1))
   p = temp
   for j as Integer = 1 to temp
    if i + j > else_script.Length() then
     exit for
    else
     p += ParameterCount(asc(left(else_script.ItemAt(i + j), 1)))
    end if
   next
   mid(entry, 3, 1) = chr(Min(p, &hFF))
   else_script.Assign(i, entry)
  end if
 next

end sub


sub Event.WriteToROM(index as UByte, offset as UInteger)

 if ifpatch then IfParameterInstructionsToBytes()
 
 for i as Integer = 1 to script.Length()
  for j as Integer = 1 to len(script.ItemAt(i))
   WriteByte(offset, asc(mid(script.ItemAt(i), j, 1)))
   offset += 1
  next
 next
 
 for i as Integer = 1 to else_script.Length()
  for j as Integer = 1 to len(else_script.ItemAt(i))
   WriteByte(offset, asc(mid(else_script.ItemAt(i), j, 1)))
   offset += 1
  next
 next
 
 if ifpatch then IfParameterBytesToInstructions()

end sub
