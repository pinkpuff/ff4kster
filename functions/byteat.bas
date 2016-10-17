function ByteAt(index as UInteger) as UByte
 
 return asc(mid(ff4rom, index + 1, 1))
 
end function
