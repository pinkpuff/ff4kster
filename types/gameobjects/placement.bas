type Placement

 underground as Boolean
 npc_index as UByte
 x as UByte
 y as UByte
 walks as Boolean
 intangible as Boolean
 facing as UByte
 palette_index as UByte
 turns as Boolean
 marches as Boolean
 speed as UByte
 mysterybit15 as Boolean
 mysterybit16 as Boolean
 mysterybit25 as Boolean
 mysterybit26 as Boolean
 
 declare function Encode() as String
 
 declare sub Decode(s as String)

end type
