type BlueMessageInput

 x as UByte
 y as UByte
 w as UByte
 h as UByte
 lines as List
 topline as UInteger
 cursor_x as UByte
 cursor_y as UByte
 cursor as Any ptr
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0, starting_message as String = "")
 
 declare function Message() as String
 declare function UserInput() as Boolean
 
 declare sub Display()
 declare sub ParseMessage(m as String)
 declare sub ShowCursor()
 declare sub UserType()

end type
