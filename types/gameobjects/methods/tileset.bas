sub SpriteSheet.ReadFromROM()

 dim start as UInteger
 dim b as UByte

 for i as Integer = 0 to 2 ^ 10 - 1 + &h80 '&h19F
 
  'if i < &h120 or i >= &h130 then 
   'start = offset 
  'elseif animated_offset > 0 then
   'start = animated_offset - &h120 * bpp * 8
  ''else
   '''exit for
   ''start = offset '- (&h10 * bpp * 8)
  'end if
  
  if i < 2 ^ 10 then
   start = offset
  else
   start = animated_offset - (2 ^ 10 * bpp * 8)
  end if

  if bpp < 4 then

   for j as Integer = 0 to 7
    b = ByteAt(start + i * bpp * 8 + j * 2)
    for k as Integer = 0 to 7
     sprite(i, k, j) = (b \ 2^k) and 1
    next
    b = ByteAt(start + i * bpp * 8 + j * 2 + 1)
    for k as Integer = 0 to 7
     sprite(i, k, j) += ((b \ 2^k) and 1) * 2
    next
   next
   
   if bpp = 3 then
    for j as Integer = 0 to 7
     b = ByteAt(start + i * bpp * 8 + 16 + j)
     for k as Integer = 0 to 7
      sprite(i, k, j) += ((b \ 2^k) and 1) * 4
     next
    next
   end if
  
  elseif bpp = 4 then
  
   for j as Integer = 0 to 7
    b = ByteAt(start + i * 32 + j * 2)
    for k as Integer = 0 to 7
     sprite(i, k, j) = (b \ 2^k) and 1
    next
    b = ByteAt(start + i * 32 + j * 2 + 1)
    for k as Integer = 0 to 7
     sprite(i, k, j) += ((b \ 2^k) and 1) * 2
    next
   next

   for j as Integer = 0 to 7
    b = ByteAt(start + i * 32 + 16 + j * 2)
    for k as Integer = 0 to 7
     sprite(i, k, j) += ((b \ 2^k) and 1) * 4
    next
    b = ByteAt(start + i * 32 + 16 + j * 2 + 1)
    for k as Integer = 0 to 7
     sprite(i, k, j) += ((b \ 2^k) and 1) * 8
    next
   next

  end if
  
 next

end sub


function TileSprite.IsAnimated() as Boolean

 return sprite_index >= &h120 and sprite_index <= &h12F

end function


sub TileSprite.Display(x as UByte, y as UByte, target as Any ptr = 0)

 put target, (x, y), graphic, trans

end sub


sub TileSprite.SetGraphic(sprite_sheet as UByte, current_palette as UByte = 0, frame as UByte = 0)

 dim h as Integer
 dim v as Integer
 dim s as Integer
 
 if IsAnimated() then
  s = 2 ^ 10 + major_index * 16 + minor_index + frame * 4
 'elseif sprite_index >= &h130 then
  's = sprite_index '- &h10
 else
  s = sprite_index
 end if
 
 for i as Integer = 0 to 7
  for j as Integer = 0 to 7
   if hflip then h = 7 - i else h = i
   if vflip then v = 7 - j else v = j
   if spritesheets(sprite_sheet).sprite(s, h, v) = 0 then
    pset graphic, (i, j), RGB(255, 0, 255)
   else
    pset graphic, (i, j), map_palettes(current_palette, palette_index, spritesheets(sprite_sheet).sprite(s, h, v))
   end if
  next
 next

end sub


sub Tile.Display(x as UByte, y as UByte, target as Any ptr = 0, frame as UByte = 0)

 if sprite(1).IsAnimated() then
  select case frame
   case 0: put target, (x * 8, y * 8), graphic, trans
   case 1: put target, (x * 8, y * 8), frame2, trans
   case 2: put target, (x * 8, y * 8), frame3, trans
   case 3: put target, (x * 8, y * 8), frame4, trans
  end select
 else
  put target, (x * 8, y * 8), graphic, trans
 end if

end sub


sub Tile.SetGraphic(current_palette as UByte = 0)

 dim passage as Boolean
 
 for i as Integer = 1 to 4
  sprite(i).SetGraphic(sprite_sheet, current_palette)
  put graphic, (((i - 1) mod 2) * 8, ((i - 1) \ 2) * 8), sprite(i).graphic, pset
 next
 
 if sprite(1).IsAnimated() then

  for i as Integer = 1 to 4
   sprite(i).SetGraphic(sprite_sheet, current_palette, 1)
   put frame2, (((i - 1) mod 2) * 8, ((i - 1) \ 2) * 8), sprite(i).graphic, pset
  next
  
  for i as Integer = 1 to 4
   sprite(i).SetGraphic(sprite_sheet, current_palette, 2)
   put frame3, (((i - 1) mod 2) * 8, ((i - 1) \ 2) * 8), sprite(i).graphic, pset
  next
  
  for i as Integer = 1 to 4
   sprite(i).SetGraphic(sprite_sheet, current_palette, 3)
   put frame4, (((i - 1) mod 2) * 8, ((i - 1) \ 2) * 8), sprite(i).graphic, pset
  next
  
 end if
 
 if triggerable then
  if layer_1 then
   put graphic, (0, 0), trigger_overlay, trans
   if sprite(1).IsAnimated then
    put frame2, (0, 0), trigger_overlay, trans
    put frame3, (0, 0), trigger_overlay, trans
    put frame4, (0, 0), trigger_overlay, trans
   end if
  else
   put graphic, (0, 0), chest_overlay, trans
   if sprite(1).IsAnimated then
    put frame2, (0, 0), chest_overlay, trans
    put frame3, (0, 0), chest_overlay, trans
    put frame4, (0, 0), chest_overlay, trans
   end if
  end if
 end if
 
 if layer_1 then
  passage = true
  for i as Integer = 1 to 4
   if sprite(i).front = false then
    passage = false
    exit for
   end if
  next
  if passage then
   put graphic, (0, 0), passage_overlay, trans
   if sprite(1).IsAnimated then
    put frame2, (0, 0), passage_overlay, trans
    put frame3, (0, 0), passage_overlay, trans
    put frame4, (0, 0), passage_overlay, trans
   end if
  end if
 end if
 
 if warp then
  put graphic, (0, 0), warp_overlay, trans
  if sprite(1).IsAnimated then
   put frame2, (0, 0), warp_overlay, trans
   put frame3, (0, 0), warp_overlay, trans
   put frame4, (0, 0), warp_overlay, trans
  end if
 end if
 
end sub


sub Tileset.Display(x as UByte, y as UByte)

 for i as Integer = 0 to &h7F
  tiles(i + 1).Display((i mod 16) * 2 + x, (i \ 16) * 2 + y)
 next

end sub


sub Tileset.ReadFromROM(index as Integer)

 dim start as UInteger
 dim temp as UByte
 
 select case index
  case 1, 16: sprite_sheet = 1
  case 2 to 10: sprite_sheet = index
  case 11, 12: sprite_sheet = 9
  case 13 to 15: sprite_sheet = index - 2
 end select
 
 start = &hA1000 + (index - 1) * &h100
 for i as Integer = 1 to &h80
  tiles(i).sprite_sheet = sprite_sheet
  temp = ByteAt(start + (i - 1) * 2)
  tiles(i).layer_1 = iif(temp and 1, true, false)
  tiles(i).layer_2 = iif(temp and 2, true, false)
  tiles(i).bridge_layer = iif(temp and 4, true, false)
  tiles(i).save_point = iif(temp and 8, true, false)
  tiles(i).closed_door = iif(temp and &h10, true, false)
  tiles(i).mystery_bit_15 = iif(temp and &h20, true, false)
  tiles(i).mystery_bit_16 = iif(temp and &h40, true, false)
  tiles(i).mystery_bit_17 = iif(temp and &h80, true, false)
  temp = ByteAt(start + (i - 1) * 2 + 1)
  tiles(i).damage_floor = iif(temp and 1, true, false)
  tiles(i).mystery_bit_21 = iif(temp and 2, true, false)
  tiles(i).walk_behind = iif(temp and 4, true, false)
  tiles(i).bottom_half = iif(temp and 8, true, false)
  tiles(i).warp = iif(temp and &h10, true, false)
  tiles(i).talkover = iif(temp and &h20, true, false)
  tiles(i).encounters = iif(temp and &h40, true, false)
  tiles(i).triggerable = iif(temp and &h80, true, false)
 next

 start = &hA2000 + &h400 * (index - 1)
 for i as Integer = 0 to &h7F
  for j as Integer = 0 to 3
   temp = ByteAt(start + i * 2 + j * &h100 + 1)
   tiles(i + 1).sprite(j + 1).sprite_index = (temp mod 4) * &h100
   tiles(i + 1).sprite(j + 1).palette_index = (temp \ 4) mod 8
   tiles(i + 1).sprite(j + 1).front = iif(temp and &h20, true, false)
   tiles(i + 1).sprite(j + 1).hflip = iif(temp and &h40, false, true)
   tiles(i + 1).sprite(j + 1).vflip = iif(temp and &h80, true, false)
   temp = ByteAt(start + i * 2 + j * &h100)
   tiles(i + 1).sprite(j + 1).sprite_index += temp
   if tiles(i + 1).sprite(j + 1).sprite_index >= &h120 and tiles(i + 1).sprite(j + 1).sprite_index <= &h12F then
    tiles(i + 1).sprite(j + 1).minor_index = temp mod 4
    tiles(i + 1).sprite(j + 1).major_index = (temp \ 4) mod 4
    tiles(i + 1).sprite(j + 1).mystery_bit = iif(temp and &h10, true, false)
    tiles(i + 1).sprite(j + 1).animated = iif(temp and &h20, true, false)
    tiles(i + 1).sprite(j + 1).tt1 = iif(temp and &h40, true, false)
    tiles(i + 1).sprite(j + 1).tt2 = iif(temp and &h80, true, false)
   end if
   tiles(i + 1).sprite(j + 1).graphic = ImageCreate(8, 8)
  next
  tiles(i + 1).graphic = ImageCreate(16, 16)
  tiles(i + 1).frame2 = ImageCreate(16, 16)
  tiles(i + 1).frame3 = ImageCreate(16, 16)
  tiles(i + 1).frame4 = ImageCreate(16, 16)
 next
 
end sub


sub Tileset.SetGraphics(current_palette as UByte = 0)

 for i as Integer = 1 to &h80
  tiles(i).SetGraphic(current_palette)
 next

end sub


sub Tileset.WriteToROM(index as Integer)

 dim start as UInteger
 dim temp as UByte
 
 start = &hA1000 + (index - 1) * &h100
 for i as Integer = 1 to &h80
  temp = 0
  if tiles(i).layer_1 then temp += 1
  if tiles(i).layer_2 then temp += 2
  if tiles(i).bridge_layer then temp += 4
  if tiles(i).save_point then temp += 8
  if tiles(i).closed_door then temp += &h10
  if tiles(i).mystery_bit_15 then temp += &h20
  if tiles(i).mystery_bit_16 then temp += &h40
  if tiles(i).mystery_bit_17 then temp += &h80
  WriteByte(start + (i - 1) * 2, temp)
  temp = 0
  if tiles(i).damage_floor then temp += 1
  if tiles(i).mystery_bit_21 then temp += 2
  if tiles(i).walk_behind then temp += 4
  if tiles(i).bottom_half then temp += 8
  if tiles(i).warp then temp += &h10
  if tiles(i).talkover then temp += &h20
  if tiles(i).encounters then temp += &h40
  if tiles(i).triggerable then temp += &h80
  WriteByte(start + (i - 1) * 2 + 1, temp)
 next

end sub
