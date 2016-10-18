function EventCall.Encode() as String

 dim result as String
 dim c as CallComponent ptr
 
 for i as Integer = 1 to components.Length()
  c = components.PointerAt(i)
  for j as Integer = 1 to c->true_conditions.Length()
   result += chr(&hFE) + c->true_conditions.ItemAt(j)
  next
  for j as Integer = 1 to c->false_conditions.Length()
   result += c->false_conditions.ItemAt(j)
  next
  result += chr(&hFF) + chr(c->event_reference)
 next
 
 for i as Integer = 1 to parameters.Length()
  result += parameters.ItemAt(i)
 next

 return result

end function


sub EventCall.Decode(s as String)

 dim cursor as UByte
 dim c as CallComponent ptr
 dim complete as Boolean
 
 c = callocate(SizeOf(CallComponent))
 cursor = 1
 
 do until cursor > len(s)
  select case asc(mid(s, cursor, 1))
   case &hFF
    if cursor + 1 <= len(s) then
     cursor += 1
     c->event_reference = asc(mid(s, cursor, 1))
     components.Append(c)
     c = callocate(SizeOf(CallComponent))
     complete = true
    end if
   case &hFE
    if cursor + 1 <= len(s) then
     cursor += 1
     c->true_conditions.Append(mid(s, cursor, 1))
     complete = false
    end if
   case else
    c->false_conditions.Append(mid(s, cursor, 1))
    complete = false
  end select
  cursor += 1
 loop
 
 if not complete and c->false_conditions.Length() > 0 then
  for i as Integer = 1 to c->false_conditions.Length()
   parameters.Append(c->false_conditions.ItemAt(i))
  next
  deallocate(c)
 end if

end sub
