function Map.BytesUsed() as UInteger

 return 0 ' len(RunLengthEncoding())

end function


'function Map.RunLengthEncoding() as String

 'dim tile as UByte
 'dim runlength as Integer
 'dim result as String
 
 'if not no_data then
 
  'for i as Integer = 0 to 31
   'for j as Integer = 0 to 31
    'if j = 0 and i = 0 then
     'tile = tiles(j, i)
     'runlength = 0
    'else
     'if tiles(j, i) = tile then
      'runlength += 1
     'else
      'if runlength > 0 then
       'do while runlength > &hFF
        'result += chr(tile + &h80)
        'result += chr(&hFF)
        'runlength -= &h100
       'loop
       'result += chr(tile + &h80)
       'result += chr(runlength)
      'else
       'result += chr(tile)
      'end if
      'tile = tiles(j, i)
      'runlength = 0
     'end if
    'end if
   'next
  'next
 
  'if runlength > 0 then
   'do while runlength > &hFF
    'result += chr(tile + &h80)
    'result += chr(&hFF)
    'runlength -= &h100
   'loop
   'result += chr(tile + &h80)
   'result += chr(runlength)
  'else
   'result += chr(tile)
  'end if
 
 'end if
 
 'return result

'end function


sub Map.ReadFromROM(index as UInteger)

 dim start as UInteger
 dim temp as UByte
 dim next_pointer as UInteger
 
 start = &hA9E84
 start += (index - 1) * 13
 
 temp = ByteAt(start)
 battle_background = temp mod &h10
 if (temp and &h10) then warpable = true else warpable = false
 if (temp and &h20) then exitable = true else exitable = false
 if (temp and &h40) then mystery_bit = true else mystery_bit = false
 if (temp and &h80) then magnetic = true else magnetic = false
 grid_index = ByteAt(start + 1)
 tileset_index = ByteAt(start + 2)
 npc_placement_index = ByteAt(start + 3)
 temp = ByteAt(start + 4)
 border_tile = temp mod &h80
 map_palette = ByteAt(start + 5)
 temp = ByteAt(start + 6)
 npc_palette_12 = temp mod &h10
 npc_palette_34 = temp \ &h10
 music = ByteAt(start + 7)
 background = ByteAt(start + 8)
 temp = ByteAt(start + 9)
 if temp and 1 then bg_translucent = true else bg_translucent = false
 if temp and 2 then bg_scroll_vertical = true else bg_scroll_vertical = false
 if temp and 4 then bg_scroll_horizontal = true else bg_scroll_horizontal = false
 if temp and 8 then mystery_bit2 = true else mystery_bit2 = false
 bg_move_direction = (temp \ &h10) mod 4
 bg_move_speed = temp \ &h40
 if ByteAt(start + 10) and &h80 then underground = true else underground = false
 name_index = ByteAt(start + 11)
 treasure_index = ByteAt(start + 12)
 
 encounter_rate = ByteAt(&h74542 + index - 1)
 
 'start = ByteAt(&hB8200 + (index - 1) * 2) + ByteAt(&hB8200 + (index - 1) * 2 + 1) * &h100
 'next_pointer = ByteAt(&hB8200 + index * 2) + ByteAt(&hB8200 + index * 2 + 1) * &h100

 'if index = total_maps or next_pointer = start or next_pointer < start then

  'no_data = true

 'else

  'if index >= &h100 then start += &hC0200 else start += &hB8200
  
  ''dim tilesread as Integer = 0
  ''dim x as UByte = 0
  ''dim y as UByte = 0
  ''dim runlength as Integer
  
  ''do until tilesread >= &h400
   ''temp = ByteAt(start)
   ''start += 1
   ''if temp < &h80 then
    ''runlength = 1
   ''else
    ''runlength = ByteAt(start) + 1
    ''start += 1
   ''end if
   ''for i as Integer = 1 to runlength
    ''tiles(x, y) = temp mod &h80
    ''x += 1
    ''if x >= 32 then 
     ''x -= 32
     ''y += 1
    ''end if
   ''next
   ''tilesread += runlength
  ''loop
  
 'end if
 
