type ScriptEntryMenu

 x as UByte
 y as UByte
 blank as Any ptr
 function_call as UByte
 xx as UByte
 yy as UByte
 zz as UByte
 ww as UByte
 map_link as UInteger
 main_menu as BlueMenu
 character_menu as BlueMenu
 character_movement_menu as BlueMenu
 enter_xx as BlueNumberInput
 enter_yy as BlueNumberInput
 status_menu as BlueMenu
 item_menu as BlueMenu
 spell_menu as BlueMenu
 spellset_menu as BlueMenu
 actor_menu as BlueMenu
 song_menu as BlueMenu
 sfx_menu as BlueMenu
 formation_menu as BlueMenu
 shop_menu as BlueMenu
 flag_menu as BlueMenu
 onoff_menu as BlueMenu
 npc_menu as BlueMenu
 map_menu as BlueMenu
 vehicle_menu as BlueMenu
 properties_menu as BlueMenu
 message_menu as BlueMenu
 vfx_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare function Entry() as String

 declare sub Display()
 declare sub SetFunctionType()
 declare sub SetTo(new_entry as String, actual_map as UInteger)
 declare sub UserSelect()

end type
