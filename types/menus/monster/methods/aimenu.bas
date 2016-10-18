constructor AIMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 index_menu = BlueMenu(x, y)
 index_menu.max_rows = 1
 condition_menu = BlueMenu(x + 4, y + 3)
 condition_menu.max_rows = 5
 set_menu = BlueMenu(x, y + 3)
 set_menu.max_rows = 5
 script_index = BlueMenu(x, condition_menu.y + condition_menu.max_rows + 2)
 script_index.max_rows = 1
 script_menu = BlueMenu(x, script_index.y + 3)
 script_menu.max_rows = 10
 
 for i as Integer = 1 to total_ai_groups
  index_menu.AddOption(FF4Text("Index: " + str(i)))
 next
 
 for i as Integer = 1 to &h100
  script_index.AddOption(FF4Text("Script: " + str(i)))
 next
 
 condition_types = BlueMenu(x + 4, y)
 condition_types.max_rows = 1
 condition_types.AddOption(FF4Text("unit has status"))
 condition_types.AddOption(FF4Text("unit has low HP"))
 condition_types.AddOption(FF4Text("flag index"))
 condition_types.AddOption(FF4Text("character is defeated"))
 condition_types.AddOption(FF4Text("monster is defeated"))
 condition_types.AddOption(FF4Text("formation index"))
 condition_types.AddOption(FF4Text("all monsters are same type"))
 condition_types.AddOption(FF4Text("unit uses command _07"))
 condition_types.AddOption(FF4Text("unit uses command _08"))
 condition_types.AddOption(FF4Text("unknown"))
 condition_types.AddOption(FF4Text("takes damage"))
 condition_types.AddOption(FF4Text("only monster left"))
 condition_types.AddOption(FF4Text("no condition"))
 
 script_functions = BlueMenu(x, y)
 script_functions.max_rows = 1
 script_functions.AddOption(FF4Text("Cast a single-targeted spell"))
 script_functions.AddOption(FF4Text("Cast a group-targeted spell"))
 script_functions.AddOption(FF4Text("Use a monster technique"))
 script_functions.AddOption(FF4Text("Use a menu command"))
 script_functions.AddOption(FF4Text("Do nothing"))
 script_functions.AddOption(FF4Text("Change race"))
 script_functions.AddOption(FF4Text("Change attack"))
 script_functions.AddOption(FF4Text("Change defense"))
 script_functions.AddOption(FF4Text("Change magic defense"))
 script_functions.AddOption(FF4Text("Modify speed"))
 script_functions.AddOption(FF4Text("Set resistances"))
 script_functions.AddOption(FF4Text("Set spell power"))
 script_functions.AddOption(FF4Text("Set weakness"))
 script_functions.AddOption(FF4Text("Set sprite"))
 script_functions.AddOption(FF4Text("Show message"))
 script_functions.AddOption(FF4Text("Next action, show message"))
 script_functions.AddOption(FF4Text("Change music"))
 script_functions.AddOption(FF4Text("Set condition flag"))
 script_functions.AddOption(FF4Text("Set reaction"))
 script_functions.AddOption(FF4Text("Unknown _F6"))
 script_functions.AddOption(FF4Text("Darken screen"))
 script_functions.AddOption(FF4Text("Debug display"))
 script_functions.AddOption(FF4Text("Target"))
 script_functions.AddOption(FF4Text("Unknown _FA"))
 script_functions.AddOption(FF4Text("Chain into"))
 script_functions.AddOption(FF4Text("End chain"))
 script_functions.AddOption(FF4Text("Start a chain"))
 script_functions.AddOption(FF4Text("Wait"))
 
end constructor


function AIMenu.CurrentCondition() as UByte

 dim result as UByte
 dim total as UInteger
 dim temp as String
 
 for i as Integer = 1 to len(aigroupscripts(index))
  temp += conditionsets(asc(mid(aigroupconditions(index), i, 1)) + 1)
 next
 
 if len(temp) > 0 then result = Min(conditions(asc(mid(temp, condition_menu.selected, 1)) + 1).condition + 1, condition_types.options.Length())
 
 return result

end function


sub AIMenu.Display()
 
 index_menu.ChangeSelected(index)
 index_menu.Display()
 set_menu.Display()
 RefreshConditions()
 RefreshScripts()
 
