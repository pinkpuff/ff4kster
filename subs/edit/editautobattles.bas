sub EditAutoBattles()

 dim select_autobattle as BlueMenu
 dim edit_autobattle as BlueMenu
 dim formation_index as BlueMenu
 dim select_script as BlueMenu
 dim script_menu(2) as BlueMenu
 dim edit_script as BlueMenu ptr
 dim edit_entry as BlueMenu
 dim spell_menu as BlueMenu
 dim item_menu as BlueMenu
 dim command_menu as BlueMenu
 dim temp as String
 
 for i as Integer = 1 to total_autobattles
  select_autobattle.AddOption(FF4Text("Autobattle " + str(i)))
 next
 
 edit_autobattle.y = select_autobattle.options.Length() + 2
 edit_autobattle.AddOption(FF4Text("Edit formation"))
 edit_autobattle.AddOption(FF4Text("Edit script"))
 
 formation_index.x = select_autobattle.options.Width() + 2
 formation_index.max_rows = 1
 for i as Integer = 1 to total_formations
  temp = formation_names.ItemAt(i) + FF4Text(": ")
  for j as Integer = 1 to 3
   if formations(i).monster_type(j) + 1 <= total_monsters then
    temp += FF4Text(str(formations(i).monster_qty(j)) + " ")
    temp += monsters(formations(i).monster_type(j) + 1).name
    temp += FF4Text("  ")
   else
    temp += FF4Text(space(12))
   end if
  next
  formation_index.AddOption(temp)
 next
 
 select_script.x = formation_index.x
 select_script.y = 3
 select_script.columns = 2
 
 script_menu(1).x = formation_index.x
 script_menu(1).y = 6
 
 script_menu(2).x = script_menu(1).x + 16
 script_menu(2).y = script_menu(1).y
 
 edit_entry.max_rows = 1
 edit_entry.AddOption(FF4Text("Cast a spell"))
 edit_entry.AddOption(FF4Text("Use an item"))
 edit_entry.AddOption(FF4Text("Use a command"))
 
 spell_menu.max_rows = 1
 for i as Integer = 1 to total_spells
  spell_menu.AddOption(spells(i).name)
 next
 
 item_menu.max_rows = 1
 for i as Integer = 1 to total_items
  item_menu.AddOption(item_names.ItemAt(i))
 next
 
 command_menu.max_rows = 1
 for i as Integer = 1 to total_commands
  command_menu.AddOption(menucommands(i).name)
 next
 
 do
 
  do
   edit_script = @script_menu(1)
   formation_index.ChangeSelected(autobattles(select_autobattle.selected).formation_index + 1)
   select_script.Hide()
   select_script.ClearAll()
   select_script.AddOption(FF4Text("Script 1"))
   if select_autobattle.selected >= 7 then select_script.AddOption(FF4Text("Script 2"))
   select_script.Display()
   for i as Integer = 1 to 2
    script_menu(i).Hide()
    script_menu(i).ClearAll()
    for j as Integer = 1 to len(autobattles(select_autobattle.selected).script(i)) \ 2
     script_menu(i).AddOption(autobattles(select_autobattle.selected).TranslateEntry(j, i))
    next
    script_menu(i).AddOption(FF4Text(Pad("-- END --", 14)))
   next
   script_menu(1).Display()
   if select_autobattle.selected >= 7 then script_menu(2).Display()
   formation_index.Display()
   edit_script->Display()
  loop until select_autobattle.UserInput()
  
  if not select_autobattle.cancelled then
  
   edit_autobattle.UserSelect()

   if not edit_autobattle.cancelled then
    
    if edit_autobattle.selected = 1 then

     formation_index.UserSelect()
     if not formation_index.cancelled then
      autobattles(select_autobattle.selected).formation_index = formation_index.selected - 1
     end if

    else

     select_script.UserSelect()

     if not select_script.cancelled then

      dim k as UInteger
      edit_script = @script_menu(select_script.selected)
      edit_entry.x = edit_script->x
      spell_menu.x = edit_entry.x + 2
      item_menu.x = spell_menu.x
      command_menu.x = spell_menu.x
      edit_script->cancelled = false

      do

       edit_script->Display()
       edit_script->ShowCursor()
       k = getkey

       select case k

        case DELETE_KEY
         if edit_script->selected < edit_script->options.Length() then
          temp = left(autobattles(select_autobattle.selected).script(select_script.selected), (edit_script->selected - 1) * 2)
          temp += mid(autobattles(select_autobattle.selected).script(select_script.selected), (edit_script->selected) * 2 + 1)
          autobattles(select_autobattle.selected).script(select_script.selected) = temp
         end if

        case INSERT_KEY
         temp = left(autobattles(select_autobattle.selected).script(select_script.selected), (edit_script->selected - 1) * 2)
         temp += chr(&hC0) + chr(0)
         temp += mid(autobattles(select_autobattle.selected).script(select_script.selected), (edit_script->selected - 1) * 2 + 1)
         autobattles(select_autobattle.selected).script(select_script.selected) = temp

        case ENTER_KEY

         edit_entry.y = edit_script->y + edit_script->selected - 1

         select case asc(mid(autobattles(select_autobattle.selected).script(select_script.selected), (edit_script->selected - 1) * 2 + 1), 1)
          case 0
           edit_entry.ChangeSelected(1)
          case 1
           edit_entry.ChangeSelected(2)
          case else
           edit_entry.ChangeSelected(3)
         end select

         edit_entry.UserSelect()

         if not edit_entry.cancelled then

          edit_entry.Display()

          select case edit_entry.selected

           case 1
            mid(autobattles(select_autobattle.selected).script(select_script.selected), (edit_script->selected - 1) * 2 + 1, 1) = chr(0)
            if asc(mid(autobattles(select_autobattle.selected).script(select_script.selected), edit_script->selected * 2, 1)) > total_spells then
             mid(autobattles(select_autobattle.selected).script(select_script.selected), edit_script->selected * 2) = chr(1)
            end if
            spell_menu.ChangeSelected(asc(mid(autobattles(select_autobattle.selected).script(select_script.selected), edit_script->selected * 2, 1)))
            spell_menu.y = edit_entry.y + 2
            spell_menu.UserSelect()
            if not spell_menu.cancelled then
             mid(autobattles(select_autobattle.selected).script(select_script.selected), edit_script->selected * 2) = chr(spell_menu.selected)
            end if

           case 2
            mid(autobattles(select_autobattle.selected).script(select_script.selected), (edit_script->selected - 1) * 2 + 1, 1) = chr(1)
            if asc(mid(autobattles(select_autobattle.selected).script(select_script.selected), edit_script->selected * 2, 1)) > total_items then
             mid(autobattles(select_autobattle.selected).script(select_script.selected), edit_script->selected * 2) = chr(0)
            end if
            item_menu.ChangeSelected(asc(mid(autobattles(select_autobattle.selected).script(select_script.selected), edit_script->selected * 2, 1)) + 1)
            item_menu.y = edit_entry.y + 2
            item_menu.UserSelect()
            if not item_menu.cancelled then
             mid(autobattles(select_autobattle.selected).script(select_script.selected), edit_script->selected * 2) = chr(item_menu.selected - 1)
            end if
            
           case 3
            mid(autobattles(select_autobattle.selected).script(select_script.selected), edit_script->selected * 2, 1) = chr(0)
            if asc(mid(autobattles(select_autobattle.selected).script(select_script.selected), (edit_script->selected - 1) * 2 + 1, 1)) < &hC0 then
             mid(autobattles(select_autobattle.selected).script(select_script.selected), (edit_script->selected - 1) * 2 + 1, 1) = chr(&hC0)
            end if
            command_menu.ChangeSelected(asc(mid(autobattles(select_autobattle.selected).script(select_script.selected), (edit_script->selected - 1) * 2 + 1, 1)) - &hC0 + 1)
            command_menu.y = edit_entry.y + 2
            command_menu.UserSelect()
            if not command_menu.cancelled then
             mid(autobattles(select_autobattle.selected).script(select_script.selected), (edit_script->selected - 1) * 2 + 1, 1) = chr(command_menu.selected - 1 + &hC0)
            end if
           
          end select

          edit_entry.Hide()

         end if

        case else
         edit_script->ProcessKey(k)

       end select

       edit_script->Hide()
       edit_script->ClearAll()
       for i as Integer = 1 to len(autobattles(select_autobattle.selected).script(select_script.selected)) \ 2
        edit_script->AddOption(autobattles(select_autobattle.selected).TranslateEntry(i, select_script.selected))
       next
       edit_script->AddOption(FF4Text(Pad("-- END --", 14)))
       formation_index.Display()
       script_menu(1).Display()
       if select_autobattle.selected >= 7 then script_menu(2).Display()

      loop until edit_script->cancelled

     end if

    end if

   end if
  
  end if
 
 loop until select_autobattle.cancelled

end sub