end sub


sub Map.WriteToROM(index as UInteger)

 dim start as UInteger
 dim temp as UByte
 dim tiledata as String
 
 start = &hA9E84
 start += (index - 1) * 13
 
 temp = battle_background
 if warpable then temp += &h10
 if exitable then temp += &h20
 if mystery_bit then temp += &h40
 if magnetic then temp += &h80
 WriteByte(start, temp)
 WriteByte(start + 1, grid_index)
 WriteByte(start + 2, tileset_index)
 WriteByte(start + 3, npc_placement_index)
 temp = border_tile
 temp += ByteAt(start + 4) and &h80
 WriteByte(start + 4, temp)
 WriteByte(start + 5, map_palette)
 temp = npc_palette_12 + npc_palette_34 * &h10
 WriteByte(start + 6, temp)
 WriteByte(start + 7, music)
 WriteByte(start + 8, background)
 temp = 0
 if bg_translucent then temp += 1
 if bg_scroll_vertical then temp += 2
 if bg_scroll_horizontal then temp += 4
 if mystery_bit2 then temp += 8
 temp += bg_move_direction * &h10
 temp += bg_move_speed * &h40
 WriteByte(start + 9, temp)
 temp = ByteAt(start + 10) mod &h80
 if underground then temp += &h80
 WriteByte(start + 10, temp)
 WriteByte(start + 11, name_index)
 WriteByte(start + 12, treasure_index)
 
 WriteByte(&h74542 + index - 1, encounter_rate)
 
 'start = ByteAt(&hB8200 + (index - 1) * 2) + ByteAt(&hB8200 + (index - 1) * 2 + 1) * &h100
 'if index >= &h100 then start += &hC0200 else start += &hB8200
 
 'dim tile as UByte
 'dim runlength as Integer
 
 'if not no_data then
 
  'tiledata = RunLengthEncoding()
  'for i as Integer = 1 to len(tiledata)
   'WriteByte(start + i - 1, asc(mid(tiledata, i, 1)))
  'next
  'start += len(tiledata)
  'if start >= &hD005F then WarningMessage(FF4Text("Map data overflow!"))
  
  ''for i as Integer = 0 to 31
   ''for j as Integer = 0 to 31
    ''if j = 0 and i = 0 then
     ''tile = tiles(j, i)
     ''runlength = 0
    ''else
     ''if tiles(j, i) = tile then
      ''runlength += 1
     ''else
      ''if runlength > 0 then
       ''do while runlength > &hFF
        ''WriteByte(start, tile + &h80)
        ''WriteByte(start + 1, &hFF)
        ''start += 2
        ''runlength -= &h100
       ''loop
       ''WriteByte(start, tile + &h80)
       ''WriteByte(start + 1, runlength)
       ''start += 2
      ''else
       ''WriteByte(start, tile)
       ''start += 1
      ''end if
      ''tile = tiles(j, i)
      ''runlength = 0
     ''end if
    ''end if
    ''if start >= &hD005F then
     ''WarningMessage(FF4Text("Map data overflow!"))
     ''exit for
    ''end if
   ''next
   ''if warning then exit for
  ''next
  ''if runlength > 0 then
   ''do while runlength > &hFF
    ''WriteByte(start, tile + &h80)
    ''WriteByte(start + 1, &hFF)
    ''start += 2
    ''runlength -= &h100
   ''loop
   ''WriteByte(start, tile + &h80)
   ''WriteByte(start + 1, runlength)
   ''start += 2
  ''else
   ''WriteByte(start, tile)
   ''start += 1
  ''end if
  
 'end if
 
 ''print index; ": "; hex(start)
 'if index < &h100 then
  'WriteByte(&hB8200 + index * 2, (start - &hB8200) mod &h100)
  'WriteByte(&hB8200 + index * 2 + 1, (start - &hB8200) \ &h100)
 'elseif index < total_maps then
  'WriteByte(&hB8200 + index * 2, (start - &hC0200) mod &h100)
  'WriteByte(&hB8200 + index * 2 + 1, (start - &hC0200) \ &h100)
 'end if

end sub
