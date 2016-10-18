type CommandParametersMenu

 x as UByte
 y as UByte
 id as UByte
 item_menu as BlueMenu
 spell_menu as BlueMenu
 success_input as BlueNumberInput
 slot_menu as BlueMenu
 multiplier_menu as BlueMenu
 stat_menu as BlueMenu
 message_menu as BlueMenu
 actor_menu as BlueMenu
 fight_menu as BlueMenu
 recall_menu as BlueMenu
 sing_menu as BlueMenu
 hide_menu as BlueMenu
 split_menu as BlueMenu
 pray_menu as BlueMenu
 charge_menu as BlueMenu
 bear_menu as BlueMenu
 twin_menu as BlueMenu
 boast_menu as BlueMenu
 cry_menu as BlueMenu
 cover_menu as BlueMenu
 steal_menu as BlueMenu
 regen_menu as BlueMenu
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0)
 
 declare sub Display()
 declare sub SetTo(index as UByte)
 declare sub UserSelect()

end type
