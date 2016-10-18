type SpellLinkMenu

 x as UByte
 y as UByte
 white as UByte
 black as UByte
 summon as UByte
 menu_white as UByte
 menu_black as UByte
 menu_summon as UByte
 spell_menu as BlueMenu
 unusable_job as Boolean
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(index as UByte)
 declare sub UserSelect()

end type
