constructor SpellVisualMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 main_menu = BlueMenu(x, y)
 
 main_menu.AddOption("Sound:     ")
 main_menu.AddOption("Palette:   ")
 main_menu.AddOption("Sprites:   ")
 main_menu.AddOption("Pointer 1: ")
 main_menu.AddOption("Pointer 2: ")

end constructor


sub SpellVisualMenu.Display()

 'main_menu.Hide()
 
 main_menu.ChangeOption(1, FF4Text("Sound:    ") + Pad(sound_effects.ItemAt(sound), sound_effects.Width(),, FF4Text(" ")))
 main_menu.ChangeOption(2, FF4Text("Palette:  ") + Pad(palette_names.ItemAt(colors), palette_names.Width(),, FF4Text(" ")))
 main_menu.ChangeOption(3, FF4Text("Sprites:  " + Pad(str(sprites), 3)))
 main_menu.ChangeOption(4, FF4Text("Sequence: ") + Pad(sequence_names.ItemAt(visual1 + 1), sequence_names.Width(),, FF4Text(" ")))
 main_menu.ChangeOption(5, FF4Text("Effect:   ") + Pad(effect_names.ItemAt(visual2 + 1), effect_names.Width(),, FF4Text(" ")))
 
 main_menu.Display()
 
end sub


sub SpellVisualMenu.SetTo(index as UByte)

 sound = spells(index).sound + 1
 colors = spells(index).colors + 1
 sprites = spells(index).sprites
 visual1 = spells(index).visual1
 visual2 = spells(index).visual2

end sub


sub SpellVisualMenu.UserSelect()
 
 dim sequences_menu as BlueMenu
 dim effects_menu as BlueMenu
 
 sequences_menu = BlueMenu(x + 10, y + 3)
 sequences_menu.max_rows = 1
 for i as Integer = 1 to total_sequences
  sequences_menu.AddOption(sequence_names.ItemAt(i))
 next

 effects_menu = BlueMenu(x + 10, y + 4)
 effects_menu.max_rows = 1
 for i as Integer = 1 to total_effects
  effects_menu.AddOption(effect_names.ItemAt(i))
 next
 
 main_menu.cancelled = false
 
 do until main_menu.cancelled
 
  main_menu.UserSelect()
  
  if not main_menu.cancelled then
  
   select case main_menu.selected
   
    case 1 'Sound
     sound = ListItem(x + 10, y, sound_effects, sound)
    
    case 2 'Palette
     colors = ListItem(x + 10, y + 1, palette_names, colors)
    
    case 3 'Sprites
     dim n as BlueNumberInput
     n = BlueNumberInput(x + 10, y + 2)
     n.starting_number = sprites
     n.UserSelect()
     sprites = n.number
    
    case 4 'Sequence
     sequences_menu.ChangeSelected(visual1 + 1)
     sequences_menu.UserSelect()
     if not sequences_menu.cancelled then visual1 = sequences_menu.selected - 1
    
    case 5 'Effect
     effects_menu.ChangeSelected(visual2 + 1)
     effects_menu.UserSelect()
     if not effects_menu.cancelled then visual2 = effects_menu.selected - 1
   
   end select
   
   Display()
  
  end if
 
 loop

end sub
