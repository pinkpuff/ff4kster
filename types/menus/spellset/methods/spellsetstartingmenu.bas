constructor SpellSetStartingMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 main_menu = BlueMenu(x, y)
 main_menu.max_rows = 24
 action_menu = BlueMenu(x, y + 26)
 action_menu.AddOption(FF4Text("Add"))
 action_menu.AddOption(FF4Text("Edit"))
 action_menu.AddOption(FF4Text("Delete"))
 action_menu.AddOption(FF4Text("Clear"))
 spell_menu = BlueMenu(x, action_menu.y)
 for i as Integer = 1 to total_player_spells + 1
  spell_menu.AddOption(spells(i - 1).name)
 next
 spell_menu.max_rows = 1

end constructor


sub SpellSetStartingMenu.Display()

 main_menu.ClearAll()
 for i as Integer = 1 to s->starting_spells.Length()
  main_menu.AddOption(spells(asc(s->starting_spells.ItemAt(i))).name)
 next
 
 if main_menu.options.Length() = 0 then
  BlueBox(main_menu.x, main_menu.y, 6, 24)
  for i as Integer = 1 to 24
   WriteText(FF4Text(space(6)), x + 1, y + i)
  next
 else
  main_menu.Display()
 end if

end sub


sub SpellSetStartingMenu.SetTo(index as UByte)

 s = spellsets.PointerAt(index)

end sub


sub SpellSetStartingMenu.UserSelect()

 action_menu.cancelled = false
 
 do until action_menu.cancelled
 
  action_menu.UserSelect()
  
  if not action_menu.cancelled then
  
   select case action_menu.selected
   
    case 1 'Add
     spell_menu.UserSelect()
     if not spell_menu.cancelled and spell_menu.selected > 1 and RoomForStartingSpells() and s->starting_spells.Length() < 24 then
      s->starting_spells.Append(chr(spell_menu.selected - 1))
     end if
    
    case 2 'Edit
     main_menu.cancelled = false
     do until main_menu.cancelled or main_menu.options.Length() = 0
      if main_menu.selected > main_menu.options.Length() then main_menu.selected = main_menu.options.Length()
      main_menu.UserSelect()
      if not main_menu.cancelled then
       dim old_y as UByte
       dim old_max_rows as UByte
       old_y = spell_menu.y
       old_max_rows = spell_menu.max_rows
       spell_menu.y = main_menu.selected - 1
       spell_menu.max_rows = 1
       spell_menu.ChangeSelected(asc(s->starting_spells.ItemAt(main_menu.selected)) + 1)
       spell_menu.UserSelect()
       if not spell_menu.cancelled then
        if spell_menu.selected = 1 then
         s->starting_spells.Remove(main_menu.selected)
        else
         s->starting_spells.Assign(main_menu.selected, chr(spell_menu.selected - 1))
        end if
       end if
       spell_menu.y = old_y
       spell_menu.max_rows = old_max_rows
      end if
      Display()
     loop
    
    case 3 'Delete
     main_menu.cancelled = false
     do until main_menu.cancelled or main_menu.options.Length() = 0
      if main_menu.selected > main_menu.options.Length() then main_menu.selected = main_menu.options.Length()
      main_menu.UserSelect()
      if not main_menu.cancelled then
       s->starting_spells.Remove(main_menu.selected)
       main_menu.Remove()
      end if
     loop
    
    case 4 'Clear
     s->starting_spells.Destroy()
   
   end select
   
   Display()
   
  end if
 
 loop

end sub
