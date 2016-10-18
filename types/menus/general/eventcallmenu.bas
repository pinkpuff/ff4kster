type EventCallMenu

 x as UByte
 y as UByte
 e as EventCall ptr
 m as Integer
 call_menu as BlueMenu
 condition_menu as BlueMenu
 data_menu as BlueMenu

 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)

 declare sub Display()
 declare sub SetTo(p as EventCall ptr, associated_map as Integer)
 declare sub UpdateConditionMenu(index as UByte)
 declare sub UserSelect()

end type
