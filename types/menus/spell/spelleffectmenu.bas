type SpellEffectMenu

 x as UByte
 y as UByte
 main_menu as BlueMenu
 casting_time as UByte
 target as UByte
 power as UByte
 hit as UByte
 effect as UByte
 mp_cost as UByte
 reflectable as Boolean
 boss as Boolean
 impact as Boolean
 damage as Boolean

 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(index as UByte)
 declare sub UserSelect()
 
end type
