function MapGrid.BytesUsed() as Integer

 return len(RunLengthEncoding())

end function


function MapGrid.RunLengthEncoding() as String

 dim tile as UByte
 dim runlength as Integer
 dim result as String
 
 if not no_data then
 
  for i as Integer = 0 to 31
   for j as Integer = 0 to 31
    if j = 0 and i = 0 then
     tile = tiles(j, i)
     runlength = 0
    else
     if tiles(j, i) = tile then
      runlength += 1
     else
      if runlength > 0 then
       do while runlength > &hFF
        result += chr(tile + &h80)
        result += chr(&hFF)
        runlength -= &h100
       loop
       result += chr(tile + &h80)
       result += chr(runlength)
      else
       result += chr(tile)
      end if
      tile = tiles(j, i)
      runlength = 0
     end if
    end if
   next
  next
  if runlength > 0 then
   do while runlength > &hFF
    result += chr(tile + &h80)
    result += chr(&hFF)
    runlength -= &h100
   loop
   result += chr(tile + &h80)
   result += chr(runlength)
  else
   result += chr(tile)
  end if
  
 end if
 
 return result
 
end function

