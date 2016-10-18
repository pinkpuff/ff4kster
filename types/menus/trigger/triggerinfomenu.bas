type TriggerInfoMenu

 dim x as UByte
 dim y as UByte
 dim underworld as Boolean
 dim t as Trigger ptr
 dim m as Integer
 dim location_menu as BlueMenu
 dim type_menu as BlueMenu
 dim parameters_menu as BlueMenu
 dim call_menu as EventCallMenu
 dim operation_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub UserSelect()

end type
