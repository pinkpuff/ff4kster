function IsWeapon(index as UByte) as Boolean

 return index > 0 and index <= total_weapons

end function


function IsHandArmor(index as UByte) as Boolean

 return index > total_weapons + 1 and index < head_start

end function


function IsHeadArmor(index as UByte) as Boolean

 return index >= head_start and index < body_start
 
end function


function IsBodyArmor(index as UByte) as Boolean

 return index >= body_start and index < arms_start

end function


function IsArmsArmor(index as UByte) as Boolean

 return index >= arms_start and index <= arms_end
 
end function


function IsArmor(index as UByte) as Boolean

 return IsHandArmor(index) or IsHeadArmor(index) or IsBodyArmor(index) or IsArmsArmor(index)
 
end function


function EquipsHand(index as UByte) as Boolean

 return IsWeapon(index) or IsHandArmor(index)
 
end function


function IsTwoHanded(index as UByte) as Boolean

 return index >= twohanded_start and index < bow_start
 
end function


function IsBow(index as UByte) as Boolean

 return index >= bow_start and index < arrow_start

end function


function IsArrow(index as UByte) as Boolean

 return index >= arrow_start and index <= arrow_end
 
end function
