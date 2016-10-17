sub ReadEventNames()

 dim temp as String

 for i as Integer = 1 to total_events
  event_names.Append(FF4Text("Event " + Pad(str(i), 3, true, "0")))
 next

 open "config/events.dat" for input as #1
 
  do until eof(1)
   line input #1, temp
   event_names.Assign(val(left(temp, 3)), FF4Text(mid(temp, 5)))
  loop
  
 close #1

end sub
