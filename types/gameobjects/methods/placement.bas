function Placement.Encode() as String

 dim result as String
 dim temp as UByte

 result = chr(npc_index)
 temp = x
 if mysterybit15 then temp += 2^5
 if mysterybit16 then temp += 2^6
 if walks then temp += 2^7
 result += chr(temp)
 temp = y
 if mysterybit25 then temp += 2^5
 if mysterybit26 then temp += 2^6
 if intangible then temp += 2^7
 result += chr(temp)
 temp = facing
 temp += palette_index * 4
 if turns then temp += 2^4
 if marches then temp += 2^5
 temp += speed * 2^6
 result += chr(temp)
 
 return result

end function


sub Placement.Decode(s as String)

 dim temp as UByte
 
 npc_index = asc(mid(s, 1, 1))
 temp = asc(mid(s, 2, 1))
 x = temp mod 2^5
 if temp and 2^5 then mysterybit15 = true else mysterybit15 = false
 if temp and 2^6 then mysterybit16 = true else mysterybit16 = false
 if temp and 2^7 then walks = true else walks = false
 temp = asc(mid(s, 3, 1))
 y = temp mod 2^5
 if temp and 2^5 then mysterybit25 = true else mysterybit25 = false
 if temp and 2^6 then mysterybit26 = true else mysterybit26 = false
 if temp and 2^7 then intangible = true else intangible = false
 temp = asc(mid(s, 4, 1))
 facing = temp mod 4
 palette_index = (temp \ 4) mod 4
 if temp and 2^4 then turns = true else turns = false
 if temp and 2^5 then marches = true else marches = false
 speed = temp \ 2^6

end sub
