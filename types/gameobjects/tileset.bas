type SpriteSheet

 offset as UInteger
 animated_offset as UInteger = 0
 bpp as UByte = 3
 sprite(2 ^ 10 - 1 + &h80, 8, 8) as UByte

 declare sub ReadFromROM()

end type


type TileSprite

 graphic as Any ptr

 sprite_index as Integer

 tt1 as Boolean
 tt2 as Boolean
 animated as Boolean
 mystery_bit as Boolean
 major_index as UByte
 minor_index as UByte
 
 special as Boolean
 palette_index as UByte '3 bits
 front as Boolean
 hflip as Boolean
 vflip as Boolean
 
 declare function IsAnimated() as Boolean

 declare sub Display(x as UByte, y as UByte, target as Any ptr = 0)
 declare sub SetGraphic(sprite_sheet as UByte, current_palette as UByte = 0, frame as UByte = 0)

end type


type Tile

 graphic as Any ptr
 frame2 as Any ptr
 frame3 as Any ptr
 frame4 as Any ptr
 
 sprite_sheet as UByte
 sprite(4) as TileSprite
 
 layer_1 as Boolean
 layer_2 as Boolean
 bridge_layer as Boolean
 save_point as Boolean
 closed_door as Boolean
 mystery_bit_15 as Boolean
 mystery_bit_16 as Boolean
 mystery_bit_17 as Boolean
 
 damage_floor as Boolean
 mystery_bit_21 as Boolean
 walk_behind as Boolean
 bottom_half as Boolean
 warp as Boolean
 talkover as Boolean
 encounters as Boolean
 triggerable as Boolean
 
 declare sub Display(x as UByte, y as UByte, target as Any ptr = 0, frame as UByte = 0)
 declare sub SetGraphic(current_palette as UByte = 0)

end type


type Tileset

 sprite_sheet as UByte
 tiles(&h80) as Tile

 declare sub Display(x as UByte, y as UByte)
 declare sub ReadFromROM(index as Integer)
 declare sub SetGraphics(current_palette as UByte = 0)
 declare sub WriteToROM(index as Integer)

end type
