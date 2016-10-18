type BlueNumberInput

 x as UByte
 y as UByte
 number as UInteger
 starting_number as UInteger
 min_value as UInteger = 0
 max_value as UInteger = 255
 
 declare constructor(starting_x as UInteger = 0, starting_y as UInteger = 0)
 
 declare function UserInput() as Boolean
 
 declare sub Display()
 declare sub Hide()
 declare sub UserSelect()

end type
