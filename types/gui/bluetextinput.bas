type BlueTextInput

 x as UByte
 y as UByte
 starting_text as String
 text_width as UByte
 text as String
 cursor as Boolean
 extended as Boolean
 
 declare constructor(starting_x as UByte = 0, starting_y as UByte = 0, text_width as UByte = 0)
 
 declare function ShownText() as String
 
 declare sub ChangeStartingText(new_text as String)
 declare sub Display()
 declare sub Hide()
 declare sub ShowCursor()
 declare sub UserType()

end type
