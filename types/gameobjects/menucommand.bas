type MenuCommand

 name as String
 target as UByte
 target_byte as UByte
 delay as UByte
 disabling_persistent as UByte
 disabling_temporary as UByte
 charging_stance as UByte
 action_stance as UByte
 action_stance2 as UByte
 action_stance3 as UByte
 spell(8) as UByte
 success(8) as UByte
 message(5) as UByte
 item_consumed as UByte
 item_effect as UByte
 item_visual as UByte
 regen_amount as UByte
 regen_freeze as Boolean
 disable_actor as UByte
 cover_actor as UByte
 cover_by_job as Boolean
 misc_bytes(8) as UByte
 
 declare static function HasParameters(index as UByte) as Boolean
 declare static function TargetsCorrectly(index as UByte) as Boolean
 
 declare sub ReadFromROM(index as UByte)
 declare sub WriteToROM(index as UByte)

end type
