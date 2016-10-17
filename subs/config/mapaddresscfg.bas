sub ReadMapAddresses()

 dim temp as String
 
 open "config/maplocs.dat" for input as #1
  do until eof(1)
   line input #1, temp
   maps(val(left(temp, 3))).address = val("&h" + (mid(temp, 5)))
  loop
 close #1

end sub
