type AIMenu

 x as UByte
 y as UByte
 index as UInteger
 lunar as Boolean
 index_menu as BlueMenu
 condition_menu as BlueMenu
 set_menu as BlueMenu
 script_index as BlueMenu
 script_menu as BlueMenu
 condition_types as BlueMenu
 script_functions as BlueMenu
 condition_set_list as List
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare function CurrentCondition() as UByte
 
 declare sub Display()
 declare sub Hide()
 declare sub RefreshConditions()
 declare sub RefreshScripts()
 declare sub SetTo(new_index as UByte, new_lunar as Boolean = false)
 declare sub UserSelect()

end type