end sub


sub AIMenu.Hide()

 index_menu.Hide()
 set_menu.Hide()
 condition_menu.Hide()
 script_index.Hide()
 script_menu.Hide()

end sub


sub AIMenu.RefreshConditions()

 dim temp as String
 dim c as String
 dim blank as Any ptr

 condition_menu.Hide()

 set_menu.ClearAll()
 for i as Integer = 1 to len(aigroupconditions(index))
  set_menu.AddOption(FF4Text(Pad(str(asc(mid(aigroupconditions(index), i, 1)) + 1), 2, true)))
 next

 condition_menu.ClearAll()
 if set_menu.options.Length() > 0 then
  temp = conditionsets(asc(mid(aigroupconditions(index), set_menu.selected, 1)) + 1)
  c = FF4Text("IF ")
  for j as Integer = 1 to len(temp)
   c += conditions(asc(mid(temp, j, 1)) + 1).TextDescription()
   condition_menu.AddOption(c)
   c = FF4Text(" AND ")
  next
 end if
 
 set_menu.Display()
 if condition_menu.selected > condition_menu.options.Length() then condition_menu.ChangeSelected(condition_menu.options.Length())
 condition_menu.Display()
 script_index.Display()
 
end sub


sub AIMenu.RefreshScripts()

 dim entry as AIScriptEntry ptr
 dim n as UInteger

 script_menu.Hide()
 
 script_menu.ClearAll()
 if set_menu.options.Length() > 0 then
  script_index.ChangeSelected(asc(mid(aigroupscripts(index), set_menu.selected, 1)) + 1)
  n = script_index.selected
  if lunar then n += &h100
  if n <= ubound(scripts) then
   for i as Integer = 1 to scripts(n).Length()
    entry = scripts(n).PointerAt(i)
    script_menu.AddOption(entry->TextDescription())
   next
   script_menu.AddOption(FF4Text("-- END SCRIPT --"))
  else
   script_menu.AddOption(FF4Text("-- DOES NOT EXIST --"))
  end if
  if script_menu.selected > script_menu.options.Length() then script_menu.ChangeSelected(script_menu.options.Length())
 end if
 
 script_menu.Display()
 script_index.Display()
 
end sub


sub AIMenu.SetTo(new_index as UByte, new_lunar as Boolean = false)

 index = new_index
 lunar = new_lunar
 
end sub


