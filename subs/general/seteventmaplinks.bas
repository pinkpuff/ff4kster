sub SetEventMapLinks()

 dim t as Trigger ptr
 dim e as EventCall ptr
 dim c as CallComponent ptr
 dim p as Placement ptr
 dim index as Integer
 
 for i as Integer = total_maps to 1 step -1
 
  for j as Integer = 1 to maps(i).triggers.Length()
   t = maps(i).triggers.PointerAt(j)
   if not t->warp and not t->treasure and t->event > 0 then
    e = eventcalls.PointerAt(t->event)
    if e = 0 then
     print "EVENT CALL OUT OF BOUNDS: "; t->event; "/"; eventcalls.Length()
     print "Terminating; press any key."
     getkey
     end
    else
     for k as Integer = 1 to e->components.Length()
      c = e->components.PointerAt(k)
      if c->event_reference > 0 then events(c->event_reference).map_link = i
     next
    end if
   end if
  next
  
  for j as Integer = 1 to placement_groups(i).placements.Length()
   p = placement_groups(i).placements.PointerAt(j)
   index = p->npc_index
   if p->underground then index += &h100
   e = @(npcs(index).speech)
   for k as Integer = 1 to e->components.Length()
    c = e->components.PointerAt(k)
    if c->event_reference > 0 then 
     events(c->event_reference).map_link = i
    end if
   next
  next

 next
 
end sub
