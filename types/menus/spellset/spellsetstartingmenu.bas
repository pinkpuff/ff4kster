type SpellSetStartingMenu

 x as UByte
 y as UByte
 s as SpellSet ptr
 main_menu as BlueMenu
 action_menu as BlueMenu
 spell_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(index as UByte)
 declare sub UserSelect()

end type
