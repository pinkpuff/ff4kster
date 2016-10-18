sub WriteByte(index as UInteger, b as UByte)
 
 mid(ff4rom, index + 1, 1) = chr(b)
 
end sub
