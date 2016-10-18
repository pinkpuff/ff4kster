type BlueMenu
 
 x as UInteger = 0
 y as UInteger = 0
 options as List
 colors as List
 cancelled as Boolean = false
 selected as UInteger = 1
 max_rows as UInteger = 0
 top_row as UInteger = 1
 columns as UByte = 1
 indexed_mode as Boolean = false
 swap_enabled as Boolean = false
 highlighted as UInteger = 0
 snapshot as Any ptr
 debug as Boolean = false
 
 declare constructor(starting_x as UInteger = 0, starting_y as UInteger = 0)
 
 declare function CursorX(h as Boolean = false) as UByte
 declare function CursorY(h as Boolean = false) as UByte
 declare function ProcessKey(key_code as UInteger) as Boolean
 declare function UserInput() as Boolean
 declare function WindowHeight() as UByte
 declare function WindowWidth() as UByte
 
 declare sub AddOption(s as String, c as UByte = 15)
 declare sub ChangeOption(index as UInteger, s as String = "", c as Integer = -1)
 declare sub ChangeSelected(index as UInteger)
 declare sub ClearAll()
 declare sub Display()
 declare sub Hide()
 declare sub Remove(index as UInteger = 0)
 declare sub RestoreSnapshot()
 declare sub ShowCursor()
 declare sub TakeSnapshot()
 declare sub UserSelect()
 
end type

