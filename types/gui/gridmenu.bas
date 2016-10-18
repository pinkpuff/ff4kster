type GridMenu

 x as UByte
 y as UByte
 options as Table
 max_columns as UByte
 max_rows as UByte
 window_x as Integer
 window_y as Integer
 cursor_x as Integer
 cursor_y as Integer
 cursor_w as Integer
 cursor_h as Integer
 brush as String
 tileset_index as UByte
 active as Boolean
 current_palette as UByte
 frame as UByte
 delay as Double
 cursor as Any ptr = 0
 foreground as Any ptr = 0
 background(4) as Any ptr
 bg_map as Integer
 bg_translucent as Boolean
 bg_dir as UByte
 bg_speed as UByte
 
 declare function Columns() as UInteger
 declare function Height() as UByte
 declare function ProcessKey(k as UInteger) as Boolean
 declare function Rows() as UInteger
 declare function UserInput() as Boolean
 declare function Width() as UByte
 
 declare sub Animate()
 declare sub ClearAll()
 declare sub Display()
 declare sub FloodFill(x as UByte, y as UByte, tile as String)
 declare sub SetBackgroundMap(index as Integer)
 declare sub SetCursorGraphic()
 declare sub UserSelect()

end type
