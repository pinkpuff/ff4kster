sub EditTilesets()

 dim select_tileset as BlueMenu
 dim edit_tile as BlueMenu
 dim select_tile as GridMenu
 dim pal as BlueNumberInput
 dim current_palette as UByte = 0
 dim done as Boolean
 dim key as String
 dim keycode as UInteger
 dim current_tile as UByte
 
 for i as Integer = 1 to 16
  select_tileset.AddOption(tileset_names.ItemAt(i))
 next
 
 edit_tile = BlueMenu(0, 21)
 'edit_tile.AddOption(FF4Text("Dummy"))

 pal = BlueNumberInput(17, 18)
 pal.min_value = 0
 pal.max_value = 31
 
 select_tile.x = select_tileset.options.Width() + 2
 for i as Integer = 0 to 7
  for j as Integer = 0 to 15
   select_tile.options.Assign(j + 1, i + 1, hex(i) + hex(j))
  next
 next

 do until select_tileset.cancelled

  done = false
  do
   BlueBox(0, 18, 19, 1)
   WriteText(FF4Text("Display Palette: " + Pad(str(current_palette), 2, true)), 1, 19)
   tilesets(select_tileset.selected).SetGraphics(current_palette)
   select_tile.tileset_index = select_tileset.selected - 1
   select_tile.Display()
   select_tileset.Display()
   select_tileset.ShowCursor()
   do
    key = inkey
    keycode = asc(right(key, 1))
    if len(key) > 1 then keycode = keycode * &h100 + 255
    select_tile.Animate()
   loop while key = ""
   if keycode = TAB_KEY then
    pal.starting_number = current_palette
    pal.number = pal.starting_number
    do
     tilesets(select_tileset.selected).SetGraphics(pal.number)
     select_tile.Display()
    loop until pal.UserInput()
    current_palette = pal.number
   else
    done = select_tileset.ProcessKey(keycode)
   end if
  loop until done
  
  if not select_tileset.cancelled then

   select_tile.active = true
   done = false
   do
    current_tile = (select_tile.cursor_y) * 16 + select_tile.cursor_x + 1
    edit_tile.ChangeOption(1, FF4Text("Layer 1:      " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).layer_1)), 15)
    edit_tile.ChangeOption(2, FF4Text("Layer 2:      " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).layer_2)), 15)
    edit_tile.ChangeOption(3, FF4Text("Bridge Layer: " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).bridge_layer)), 15)
    edit_tile.ChangeOption(4, FF4Text("Save Point:   " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).save_point)), 15)
    edit_tile.ChangeOption(5, FF4Text("Closed Door:  " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).closed_door)), 15)
    edit_tile.ChangeOption(6, FF4Text("Byte 1 Bit 5: " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_15)), 15)
    edit_tile.ChangeOption(7, FF4Text("Byte 1 Bit 6: " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_16)), 15)
    edit_tile.ChangeOption(8, FF4Text("Byte 1 Bit 7: " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_17)), 15)
    edit_tile.ChangeOption(9, FF4Text("Damage Floor: " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).damage_floor)), 15)
    edit_tile.ChangeOption(10, FF4Text("Byte 2 Bit 1: " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_21)), 15)
    edit_tile.ChangeOption(11, FF4Text("Walk Behind:  " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).walk_behind)), 15)
    edit_tile.ChangeOption(12, FF4Text("Bottom Half:  " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).bottom_half)), 15)
    edit_tile.ChangeOption(13, FF4Text("Warp:         " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).warp)), 15)
    edit_tile.ChangeOption(14, FF4Text("Talk Over:    " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).talkover)), 15)
    edit_tile.ChangeOption(15, FF4Text("Encounters:   " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).encounters)), 15)
    edit_tile.ChangeOption(16, FF4Text("Triggerable:  " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).triggerable)), 15)
    edit_tile.Display()
    select_tile.Display()
    do
     key = inkey
     keycode = asc(right(key, 1))
     if len(key) > 1 then keycode = keycode * &h100 + 255
     select_tile.Animate()
    loop while key = ""
    if keycode = ENTER_KEY then
     do
      edit_tile.UserSelect()
      if not edit_tile.cancelled then
       select case edit_tile.selected
        case 1: tilesets(select_tileset.selected).tiles(current_tile).layer_1 = not tilesets(select_tileset.selected).tiles(current_tile).layer_1
        case 2: tilesets(select_tileset.selected).tiles(current_tile).layer_2 = not tilesets(select_tileset.selected).tiles(current_tile).layer_2
        case 3: tilesets(select_tileset.selected).tiles(current_tile).bridge_layer = not tilesets(select_tileset.selected).tiles(current_tile).bridge_layer
        case 4: tilesets(select_tileset.selected).tiles(current_tile).save_point = not tilesets(select_tileset.selected).tiles(current_tile).save_point
        case 5: tilesets(select_tileset.selected).tiles(current_tile).closed_door = not tilesets(select_tileset.selected).tiles(current_tile).closed_door
        case 6: tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_15 = not tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_15
        case 7: tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_16 = not tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_16
        case 8: tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_17 = not tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_17
        case 9: tilesets(select_tileset.selected).tiles(current_tile).damage_floor = not tilesets(select_tileset.selected).tiles(current_tile).damage_floor
        case 10: tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_21 = not tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_21
        case 11: tilesets(select_tileset.selected).tiles(current_tile).walk_behind = not tilesets(select_tileset.selected).tiles(current_tile).walk_behind
        case 12: tilesets(select_tileset.selected).tiles(current_tile).bottom_half = not tilesets(select_tileset.selected).tiles(current_tile).bottom_half
        case 13: tilesets(select_tileset.selected).tiles(current_tile).warp = not tilesets(select_tileset.selected).tiles(current_tile).warp
        case 14: tilesets(select_tileset.selected).tiles(current_tile).talkover = not tilesets(select_tileset.selected).tiles(current_tile).talkover
        case 15: tilesets(select_tileset.selected).tiles(current_tile).encounters = not tilesets(select_tileset.selected).tiles(current_tile).encounters
        case 16: tilesets(select_tileset.selected).tiles(current_tile).triggerable = not tilesets(select_tileset.selected).tiles(current_tile).triggerable
       end select
       edit_tile.ChangeOption(1, FF4Text("Layer 1:      " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).layer_1)), 15)
       edit_tile.ChangeOption(2, FF4Text("Layer 2:      " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).layer_2)), 15)
       edit_tile.ChangeOption(3, FF4Text("Bridge Layer: " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).bridge_layer)), 15)
       edit_tile.ChangeOption(4, FF4Text("Save Point:   " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).save_point)), 15)
       edit_tile.ChangeOption(5, FF4Text("Closed Door:  " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).closed_door)), 15)
       edit_tile.ChangeOption(6, FF4Text("Byte 1 Bit 5: " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_15)), 15)
       edit_tile.ChangeOption(7, FF4Text("Byte 1 Bit 6: " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_16)), 15)
       edit_tile.ChangeOption(8, FF4Text("Byte 1 Bit 7: " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_17)), 15)
       edit_tile.ChangeOption(9, FF4Text("Damage Floor: " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).damage_floor)), 15)
       edit_tile.ChangeOption(10, FF4Text("Byte 2 Bit 1: " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).mystery_bit_21)), 15)
       edit_tile.ChangeOption(11, FF4Text("Walk Behind:  " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).walk_behind)), 15)
       edit_tile.ChangeOption(12, FF4Text("Bottom Half:  " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).bottom_half)), 15)
       edit_tile.ChangeOption(13, FF4Text("Warp:         " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).warp)), 15)
       edit_tile.ChangeOption(14, FF4Text("Talk Over:    " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).talkover)), 15)
       edit_tile.ChangeOption(15, FF4Text("Encounters:   " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).encounters)), 15)
       edit_tile.ChangeOption(16, FF4Text("Triggerable:  " + YesNo(tilesets(select_tileset.selected).tiles(current_tile).triggerable)), 15)
      end if
     loop until edit_tile.cancelled
     edit_tile.Display()
     tilesets(select_tileset.selected).SetGraphics(pal.number)
    else
     done = select_tile.ProcessKey(keycode)
    end if
   loop until done
   select_tile.active = false
   edit_tile.Hide()
   
  end if
  
 loop

end sub
