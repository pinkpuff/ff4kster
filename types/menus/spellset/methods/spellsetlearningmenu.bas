constructor SpellSetLearningMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 main_menu = BlueMenu(x, y)
 main_menu.max_rows = 24
 action_menu = BlueMenu(x, y + 26)
 action_menu.AddOption(FF4Text("Add"))
 action_menu.AddOption(FF4Text("Edit"))
 action_menu.AddOption(FF4Text("Delete"))
 action_menu.AddOption(FF4Text("Clear"))
 level_input = BlueNumberInput(x, action_menu.y)
 level_input.min_value = 2
 level_input.max_value = 99
 spell_menu = BlueMenu(x + 4, action_menu.y)
 for i as Integer = 1 to total_player_spells + 1
  spell_menu.AddOption(spells(i - 1).name)
 next
 spell_menu.max_rows = 1
 
end constructor


sub SpellSetLearningMenu.Display()

 main_menu.ClearAll()
 for i as Integer = 1 to s->learning_spells.Length()
  main_menu.AddOption(FF4Text(Pad(str(asc(s->learning_levels.ItemAt(i))), 2, true, "0") + ": ") + spells(asc(s->learning_spells.ItemAt(i))).name)
 next
 
 if main_menu.options.Length() = 0 then
  BlueBox(main_menu.x, main_menu.y, 10, 24)
  for i as Integer = 1 to 24
   WriteText(FF4Text(space(10)), x + 1, y + i)
  next
 else
  main_menu.Display()
 end if

end sub


sub SpellSetLearningMenu.SetTo(index as UByte)

 s = spellsets.PointerAt(index)

end sub


sub SpellSetLearningMenu.UserSelect()

 action_menu.cancelled = false
 
 do until action_menu.cancelled
 
  action_menu.UserSelect()
  
  if not action_menu.cancelled then
  
   select case action_menu.selected
   
    case 1 'Add
     if s->learning_levels.Length() > 0 then
      level_input.starting_number = asc(s->learning_levels.ItemAt(s->learning_levels.Length()))
     else
      level_input.starting_number = level_input.min_value
     end if
     level_input.UserSelect()
     level_input.Display()
     spell_menu.UserSelect()
     'put (level_input.x * 8, level_input.y * 8), ImageCreate(4 * 8, 3 * 8), pset
     level_input.Hide()
     if not spell_menu.cancelled and spell_menu.selected > 1 and RoomForLearningSpells() and s->learning_spells.Length() < 24 then
      s->learning_levels.Append(chr(level_input.number))
      s->learning_spells.Append(chr(spell_menu.selected - 1))
      s->Sort()
     end if
     
    case 2 'Edit
     main_menu.cancelled = false
     do until main_menu.cancelled or main_menu.options.Length() = 0
      if main_menu.selected > main_menu.options.Length() then main_menu.selected = main_menu.options.Length()
      main_menu.UserSelect()
      if not main_menu.cancelled then
       dim old_y as UByte
       dim old_max_rows as UByte
       old_y = level_input.y
       old_max_rows = spell_menu.max_rows
       level_input.y = main_menu.selected - 1
       spell_menu.y = level_input.y
       spell_menu.max_rows = 1
       level_input.starting_number = asc(s->learning_levels.ItemAt(main_menu.selected))
       spell_menu.ChangeSelected(asc(s->learning_spells.ItemAt(main_menu.selected)) + 1)
       level_input.UserSelect()
       level_input.Display()
       spell_menu.UserSelect()
       if not spell_menu.cancelled then
        if spell_menu.selected = 1 then
         s->learning_levels.Remove(main_menu.selected)
         s->learning_spells.Remove(main_menu.selected)
        else
         s->learning_levels.Assign(main_menu.selected, chr(level_input.number))
         s->learning_spells.Assign(main_menu.selected, chr(spell_menu.selected - 1))
         s->Sort()
        end if
       end if
       level_input.y = old_y
       spell_menu.y = old_y
       spell_menu.max_rows = old_max_rows
       Display()
      end if
     loop
     
    case 3 'Delete
     main_menu.cancelled = false
     do until main_menu.cancelled or main_menu.options.Length() = 0
      if main_menu.selected > main_menu.options.Length() then main_menu.selected = main_menu.options.Length()
      main_menu.UserSelect()
      if not main_menu.cancelled then
       s->learning_levels.Remove(main_menu.selected)
       s->learning_spells.Remove(main_menu.selected)
       main_menu.Remove()
      end if
     loop
     
    case 4 'Clear
     s->learning_levels.Destroy()
     s->learning_spells.Destroy()
   
   end select
   
   Display()
  
  end if
 
 loop

end sub
