sub EditCommands()

 'Declare local variables
 dim select_command as BlueMenu
 dim edit_command as BlueMenu
 dim name_input as BlueTextInput
 dim number_input as BlueNumberInput
 dim status_menu as FlagMenu
 dim edit_info as BlueMenu
 dim edit_parameters as CommandParametersMenu
 dim edit_ranges as BlueMenu
 dim edit_name as Boolean
 dim blank as Any ptr
 dim stance_menu as BlueMenu
 
 'Set up command selection menu
 for i as Integer = 1 to total_commands
  select_command.AddOption(menucommands(i).name)
 next
 
 'Set up command editing menu
 edit_command.AddOption(FF4Text("Ranges"))
 edit_command.AddOption(FF4Text("Information"))
 edit_command.AddOption(FF4Text("Parameters"))
 edit_command.x = 78 - edit_command.options.Width()
 
 'Set up name input window
 name_input = BlueTextInput(select_command.options.Width() + 15, 5)
 name_input.text_width = 5
 
 'Set up number input window
 number_input = BlueNumberInput(name_input.x, name_input.y + 2)
 number_input.min_value = 0
 number_input.max_value = &hFF
 
 'Set up command info and parameters menus
 edit_info = BlueMenu(select_command.options.Width() + 2, 5)
 edit_parameters = CommandParametersMenu(select_command.options.Width() + 2, 14)
 
 'Set up ranges menu
 edit_ranges = BlueMenu(select_command.options.Width() + 2, 0)
 edit_ranges.columns = 3
 edit_ranges.AddOption(menucommands(restricted_command1 + 1).name)
 edit_ranges.AddOption(FF4Text("No weapon to"))
 edit_ranges.AddOption(item_names.ItemAt(command1_end - 1))
 edit_ranges.AddOption(menucommands(restricted_command2 + 1).name)
 edit_ranges.AddOption(item_names.ItemAt(command2_start + 1) + FF4Text(" to"))
 edit_ranges.AddOption(item_names.ItemAt(command2_end))
 edit_ranges.AddOption(menucommands(restricted_command3 + 1).name)
 edit_ranges.AddOption(item_names.ItemAt(command3_start + 1) + FF4Text(" to"))
 edit_ranges.AddOption(item_names.ItemAt(command3_end - 1))

 stance_menu = BlueMenu(name_input.x, edit_parameters.y + 6)
 stance_menu.max_rows = 1
 for i as Integer = 1 to total_stances
  stance_menu.AddOption(stance_names.ItemAt(i))
 next

 'Used for clearing windows
 blank = ImageCreate(640 - (select_command.options.Width() + 2) * 8, 480 - 3 * 8, RGB(0, 0, 0))
 
 'Main editor loop
 do until select_command.cancelled
  
  'Input loop; continuously updates displayed information to correspond
  ' with currently highlighted option
  do 
  
   edit_info.Hide()
   put (edit_parameters.x * 8, edit_parameters.y * 8), blank, pset
   if MenuCommand.HasParameters(select_command.selected) then
    edit_parameters.SetTo(select_command.selected)
    edit_parameters.Display()
   end if
   name_input.starting_text = menucommands(select_command.selected).name
   edit_info.ChangeOption(1, FF4Text("Name:        ") + menucommands(select_command.selected).name, 15)
   edit_info.ChangeOption(2, FF4Text("Target:      ") + Pad(targets.ItemAt(menucommands(select_command.selected).target + 1), targets.Width(),, FF4Text(" ")), 15)
   edit_info.ChangeOption(3, FF4Text("Delay index: " + Pad(str(menucommands(select_command.selected).delay), 3)), 15)
   edit_info.ChangeOption(4, FF4Text("Disable if:  ") + StatusList(menucommands(select_command.selected).disabling_persistent, "persistent"), 15)
   edit_info.ChangeOption(5, FF4Text("        or:  ") + StatusList(menucommands(select_command.selected).disabling_temporary, "temporary"), 15)
   edit_info.ChangeOption(6, FF4Text("Wait stance: ") + stance_names.ItemAt(menucommands(select_command.selected).charging_stance), 15)
   edit_info.ChangeOption(7, FF4Text("Act stance:  ") + iif(menucommands(select_command.selected).action_stance = &hFF, FF4Text("N/A"), Pad(stance_names.ItemAt(menucommands(select_command.selected).action_stance), stance_names.Width(),, FF4Text(" "))), 15)
   if select_command.selected = 7 then
    edit_info.ChangeOption(8, FF4Text("     second: ") + Pad(stance_names.ItemAt(menucommands(select_command.selected).action_stance2), stance_names.Width(),, FF4Text(" ")), 15)
    edit_info.ChangeOption(9, FF4Text("      third: ") + Pad(stance_names.ItemAt(menucommands(select_command.selected).action_stance3), stance_names.Width(),, FF4Text(" ")), 15)
   else
    edit_info.Remove(8)
    edit_info.Remove(8)
   end if
   edit_info.Display()
   edit_ranges.Display()
  
  loop until select_command.UserInput()
  
  if not select_command.cancelled then
  
   if MenuCommand.HasParameters(select_command.selected) then
    edit_command.ChangeOption(3, FF4Text("Parameters"), 15)
   else
    edit_command.Remove(3)
   end if
   
   edit_command.UserSelect()
   if not edit_command.cancelled then
    select case edit_command.selected
     case 1 'Ranges
      do
       edit_ranges.UserSelect()
       if not edit_ranges.cancelled then
        select case edit_ranges.selected
         case 1
          dim command_menu as BlueMenu
          for i as Integer = 1 to total_commands
           command_menu.AddOption(menucommands(i).name)
          next
          command_menu.max_rows = 1
          command_menu.x = edit_ranges.x
          command_menu.y = 0
          command_menu.ChangeSelected(restricted_command1 + 1)
          command_menu.UserSelect()
          if not command_menu.cancelled then restricted_command1 = command_menu.selected - 1
          edit_ranges.ChangeOption(1, menucommands(restricted_command1 + 1).name)
         case 3
          command1_end = ListItem(edit_ranges.x + 30, edit_ranges.y, item_names.Slice(1, total_weapons + 1), command1_end - 1) + 1
          edit_ranges.ChangeOption(3, item_names.ItemAt(command1_end - 1))
         case 4
          dim command_menu as BlueMenu
          for i as Integer = 1 to total_commands
           command_menu.AddOption(menucommands(i).name)
          next
          command_menu.max_rows = 1
          command_menu.x = edit_ranges.x
          command_menu.y = 1
          command_menu.ChangeSelected(restricted_command2 + 1)
          command_menu.UserSelect()
          if not command_menu.cancelled then restricted_command2 = command_menu.selected - 1
          edit_ranges.ChangeOption(4, menucommands(restricted_command2 + 1).name)
         case 5
          command2_start = ListItem(edit_ranges.x + 14, edit_ranges.y + 1, item_names.Slice(1, total_weapons + 1), command2_start + 1) - 1
          edit_ranges.ChangeOption(5, item_names.ItemAt(command2_start + 1) + FF4Text(" to"))
         case 6
          command2_end = ListItem(edit_ranges.x + 28, edit_ranges.y + 1, item_names.Slice(1, total_weapons + 1), command2_end)
          edit_ranges.ChangeOption(6, item_names.ItemAt(command2_end))
         case 7
          dim command_menu as BlueMenu
          for i as Integer = 1 to total_commands
           command_menu.AddOption(menucommands(i).name)
          next
          command_menu.max_rows = 1
          command_menu.x = edit_ranges.x
          command_menu.y = 2
          command_menu.ChangeSelected(restricted_command3 + 1)
          command_menu.UserSelect()
          if not command_menu.cancelled then restricted_command3 = command_menu.selected - 1
          edit_ranges.ChangeOption(7, menucommands(restricted_command3 + 1).name)
         case 8
          command3_start = ListItem(edit_ranges.x + 14, edit_ranges.y + 2, item_names.Slice(1, total_weapons + 1), command3_start + 1) - 1
          edit_ranges.ChangeOption(8, item_names.ItemAt(command3_start + 1) + FF4Text(" to"))
         case 9
          command3_end = ListItem(edit_ranges.x + 28, edit_ranges.y + 2, item_names.Slice(1, total_weapons + 1), command3_end - 1) + 1
          edit_ranges.ChangeOption(9, item_names.ItemAt(command3_end - 1))
        end select
       end if
       edit_ranges.Display()
      loop until edit_ranges.cancelled

     case 2 'Information

      do

       edit_info.UserSelect()

       if not edit_info.cancelled then

        select case edit_info.selected

         case 1 'Name
          name_input.UserType()
          menucommands(select_command.selected).name = Pad(name_input.text, 5,, FF4Text(" "))
          select_command.ChangeOption(select_command.selected, name_input.text)
          edit_info.ChangeOption(1, FF4Text("Name:        ") + menucommands(select_command.selected).name, 15)

         case 2 'Target
          menucommands(select_command.selected).target = ListItem(name_input.x, name_input.y + 1, targets, menucommands(select_command.selected).target + 1) - 1
          edit_info.ChangeOption(2, FF4Text("Target:      ") + Pad(targets.ItemAt(menucommands(select_command.selected).target + 1), targets.Width(),, FF4Text(" ")), 15)

         case 3 'Delay
          number_input.y = edit_info.y + 2
          number_input.max_value = &hFE
          number_input.starting_number = menucommands(select_command.selected).delay
          number_input.UserSelect()
          menucommands(select_command.selected).delay = number_input.number
          edit_info.ChangeOption(3, FF4Text("Delay index: " + Pad(str(menucommands(select_command.selected).delay), 3)), 15)

         case 4 'Persistent statuses
          status_menu = FlagMenu(name_input.x, name_input.y + 3, "persistent status")
          for i as Integer = 0 to 7
           if menucommands(select_command.selected).disabling_persistent and 2^i then status_menu.SetFlag(i + 1)
          next
          status_menu.UserSelect()
          menucommands(select_command.selected).disabling_persistent = 0
          for i as Integer = 0 to 7
           if status_menu.flags(i + 1) then menucommands(select_command.selected).disabling_persistent += 2^i
          next
          edit_info.ChangeOption(4, FF4Text("Disable if:  ") + StatusList(menucommands(select_command.selected).disabling_persistent, "persistent"), 15)

         case 5 'Temporary statuses
          status_menu = FlagMenu(name_input.x, name_input.y + 4, "temporary status")
          for i as Integer = 0 to 7
           if menucommands(select_command.selected).disabling_temporary and 2^i then status_menu.SetFlag(i + 1)
          next
          status_menu.UserSelect()
          menucommands(select_command.selected).disabling_temporary = 0
          for i as Integer = 0 to 7
           if status_menu.flags(i + 1) then menucommands(select_command.selected).disabling_temporary += 2^i
          next
          edit_info.ChangeOption(5, FF4Text("        or:  ") + StatusList(menucommands(select_command.selected).disabling_temporary, "temporary"), 15)

         case 6 'Wait stance
          'number_input.y = edit_info.y + 5
          'number_input.max_value = &hFE
          'number_input.starting_number = menucommands(select_command.selected).charging_stance
          'number_input.UserSelect()
          'menucommands(select_command.selected).charging_stance = number_input.number
          stance_menu.y = edit_info.y + 5
          stance_menu.ChangeSelected(menucommands(select_command.selected).charging_stance)
          stance_menu.UserSelect()
          menucommands(select_command.selected).charging_stance = stance_menu.selected
          edit_info.ChangeOption(6, FF4Text("Wait stance: ") + stance_names.ItemAt(menucommands(select_command.selected).charging_stance), 15)

         case 7 'Act stance
          if menucommands(select_command.selected).action_stance < &hFF then
           'number_input.y = edit_info.y + 6
           'number_input.max_value = &hFE
           'number_input.starting_number = menucommands(select_command.selected).action_stance
           'number_input.UserSelect()
           'menucommands(select_command.selected).action_stance = number_input.number
           stance_menu.y = edit_info.y + 6
           stance_menu.ChangeSelected(menucommands(select_command.selected).action_stance)
           stance_menu.UserSelect()
           menucommands(select_command.selected).action_stance = stance_menu.selected
           edit_info.ChangeOption(7, FF4Text("Act stance:  ") + iif(menucommands(select_command.selected).action_stance = &hFF, FF4Text("N/A"), Pad(stance_names.ItemAt(menucommands(select_command.selected).action_stance), stance_names.Width(),, FF4Text(" "))), 15)
          end if
          
         case 8 'Second act stance
          if select_command.selected = 7 then
           'number_input.y = edit_info.y + 7
           'number_input.max_value = &hFE
           'number_input.starting_number = menucommands(select_command.selected).action_stance2
           'number_input.UserSelect()
           'menucommands(select_command.selected).action_stance2 = number_input.number
           stance_menu.y = edit_info.y + 7
           stance_menu.ChangeSelected(menucommands(select_command.selected).action_stance2)
           stance_menu.UserSelect()
           menucommands(select_command.selected).action_stance2 = stance_menu.selected
           edit_info.ChangeOption(8, FF4Text("     second: ") + Pad(stance_names.ItemAt(menucommands(select_command.selected).action_stance2), stance_names.Width(),, FF4Text(" ")), 15)
          end if
         
         case 9 'Third act stance
          if select_command.selected = 7 then
           'number_input.y = edit_info.y + 8
           'number_input.max_value = &hFE
           'number_input.starting_number = menucommands(select_command.selected).action_stance3
           'number_input.UserSelect()
           'menucommands(select_command.selected).action_stance3 = number_input.number
           stance_menu.y = edit_info.y + 8
           stance_menu.ChangeSelected(menucommands(select_command.selected).action_stance3)
           stance_menu.UserSelect()
           menucommands(select_command.selected).action_stance3 = stance_menu.selected
           edit_info.ChangeOption(9, FF4Text("      third: ") + Pad(stance_names.ItemAt(menucommands(select_command.selected).action_stance3), stance_names.Width(),, FF4Text(" ")), 15)
          end if

        end select
        
        edit_info.Hide()
        put (edit_parameters.x * 8, edit_parameters.y * 8), blank, pset
        if MenuCommand.HasParameters(select_command.selected) then edit_parameters.Display()
        edit_info.Display()
        
       end if
       
      loop until edit_info.cancelled
      
     case 3 'Parameters
      edit_parameters.UserSelect()

    end select

   end if
   
  end if
 
 loop

end sub
