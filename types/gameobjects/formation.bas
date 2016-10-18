type Formation

 mystery_flag1 as Boolean
 mystery_flag2 as Boolean
 mystery_flag3 as Boolean
 back_attack as Boolean      
 boss_death as Boolean       
 egg(3) as Boolean           
 monster_type(3) as UByte    
 mystery_qty as UByte
 monster_qty(3) as UByte     
 arrangement as UByte        
 no_flee as Boolean          
 no_gameover as Boolean      
 battle_music as UByte
 character_battle as Boolean 
 auto_battle as Boolean      
 floating as Boolean         
 transparent as Boolean
 mystery_byte as UByte
 rewards as Boolean
 
 declare function Preview() as String
 
 declare sub ReadFromROM(index as UInteger)
 declare sub WriteToROM(index as UInteger)

end type
