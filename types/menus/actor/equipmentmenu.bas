type EquipmentMenu

 x as UByte
 y as UByte
 starting_gear(5) as UByte
 right_ammo as UByte
 left_ammo as UByte
 main_menu as BlueMenu
 hand_menu as BlueMenu
 head_menu as BlueMenu
 body_menu as BlueMenu
 arms_menu as BlueMenu
 ammo_input as BlueNumberInput
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(index as UByte)
 declare sub UserSelect()

end type
