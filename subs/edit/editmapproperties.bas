sub EditMapProperties()

 dim temp as UInteger
 dim select_map as BlueMenu
 dim info_menu as BlueMenu
 dim display_menu as BlueMenu
 dim background_menu as BlueMenu
 dim edit_menu as BlueMenu
 dim name_menu as BlueMenu
 dim song_menu as BlueMenu
 dim tileset_menu as BlueMenu
 dim battlebg_menu as BlueMenu
 dim overworld_maps as BlueMenu
 dim underground_maps as BlueMenu
 
 select_map.max_rows = 8
 for i as Integer = 1 to total_maps
  select_map.AddOption(Pad(map_names.ItemAt(i), screen_width - 2,, FF4Text(" ")))
 next
 
 info_menu.y = select_map.WindowHeight() + 2
 display_menu.y = info_menu.y + 11
 background_menu.y = display_menu.y + 9
 
 edit_menu.AddOption(FF4Text("Edit information"))
 edit_menu.AddOption(FF4Text("Edit graphics"))
 edit_menu.AddOption(FF4Text("Edit background"))
 edit_menu.y = info_menu.y
 edit_menu.x = screen_width - edit_menu.options.Width() - 2
 
 name_menu.max_rows = 1
 name_menu.x = info_menu.x + 16
 name_menu.y = info_menu.y
 for i as Integer = 1 to 129 'total_map_labels
  name_menu.AddOption(map_labels.ItemAt(i))
 next
 
 song_menu.max_rows = 1
 for i as Integer = 1 to total_songs
  song_menu.AddOption(song_names.ItemAt(i))
 next
 
 tileset_menu.max_rows = 1
 tileset_menu.x = display_menu.x + 15
 tileset_menu.y = display_menu.y + 1
 for i as Integer = 1 to total_tilesets
  tileset_menu.AddOption(tileset_names.ItemAt(i))
 next
 
 battlebg_menu.max_rows = 1
 battlebg_menu.x = display_menu.x + 15
 battlebg_menu.y = display_menu.y
 for i as Integer = 1 to total_battlebgs
  battlebg_menu.AddOption(battlebg_names.ItemAt(i))
 next
 
 overworld_maps.max_rows = 1
 overworld_maps.x = background_menu.x + 19
 overworld_maps.y = background_menu.y
 for i as Integer = 1 to 256
  overworld_maps.AddOption(map_names.ItemAt(i))
 next
 
 underground_maps.max_rows = 1
 underground_maps.x = background_menu.x + 19
 underground_maps.y = background_menu.y
 for i as Integer = 1 to 256
  underground_maps.AddOption(map_names.ItemAt(i + &h100))
 next
 
 do
 
  do
   info_menu.ChangeOption(1, FF4Text("Name:           ") + Pad(map_labels.ItemAt(maps(select_map.selected).name_index + 1), map_labels.Width(),, FF4Text(" ")), 15)
   info_menu.ChangeOption(2, FF4Text("Grid Index:     " + Pad(str(maps(select_map.selected).grid_index), 3)), 15)
   info_menu.ChangeOption(3, FF4Text("Underground:    " + YesNo(maps(select_map.selected).underground)), 15)
   info_menu.ChangeOption(4, FF4Text("Music:          ") + Pad(song_names.ItemAt(maps(select_map.selected).music + 1), song_names.Width()), 15)
   info_menu.ChangeOption(5, FF4Text("Warpable:       " + YesNo(maps(select_map.selected).warpable)), 15)
   info_menu.ChangeOption(6, FF4Text("Exitable:       " + YesNo(maps(select_map.selected).exitable)), 15)
   info_menu.ChangeOption(7, FF4Text("Mystery flag:   " + YesNo(maps(select_map.selected).mystery_bit)), 15)
   info_menu.ChangeOption(8, FF4Text("Magnetic:       " + YesNo(maps(select_map.selected).magnetic)), 15)
   info_menu.ChangeOption(9, FF4Text("Encounter rate: " + Pad(str(maps(select_map.selected).encounter_rate), 3)), 15)
   display_menu.ChangeOption(1, FF4Text("Battle BG:     ") + Pad(battlebg_names.ItemAt(maps(select_map.selected).battle_background + 1), battlebg_names.Width()), 15)
   display_menu.ChangeOption(2, FF4Text("Tileset:       ") + Pad(tileset_names.ItemAt(maps(select_map.selected).tileset_index + 1), tileset_names.Width()), 15)
   display_menu.ChangeOption(3, FF4Text("Border tile:   " + Pad(str(maps(select_map.selected).border_tile), 3)), 15)
   display_menu.ChangeOption(4, FF4Text("Tile palette:  " + Pad(str(maps(select_map.selected).map_palette), 3)), 15)
   display_menu.ChangeOption(5, FF4Text("NPC palette 1: " + Pad(str(maps(select_map.selected).npc_palette_12), 3)), 15)
   display_menu.ChangeOption(6, FF4Text("NPC palette 2: " + Pad(str(maps(select_map.selected).npc_palette_34), 3)), 15)
   display_menu.ChangeOption(7, FF4Text("NPC index:     " + Pad(str(maps(select_map.selected).npc_placement_index), 3)), 15)
   temp = maps(select_map.selected).background + 1
   if select_map.selected > &h100 then temp += &h100
   background_menu.ChangeOption(1, FF4Text("Background:        ") + Pad(map_names.ItemAt(temp), map_names.Width()), 15)
   background_menu.ChangeOption(2, FF4Text("Vertical scroll:   " + YesNo(maps(select_map.selected).bg_scroll_vertical)), 15)
   background_menu.ChangeOption(3, FF4Text("Horizontal scroll: " + YesNo(maps(select_map.selected).bg_scroll_horizontal)), 15)
   background_menu.ChangeOption(4, FF4Text("Mystery flag:      " + YesNo(maps(select_map.selected).mystery_bit2)), 15)
   background_menu.ChangeOption(5, FF4Text("Move direction:    " + Pad(str(maps(select_map.selected).bg_move_direction), 3)), 15)
   background_menu.ChangeOption(6, FF4Text("Move speed:        " + Pad(str(maps(select_map.selected).bg_move_speed), 3)), 15)
   background_menu.ChangeOption(7, FF4Text("Translucent:       " + YesNo(maps(select_map.selected).bg_translucent)), 15)
   info_menu.Display()
   display_menu.Display()
   'SetPalette(&hA6000, 3) 'maps(select_map.selected).map_palette)
   'ShowPalette(display_menu.x + 15, display_menu.y + 4)
   background_menu.Display()
  loop until select_map.UserInput()
  
  if not select_map.cancelled then
  
   edit_menu.UserSelect()
   
   if not edit_menu.cancelled then
   
    select case edit_menu.selected
    
     case 1 'Edit information
     
      do
     
       info_menu.UserSelect()
     
       if not info_menu.cancelled then
     
        select case info_menu.selected
     
         case 1 'Name
          name_menu.ChangeSelected(maps(select_map.selected).name_index + 1)
          name_menu.UserSelect()
          if not name_menu.cancelled then 
           maps(select_map.selected).name_index = name_menu.selected - 1
           dim name_input as BlueTextInput
           name_input.x = info_menu.x + 16
           name_input.y = info_menu.y
           name_input.starting_text = map_labels.ItemAt(maps(select_map.selected).name_index + 1)
           name_input.text_width = map_labels.Width()
           name_input.UserType()
           map_labels.Assign(maps(select_map.selected).name_index + 1, name_input.text)
           info_menu.ChangeOption(1, FF4Text("Name:           ") + Pad(map_labels.ItemAt(maps(select_map.selected).name_index + 1), map_labels.Width(),, FF4Text(" ")), 15)
          end if
          
         case 2 'Grid Index
          dim index_input as BlueNumberInput
          index_input.x = info_menu.x + 16
          index_input.y = info_menu.y + 1
          index_input.starting_number = maps(select_map.selected).grid_index
          index_input.UserSelect()
          maps(select_map.selected).grid_index = index_input.number
          info_menu.ChangeOption(2, FF4Text("Index:          " + Pad(str(maps(select_map.selected).grid_index), 3)), 15)
          
         case 3 'Underground
          maps(select_map.selected).underground = not maps(select_map.selected).underground
          info_menu.ChangeOption(3, FF4Text("Underground:    " + YesNo(maps(select_map.selected).underground)), 15)
          
         case 4 'Music
          song_menu.x = info_menu.x + 16
          song_menu.y = info_menu.y + 3
          song_menu.ChangeSelected(maps(select_map.selected).music + 1)
          song_menu.UserSelect()
          if not song_menu.cancelled then maps(select_map.selected).music = song_menu.selected - 1
          info_menu.ChangeOption(4, FF4Text("Music:          ") + song_names.ItemAt(maps(select_map.selected).music + 1), 15)
          
         case 5 'Warpable
          maps(select_map.selected).warpable = not maps(select_map.selected).warpable
          info_menu.ChangeOption(5, FF4Text("Warpable:       " + YesNo(maps(select_map.selected).warpable)), 15)
         
         case 6 'Warpable
          maps(select_map.selected).exitable = not maps(select_map.selected).exitable
          info_menu.ChangeOption(6, FF4Text("Exitable:       " + YesNo(maps(select_map.selected).exitable)), 15)
          
         case 7 'Mystery flag
          maps(select_map.selected).mystery_bit = not maps(select_map.selected).mystery_bit
          info_menu.ChangeOption(7, FF4Text("Mystery flag:   " + YesNo(maps(select_map.selected).mystery_bit)), 15)
         
         case 8 'Magnetic
          maps(select_map.selected).magnetic = not maps(select_map.selected).magnetic
          info_menu.ChangeOption(8, FF4Text("Magnetic:       " + YesNo(maps(select_map.selected).magnetic)), 15)
         
         case 9 'Encounter rate
          dim rate_input as BlueNumberInput
          rate_input.x = info_menu.x + 16
          rate_input.y = info_menu.y + 8
          rate_input.starting_number = maps(select_map.selected).encounter_rate
          rate_input.UserSelect()
          maps(select_map.selected).encounter_rate = rate_input.number
          info_menu.ChangeOption(9, FF4Text("Encounter rate: " + Pad(str(maps(select_map.selected).encounter_rate), 3)), 15)
     
        end select
        
        info_menu.Display()
     
       end if
     
      loop until info_menu.cancelled
      
     case 2 'Edit graphics
     
      do 
      
       display_menu.UserSelect()
       
       if not display_menu.cancelled then
       
        select case display_menu.selected
        
         case 1 'Battle BG
          battlebg_menu.ChangeSelected(maps(select_map.selected).battle_background + 1)
          battlebg_menu.UserSelect()
          if not battlebg_menu.cancelled then maps(select_map.selected).battle_background = battlebg_menu.selected - 1
          display_menu.ChangeOption(1, FF4Text("Battle BG:     ") + Pad(battlebg_names.ItemAt(maps(select_map.selected).battle_background + 1), battlebg_names.Width()), 15)
          
         case 2 'Tileset
          tileset_menu.ChangeSelected(maps(select_map.selected).tileset_index + 1)
          tileset_menu.UserSelect()
          if not tileset_menu.cancelled then maps(select_map.selected).tileset_index = tileset_menu.selected - 1
          display_menu.ChangeOption(2, FF4Text("Tileset:       ") + Pad(tileset_names.ItemAt(maps(select_map.selected).tileset_index + 1), tileset_names.Width()), 15)
        
         case 3 'Border Tile
          dim bordertile_input as BlueNumberInput
          bordertile_input.x = display_menu.x + 15
          bordertile_input.y = display_menu.y + 2
          bordertile_input.max_value = 127
          bordertile_input.starting_number = maps(select_map.selected).border_tile
          bordertile_input.UserSelect()
          maps(select_map.selected).border_tile = bordertile_input.number
          display_menu.ChangeOption(3, FF4Text("Border tile:   " + Pad(str(maps(select_map.selected).border_tile), 3)), 15)
         
         case 4 'Tile Palette
          dim palette_input as BlueNumberInput
          palette_input.x = display_menu.x + 15
          palette_input.y = display_menu.y + 3
          palette_input.starting_number = maps(select_map.selected).map_palette
          palette_input.UserSelect()
          maps(select_map.selected).map_palette = palette_input.number
          display_menu.ChangeOption(4, FF4Text("Tile palette:  " + Pad(str(maps(select_map.selected).map_palette), 3)), 15)
         
         case 5 'NPC Palette 1
          dim npc1_input as BlueNumberInput
          npc1_input.x = display_menu.x + 15
          npc1_input.y = display_menu.y + 4
          npc1_input.max_value = 15
          npc1_input.starting_number = maps(select_map.selected).npc_palette_12
          npc1_input.UserSelect()
          maps(select_map.selected).npc_palette_12 = npc1_input.number
          display_menu.ChangeOption(5, FF4Text("NPC palette 1: " + Pad(str(maps(select_map.selected).npc_palette_12), 3)), 15)
         
         case 6 'NPC Palette 2
          dim npc2_input as BlueNumberInput
          npc2_input.x = display_menu.x + 15
          npc2_input.y = display_menu.y + 5
          npc2_input.max_value = 15
          npc2_input.starting_number = maps(select_map.selected).npc_palette_34
          npc2_input.UserSelect()
          maps(select_map.selected).npc_palette_34 = npc2_input.number
          display_menu.ChangeOption(6, FF4Text("NPC palette 2: " + Pad(str(maps(select_map.selected).npc_palette_34), 3)), 15)
         
         case 7 'NPC Index
          dim npcindex_input as BlueNumberInput
          npcindex_input.x = display_menu.x + 15
          npcindex_input.y = display_menu.y + 6
          npcindex_input.starting_number = maps(select_map.selected).npc_placement_index
          npcindex_input.UserSelect()
          maps(select_map.selected).npc_placement_index = npcindex_input.number
          display_menu.ChangeOption(7, FF4Text("NPC index:     " + Pad(str(maps(select_map.selected).npc_placement_index), 3)), 15)
        
        end select
        
        display_menu.Display()
       
       end if
      
      loop until display_menu.cancelled
      
     case 3 'Edit background
     
      do
       
       background_menu.UserSelect()
       
       if not background_menu.cancelled then
       
        select case background_menu.selected
       
         case 1 'Background
          if select_map.selected > &h100 then
           underground_maps.ChangeSelected(maps(select_map.selected).background + 1)
           underground_maps.UserSelect()
           if not underground_maps.cancelled then maps(select_map.selected).background = underground_maps.selected - 1
          else
           overworld_maps.ChangeSelected(maps(select_map.selected).background + 1)
           overworld_maps.UserSelect()
           if not overworld_maps.cancelled then maps(select_map.selected).background = overworld_maps.selected - 1
          end if
          temp = maps(select_map.selected).background + 1
          if select_map.selected > &h100 then temp += &h100
          background_menu.ChangeOption(1, FF4Text("Background:        ") + Pad(map_names.ItemAt(temp), map_names.Width()), 15)
         
         case 2 'Vertical Scroll
          maps(select_map.selected).bg_scroll_vertical = not maps(select_map.selected).bg_scroll_vertical
          background_menu.ChangeOption(2, FF4Text("Vertical scroll:   " + YesNo(maps(select_map.selected).bg_scroll_vertical)), 15)
         
         case 3 'Horizontal Scroll
          maps(select_map.selected).bg_scroll_horizontal = not maps(select_map.selected).bg_scroll_horizontal
          background_menu.ChangeOption(3, FF4Text("Horizontal scroll: " + YesNo(maps(select_map.selected).bg_scroll_horizontal)), 15)
          
         case 4 'Mystery flag
          maps(select_map.selected).mystery_bit2 = not maps(select_map.selected).mystery_bit2
          background_menu.ChangeOption(4, FF4Text("Mystery flag:      " + YesNo(maps(select_map.selected).mystery_bit2)), 15)
         
         case 5 'Move direction
          dim movedir_input as BlueNumberInput
          movedir_input.x = background_menu.x + 19
          movedir_input.y = background_menu.y + 4
          movedir_input.max_value = 3
          movedir_input.starting_number = maps(select_map.selected).bg_move_direction
          movedir_input.UserSelect()
          maps(select_map.selected).bg_move_direction = movedir_input.number
          background_menu.ChangeOption(5, FF4Text("Move direction:    " + Pad(str(maps(select_map.selected).bg_move_direction), 3)), 15)
         
         case 6 'Move speed
          dim movespeed_input as BlueNumberInput
          movespeed_input.x = background_menu.x + 19
          movespeed_input.y = background_menu.y + 5
          movespeed_input.max_value = 3
          movespeed_input.starting_number = maps(select_map.selected).bg_move_speed
          movespeed_input.UserSelect()
          maps(select_map.selected).bg_move_speed = movespeed_input.number
          background_menu.ChangeOption(6, FF4Text("Move speed:        " + Pad(str(maps(select_map.selected).bg_move_speed), 3)), 15)
         
         case 7 'Translucent
          maps(select_map.selected).bg_translucent = not maps(select_map.selected).bg_translucent
          background_menu.ChangeOption(7, FF4Text("Translucent:       " + YesNo(maps(select_map.selected).bg_translucent)), 15)
         
        end select
        
        background_menu.Display()
       
       end if
       
      loop until background_menu.cancelled
    
    end select
   
   end if
  
  end if
  
 loop until select_map.cancelled

end sub