sub AIMenu.UserSelect()

 dim k as UInteger
 dim mode as String
 dim done as Boolean
 dim select_condition as BlueMenu

 select_condition.max_rows = 1
 for i as Integer = 1 to total_conditions
  select_condition.AddOption(conditions(i).TextDescription())
 next
 
 mode = "index"
 
 do
 
  select case mode

   case "index"
    index_menu.Display()
    index_menu.ShowCursor()
    k = getkey
    if k = TAB_KEY then
     mode = "set"
     index_menu.Display()
    else
     if index_menu.ProcessKey(k) then
      if not index_menu.cancelled then
       mode = "set"
       index_menu.Display()
      end if
     end if     
     index = index_menu.selected
     Display()
    end if
    
   case "set"
    set_menu.Display()
    set_menu.ShowCursor()
    k = getkey
    if k = TAB_KEY then
     mode = "condition"
     set_menu.Display()
    elseif k = INSERT_KEY then
     aigroupconditions(index) = left(aigroupconditions(index), set_menu.selected - 1) + chr(0) + mid(aigroupconditions(index), set_menu.selected)
     aigroupscripts(index) = left(aigroupscripts(index), set_menu.selected - 1) + chr(0) + mid(aigroupscripts(index), set_menu.selected)
     RefreshConditions()
     Display()
    elseif k = DELETE_KEY then
     if set_menu.options.Length() > 1 then 'set_menu.selected < set_menu.options.Length() then
      aigroupconditions(index) = left(aigroupconditions(index), set_menu.selected - 1) + mid(aigroupconditions(index), set_menu.selected + 1)
      aigroupscripts(index) = left(aigroupscripts(index), set_menu.selected - 1) + mid(aigroupscripts(index), set_menu.selected + 1)
      RefreshConditions()
      if set_menu.selected > set_menu.options.Length() then set_menu.ChangeSelected(set_menu.options.Length())
      Display()
     end if
    else
     if set_menu.ProcessKey(k) then
      if not set_menu.cancelled then
       dim n as BlueNumberInput
       n = BlueNumberInput(set_menu.x, set_menu.y + set_menu.selected - 1)
       n.min_value = 1
       n.max_value = 98
       n.starting_number = asc(mid(aigroupconditions(index), set_menu.selected, 1)) + 1
       n.number = n.starting_number
       do
        mid(aigroupconditions(index), set_menu.selected, 1) = chr(n.number - 1)
        RefreshConditions()
        script_menu.Display()
       loop until n.UserInput()
       mid(aigroupconditions(index), set_menu.selected, 1) = chr(n.number - 1)
       RefreshConditions()
      end if
     end if
     Display()
    end if

   case "condition"
    condition_menu.Display()
    condition_menu.ShowCursor()
    k = getkey
    if k = TAB_KEY then
     mode = "script index"
     condition_menu.Display()
    elseif k = INSERT_KEY then
     conditionsets(asc(mid(aigroupconditions(index), set_menu.selected, 1)) + 1) += chr(0)
     RefreshConditions()
     Display()
    elseif k = DELETE_KEY then
     dim temp as String
     temp = conditionsets(asc(mid(aigroupconditions(index), set_menu.selected, 1)) + 1)
     if len(temp) > 1 then
      conditionsets(asc(mid(aigroupconditions(index), set_menu.selected, 1)) + 1) = left(temp, condition_menu.selected - 1) + mid(temp, condition_menu.selected + 1)
      RefreshConditions()
      Display()
     end if
    else
     if condition_menu.ProcessKey(k) then
      if not condition_menu.cancelled then
       dim conditionindex as UByte
       conditionindex = asc(mid(conditionsets(asc(mid(aigroupconditions(index), set_menu.selected, 1)) + 1), condition_menu.selected, 1)) + 1
       condition_menu.Display()
       select_condition.x = condition_menu.x
       select_condition.y = condition_menu.y + condition_menu.selected - 1
       select_condition.ChangeSelected(conditionindex)
       select_condition.UserSelect()
       if not select_condition.cancelled then
        condition_menu.Display()
        select_condition.Display()
        mid(conditionsets(asc(mid(aigroupconditions(index), set_menu.selected, 1)) + 1), condition_menu.selected, 1) = chr(select_condition.selected - 1)
        condition_types.x = select_condition.x + 1
        condition_types.y = select_condition.y + 1
        condition_types.ChangeSelected(CurrentCondition())
        condition_types.UserSelect()
        if not condition_types.cancelled then
         conditions(conditionindex).condition = condition_types.selected - 1
         condition_menu.Display()
         condition_types.Display()
         
         dim units as BlueMenu
         units.max_rows = 1
         for i as Integer = 0 to &hFF
          units.AddOption(FF4Text("unit " + str(i)))
         next
         units.ChangeOption(23 + 1, FF4Text("self"))
         units.ChangeOption(25 + 1, FF4Text("a character"))
         
         select case conditions(conditionindex).condition
         
          case 0 'Unit has status
           units.x = condition_types.x + 2
           units.y = condition_types.y + 2
           units.ChangeSelected(conditions(conditionindex).xx + 1)
           units.UserSelect()
           if not units.cancelled then
            units.Display()
            dim status_byte as BlueMenu
            status_byte = BlueMenu(units.x + 2, units.y + 2)
            status_byte.max_rows = 1
            status_byte.AddOption(FF4Text("Persistent statuses"))
            status_byte.AddOption(FF4Text("Temporary statuses"))
            status_byte.AddOption(FF4Text("System statuses"))
            status_byte.AddOption(FF4Text("Hidden statuses"))
            status_byte.ChangeSelected(conditions(conditionindex).yy + 1)
            status_byte.UserSelect()
            if not status_byte.cancelled then
             status_byte.Display()
             dim status_menu as FlagMenu
             select case status_byte.selected
              case 1
               status_menu = FlagMenu(status_byte.x + 2, status_byte.y + 2, "persistent status")
              case 2
               status_menu = FlagMenu(status_byte.x + 2, status_byte.y + 2, "temporary status")
              case 3
               status_menu = FlagMenu(status_byte.x + 2, status_byte.y + 2, "system status")
              case 4
               status_menu = FlagMenu(status_byte.x + 2, status_byte.y + 2, "hidden status")
             end select
             for i as Integer = 1 to 8
              if conditions(conditionindex).zz and 2 ^ (i - 1) then status_menu.SetFlag(i) 'else status_menu.SetFlag(i, false)
             next
             status_menu.UserSelect()
             conditions(conditionindex).xx = units.selected - 1
             conditions(conditionindex).yy = status_byte.selected - 1
             conditions(conditionindex).zz = 0
             for i as integer = 1 to 8
              if status_menu.flags(i) then conditions(conditionindex).zz += 2 ^ (i - 1)
             next
             status_byte.Hide()
            end if
            units.Hide()
           end if
           
          case 1 'Unit has low HP
           units.x = condition_types.x + 2
           units.y = condition_types.y + 2
           units.ChangeSelected(conditions(conditionindex).xx + 1)
           units.UserSelect()
           if not units.cancelled then
            units.Display()
            dim select_hp as BlueMenu
            select_hp = BlueMenu(units.x + 2, units.y + 2)
            select_hp.max_rows = 1
            for i as Integer = 1 to total_condition_hps
             select_hp.AddOption(FF4Text(str(conditionhp(i)) + " HP"))
            next
            select_hp.ChangeSelected(conditions(conditionindex).zz + 1)
            select_hp.UserSelect()
            if not select_hp.cancelled then
             dim change_hp as BlueNumberInput
             change_hp = BlueNumberInput(select_hp.x, select_hp.y)
             change_hp.starting_number = conditionhp(select_hp.selected)
             change_hp.max_value = &hFFFF
             change_hp.UserSelect()
             conditionhp(select_hp.selected) = change_hp.number
             conditions(conditionindex).xx = units.selected - 1
             conditions(conditionindex).yy = 0
             conditions(conditionindex).zz = select_hp.selected - 1
            end if
            units.Hide()
           end if
           
          case 2 'Flag index
           dim flag_type as BlueMenu
           flag_type = BlueMenu(condition_types.x + 2, condition_types.y + 2)
           flag_type.AddOption(FF4Text("Condition flag"))
           flag_type.AddOption(FF4Text("Reaction flag"))
           if conditions(conditionindex).yy > 0 then flag_type.ChangeSelected(2)
           flag_type.UserSelect()
           if not flag_type.cancelled then
            flag_type.Display()
            dim flag_index as BlueNumberInput
            flag_index = BlueNumberInput(flag_type.x + 2, flag_type.y + 2)
            flag_index.starting_number = conditions(conditionindex).zz
            flag_index.UserSelect()
            conditions(conditionindex).xx = 0
            conditions(conditionindex).yy = flag_type.selected - 1
            conditions(conditionindex).zz = flag_index.number
            flag_type.Hide()
           end if
           
          case 3 'Character is defeated
           dim character_index as BlueNumberInput
           character_index = BlueNumberInput(condition_types.x + 2, condition_types.y + 2)
           character_index.starting_number = conditions(conditionindex).xx
           character_index.UserSelect()
           conditions(conditionindex).xx = character_index.number
           conditions(conditionindex).yy = 0
           conditions(conditionindex).zz = 0
           
          case 4 'Monster is defeated
           dim monster_index as BlueNumberInput
           monster_index = BlueNumberInput(condition_types.x + 2, condition_types.y + 2)
           monster_index.starting_number = conditions(conditionindex).xx
           monster_index.UserSelect()
           conditions(conditionindex).xx = monster_index.number
           conditions(conditionindex).yy = 0
           conditions(conditionindex).zz = 0
           
          case 5 'Formation index
           dim select_world as BlueMenu
           select_world = BlueMenu(condition_types.x + 2, condition_types.y + 2)
           select_world.AddOption(FF4Text("Overworld"))
           select_world.AddOption(FF4Text("Underground/Moon"))
           if conditions(conditionindex).yy > 0 then select_world.ChangeSelected(2)
           select_world.UserSelect()
           if not select_world.cancelled then
            select_world.Display()
            dim formation_index as BlueNumberInput
            formation_index = BlueNumberInput(select_world.x + 2, select_world.y + 2)
            formation_index.min_value = 1
            formation_index.max_value = 256
            formation_index.starting_number = conditions(conditionindex).zz + 1
            formation_index.UserSelect()
            conditions(conditionindex).xx = 0
            conditions(conditionindex).yy = select_world.selected - 1
            conditions(conditionindex).zz = formation_index.number - 1
            select_world.Hide()
           end if
           
          case 6, 9, 10, 11
           conditions(conditionindex).xx = 0
           conditions(conditionindex).yy = 0
           conditions(conditionindex).zz = 0
           
          case 7, 8
           units.ChangeOption(1, FF4Text("Any unit"))
           units.x = condition_types.x + 2
           units.y = condition_types.y + 2
           units.ChangeSelected(conditions(conditionindex).xx + 1)
           units.UserSelect()
           if not units.cancelled then
            units.Display()
            dim select_command as BlueMenu
            select_command = BlueMenu(units.x + 2, units.y + 2)
            select_command.max_rows = 1
            for i as Integer = 1 to 256
             select_command.AddOption(FF4Text("Command " + str(i - 1)))
            next
            select_command.ChangeOption(193, menucommands(1).name)
            select_command.ChangeOption(195, FF4Text("magic"))
            select_command.ChangeOption(197, menucommands(5).name)
            select_command.ChangeOption(198, menucommands(6).name)
            select_command.ChangeOption(200, menucommands(8).name)
            select_command.ChangeOption(201, menucommands(9).name)
            select_command.ChangeOption(205, menucommands(13).name)
            select_command.ChangeOption(206, menucommands(14).name)
            select_command.ChangeOption(207, menucommands(15).name)
            select_command.ChangeOption(209, menucommands(17).name)
            select_command.ChangeOption(211, menucommands(19).name)
            select_command.ChangeOption(213, menucommands(21).name)
            select_command.ChangeOption(215, menucommands(23).name)
            select_command.ChangeOption(216, menucommands(24).name)
            select_command.ChangeOption(223, menucommands(7).name)
            select_command.ChangeSelected(conditions(conditionindex).yy + 1)
            select_command.UserSelect()
            if not select_command.cancelled then
             select_command.Display()
             dim elements as FlagMenu
             elements = FlagMenu(select_command.x + 2, select_command.y + 2, "element")
             for i as Integer = 1 to 8
              if conditions(conditionindex).zz and 2 ^ (i - 1) then elements.SetFlag(i)
             next
             elements.UserSelect()
             conditions(conditionindex).xx = units.selected - 1
             conditions(conditionindex).yy = select_command.selected - 1
             conditions(conditionindex).zz = 0
             for i as Integer = 1 to 8
              if elements.flags(i) then conditions(conditionindex).zz += 2 ^ (i - 1)
             next
             select_command.Hide()
            end if
            units.Hide()
           end if
           
         end select
         condition_types.Hide()
         condition_menu.Hide()
         select_condition.ChangeOption(conditionindex, conditions(conditionindex).TextDescription())
        end if
        RefreshConditions()
       end if
      end if
      select_condition.Hide()
      RefreshScripts()
      Display()
     end if
    end if
    
   case "script index"
    script_index.Display()
    script_index.ShowCursor()
    k = getkey
    if k = TAB_KEY then
     if not lunar or script_index.selected + &h100 <= ubound(scripts) then
      mode = "script"
     else
      mode = "index"
     end if
     script_index.Display()
    else
     if script_index.ProcessKey(k) then
      if not script_index.cancelled then
       if not lunar or script_index.selected + &h100 <= ubound(scripts) then mode = "script"
       RefreshScripts()
       script_index.Display()
      end if
     end if
     mid(aigroupscripts(index), set_menu.selected, 1) = chr(script_index.selected - 1)
     RefreshScripts()
    end if

   case "script"
    dim n as UInteger
    n = asc(mid(aigroupscripts(index), set_menu.selected, 1)) + 1
    if lunar then n += &h100
    script_menu.Display()
    script_menu.ShowCursor()
    k = getkey
    if k = TAB_KEY then
     mode = "index"
     script_menu.Display()
    elseif k = INSERT_KEY then
     dim entry as AIScriptEntry ptr
     entry = callocate(SizeOf(AIScriptEntry))
     entry->function_call = &hE1
     scripts(n).Insert(script_menu.selected, entry)
     RefreshScripts()
     Display()
    elseif k = DELETE_KEY then
     scripts(n).Remove(script_menu.selected)
     RefreshScripts()
     Display()
    else
     if script_menu.ProcessKey(k) then
      if not script_menu.cancelled and script_menu.selected < script_menu.options.Length() then
       dim entry as AIScriptEntry ptr
       script_functions.y = script_menu.y + script_menu.selected - script_menu.top_row
       entry = scripts(n).PointerAt(script_menu.selected)
       script_functions.ChangeSelected(entry->FunctionToIndex())
       script_functions.UserSelect()

       if not script_functions.cancelled then

        script_functions.Display()
        dim confirm as boolean = false
        dim p as UByte

        select case script_functions.selected

         case 1 'Cast a single-targeted spell
          dim pmenu as BlueMenu
          pmenu = BlueMenu(script_functions.x + 2, script_functions.y + 2)
          pmenu.max_rows = 1
          for i as Integer = 1 to &h30
           pmenu.AddOption(spells(i).name)
          next
          pmenu.ChangeSelected(entry->function_call)
          pmenu.UserSelect()
          if not pmenu.cancelled then
           confirm = true
           p = pmenu.selected
          end if

         case 2 'Cast a group-targeted spell
          dim pmenu as BlueMenu
          pmenu = BlueMenu(script_functions.x + 2, script_functions.y + 2)
          pmenu.max_rows = 1
          for i as Integer = &h1 to &h2E
           pmenu.AddOption(spells(i).name)
          next
          pmenu.ChangeSelected(entry->function_call - &h30)
          pmenu.UserSelect()
          if not pmenu.cancelled then
           confirm = true
           p = pmenu.selected - 1
          end if

         case 3 'Use a monster technique
          dim pmenu as BlueMenu
          pmenu = BlueMenu(script_functions.x + 2, script_functions.y + 2)
          pmenu.max_rows = 1
          for i as Integer = &h5F to &hBF
           pmenu.AddOption(spells(i).name)
          next
          pmenu.ChangeSelected(entry->function_call - &h5E)
          pmenu.UserSelect()
          if not pmenu.cancelled then
           confirm = true
           p = pmenu.selected - 1
          end if

         case 4 'Use a menu command
          dim pmenu as BlueMenu
          pmenu = BlueMenu(script_functions.x + 2, script_functions.y + 2)
          pmenu.max_rows = 1
          for i as Integer = 1 to &h27
           if i <= total_commands then
            pmenu.AddOption(menucommands(i).name)
           else
            pmenu.AddOption(FF4Text("Unknown"))
           end if
          next
          pmenu.ChangeSelected(entry->function_call - &hBF)
          pmenu.UserSelect()
          if not pmenu.cancelled then
           confirm = true
           p = pmenu.selected - 1
          end if
         
         case 5 'Do nothing
          confirm = true
          p = 0
          
         case 6 'Change race
          dim pmenu as FlagMenu
          pmenu = FlagMenu(script_functions.x + 2, script_functions.y + 2, "race")
          for i as Integer = 1 to 8
           if entry->parameter and 2 ^ (i - 1) then pmenu.SetFlag(i)
          next
          pmenu.UserSelect()
          confirm = true
          p = 0
          for i as Integer = 1 to 8
           if pmenu.flags(i) then p += 2 ^ (i - 1)
          next
         
         case 7 'Change attack
          dim pmenu as BlueMenu
          pmenu = BlueMenu(script_functions.x + 2, script_functions.y + 2)
          pmenu.max_rows = 1
          for i as Integer = 1 to total_stat_groups
           pmenu.AddOption(FF4Text(str(stat_groups(i).percentage) + "% " + str(stat_groups(i).stat_base) + " x" + str(stat_groups(i).multiplier)))
          next
          pmenu.ChangeSelected(entry->parameter + 1)
          pmenu.UserSelect()
          if not pmenu.cancelled then
           confirm = true
           p = pmenu.selected - 1
          end if
         
         case 8 'Change defense
          dim pmenu as BlueMenu
          pmenu = BlueMenu(script_functions.x + 2, script_functions.y + 2)
          pmenu.max_rows = 1
          for i as Integer = 1 to total_stat_groups
           pmenu.AddOption(FF4Text(str(stat_groups(i).percentage) + "% " + str(stat_groups(i).stat_base) + " x" + str(stat_groups(i).multiplier)))
          next
          pmenu.ChangeSelected(entry->parameter + 1)
          pmenu.UserSelect()
          if not pmenu.cancelled then
           confirm = true
           p = pmenu.selected - 1
          end if
         
         case 9 'Change magic defense
          dim pmenu as BlueMenu
          pmenu = BlueMenu(script_functions.x + 2, script_functions.y + 2)
          pmenu.max_rows = 1
          for i as Integer = 1 to total_stat_groups
           pmenu.AddOption(FF4Text(str(stat_groups(i).percentage) + "% " + str(stat_groups(i).stat_base) + " x" + str(stat_groups(i).multiplier)))
          next
          pmenu.ChangeSelected(entry->parameter + 1)
          pmenu.UserSelect()
          if not pmenu.cancelled then
           confirm = true
           p = pmenu.selected - 1
          end if
         
         case 10 'Modify speed
          dim pmenu as BlueNumberInput
          pmenu = BlueNumberInput(script_functions.x + 2, script_functions.y + 2)
          pmenu.starting_number = entry->parameter
          pmenu.number = pmenu.starting_number
          pmenu.UserSelect()
          confirm = true
          p = pmenu.number

         case 11 'Set resistances
          dim pmenu as FlagMenu
          pmenu = FlagMenu(script_functions.x + 2, script_functions.y + 2, "element")
          for i as Integer = 1 to 8
           if entry->parameter and 2 ^ (i - 1) then pmenu.SetFlag(i)
          next
          pmenu.UserSelect()
          confirm = true
          p = 0
          for i as Integer = 1 to 8
           if pmenu.flags(i) then p += 2 ^ (i - 1)
          next
         
         case 12 'Set spell power
          dim pmenu as BlueNumberInput
          pmenu = BlueNumberInput(script_functions.x + 2, script_functions.y + 2)
          pmenu.starting_number = entry->parameter
          pmenu.number = pmenu.starting_number
          pmenu.UserSelect()
          confirm = true
          p = pmenu.number
          
         case 13 'Set weakness
          dim pmenu as FlagMenu
          pmenu = FlagMenu(script_functions.x + 2, script_functions.y + 2, "element")
          for i as Integer = 1 to 8
           if entry->parameter and 2 ^ (i - 1) then pmenu.SetFlag(i)
          next
          pmenu.UserSelect()
          confirm = true
          p = 0
          for i as Integer = 1 to 8
           if pmenu.flags(i) then p += 2 ^ (i - 1)
          next

         case 14 'Set sprite
          dim pmenu as BlueNumberInput
          pmenu = BlueNumberInput(script_functions.x + 2, script_functions.y + 2)
          pmenu.starting_number = entry->parameter
          pmenu.number = pmenu.starting_number
          pmenu.UserSelect()
          confirm = true
          p = pmenu.number
          
         case 15 'Show message
          dim pmenu as BlueMenu
          pmenu = BlueMenu(script_functions.x + 2, script_functions.y + 2)
          pmenu.max_rows = 1
          for i as Integer = 1 to dialogues_battle.Length()
           pmenu.AddOption(dialogues_battle.ItemAt(i))
          next
          pmenu.ChangeSelected(entry->parameter + 1)
          pmenu.UserSelect()
          if not pmenu.cancelled then
           confirm = true
           p = pmenu.selected - 1
          end if
         
         case 16 'Next action, show message
          dim pmenu as BlueMenu
          pmenu = BlueMenu(script_functions.x + 2, script_functions.y + 2)
          pmenu.max_rows = 1
          for i as Integer = 1 to dialogues_battle.Length()
           pmenu.AddOption(dialogues_battle.ItemAt(i))
          next
          pmenu.ChangeSelected(entry->parameter + 1)
          pmenu.UserSelect()
          if not pmenu.cancelled then
           confirm = true
           p = pmenu.selected - 1
          end if

         case 17 'Change music
          dim pmenu as BlueMenu
          pmenu = BlueMenu(script_functions.x + 2, script_functions.y + 2)
          pmenu.max_rows = 1
          for i as Integer = 1 to total_songs
           pmenu.AddOption(song_names.ItemAt(i))
          next
          pmenu.ChangeSelected(entry->parameter + 1)
          pmenu.UserSelect()
          if not pmenu.cancelled then
           confirm = true
           p = pmenu.selected - 1
          end if

         case 18 'Set condition flag
          dim pmenu as BlueNumberInput
          pmenu = BlueNumberInput(script_functions.x + 2, script_functions.y + 2)
          pmenu.starting_number = entry->parameter
          pmenu.number = pmenu.starting_number
          pmenu.UserSelect()
          confirm = true
          p = pmenu.number
          
         case 19 'Set reaction
          dim pmenu as BlueNumberInput
          pmenu = BlueNumberInput(script_functions.x + 2, script_functions.y + 2)
          pmenu.starting_number = entry->parameter
          pmenu.number = pmenu.starting_number
          pmenu.UserSelect()
          confirm = true
          p = pmenu.number
          
         case 20 'Unknown _F6
          dim pmenu as BlueNumberInput
          pmenu = BlueNumberInput(script_functions.x + 2, script_functions.y + 2)
          pmenu.starting_number = entry->parameter
          pmenu.number = pmenu.starting_number
          pmenu.UserSelect()
          confirm = true
          p = pmenu.number
          
         case 21 'Unknown _F7
          dim pmenu as BlueNumberInput
          pmenu = BlueNumberInput(script_functions.x + 2, script_functions.y + 2)
          pmenu.starting_number = entry->parameter
          pmenu.number = pmenu.starting_number
          pmenu.UserSelect()
          confirm = true
          p = pmenu.number
          
         case 22 'Unknown _F8
          dim pmenu as BlueNumberInput
          pmenu = BlueNumberInput(script_functions.x + 2, script_functions.y + 2)
          pmenu.starting_number = entry->parameter
          pmenu.number = pmenu.starting_number
          pmenu.UserSelect()
          confirm = true
          p = pmenu.number
          
         case 23 'Target
          dim pmenu as BlueMenu
          pmenu = BlueMenu(script_functions.x + 2, script_functions.y + 2)
          pmenu.max_rows = 1
          for i as Integer = 0 to &h15
           if i > 0 and i <= total_actors then
            pmenu.AddOption(actor_names.ItemAt(i))
           else
            pmenu.AddOption(FF4Text("Unknown"))
           end if
          next
          pmenu.AddOption(FF4Text("self"))
          pmenu.AddOption(FF4Text("all monsters"))
          pmenu.AddOption(FF4Text("all other monsters"))
          pmenu.AddOption(FF4Text("all Type 1 monsters"))
          pmenu.AddOption(FF4Text("all Type 2 monsters"))
          pmenu.AddOption(FF4Text("all Type 3 monsters"))
          pmenu.AddOption(FF4Text("all front row characters"))
          pmenu.AddOption(FF4Text("all back row characters"))
          pmenu.AddOption(FF4Text("a stunned monster"))
          pmenu.AddOption(FF4Text("an asleep monster"))
          pmenu.AddOption(FF4Text("a charmed monster"))
          pmenu.AddOption(FF4Text("a critical monster"))
          pmenu.AddOption(FF4Text("random monster or character"))
          pmenu.AddOption(FF4Text("random other monster or character"))
          pmenu.AddOption(FF4Text("random monster"))
          pmenu.AddOption(FF4Text("random other monster"))
          pmenu.AddOption(FF4Text("random front row character"))
          pmenu.AddOption(FF4Text("random back row character"))
          pmenu.AddOption(FF4Text("all characters"))
          pmenu.AddOption(FF4Text("all KO monsters"))
          pmenu.ChangeSelected(entry->parameter + 1)
          pmenu.UserSelect()
          if not pmenu.cancelled then
           confirm = true
           p = pmenu.selected - 1
          end if
          
         case else
          confirm = true

        end select

        script_functions.Hide()
        if confirm then 
         entry->IndexToFunction(script_functions.selected, p)
         Display()
        else
         RefreshScripts()
        end if

       end if
      end if
     end if
    end if

  end select

 loop until index_menu.cancelled or set_menu.cancelled or condition_menu.cancelled or script_index.cancelled or script_menu.cancelled
 
 index_menu.cancelled = false
 set_menu.cancelled = false
 condition_menu.cancelled = false
 script_index.cancelled = false
 script_menu.cancelled = false

 select_condition.ClearAll()

end sub
