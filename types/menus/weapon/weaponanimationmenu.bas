type WeaponAnimationMenu
 
 x as UByte
 y as UByte
 main_menu as BlueMenu
 colors as UByte
 sprite as UByte
 swing as UByte
 slash as UByte
  
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(index as UInteger)
 declare sub UserSelect()
 
end type
