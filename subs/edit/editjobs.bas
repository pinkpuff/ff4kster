sub EditJobs()

 dim select_job as BlueMenu
 dim edit_job as BlueMenu
 dim edit_name as BlueTextInput
 dim spell_link_menu as SpellLinkMenu
 dim spell_name_menu as BlueMenu
 dim edit_set_name as BlueTextInput
 
 for i as Integer = 1 to total_jobs
  select_job.AddOption(jobs(i).name)
 next
 
 edit_name = BlueTextInput(select_job.options.Width() + 2, 0, 7)
 spell_link_menu = SpellLinkMenu(select_job.options.Width() + 2, 3)
 
 edit_job.AddOption(FF4Text("Edit name"))
 edit_job.AddOption(FF4Text("Edit spell set links"))
 edit_job.AddOption(FF4Text("Edit spell set names"))
 edit_job.x = screen_width - edit_job.options.Width() - 2
 
 spell_name_menu.x = spell_link_menu.x
 spell_name_menu.y = spell_link_menu.y + 3
 spell_name_menu.AddOption(white_spellset_name + FF4Text(": "))
 spell_name_menu.AddOption(black_spellset_name + FF4Text(": "))
 spell_name_menu.AddOption(call_spellset_name + FF4Text(": "))
 
 edit_set_name.x = spell_name_menu.x
 edit_set_name.text_width = 5
 
 do
  do
   edit_name.starting_text = jobs(select_job.selected).name
   edit_name.ChangeStartingText(edit_name.starting_text)
   edit_name.Display()
   spell_link_menu.SetTo(select_job.selected)
   spell_link_menu.Display()
   spell_name_menu.Display()
  loop until select_job.UserInput()
  if not select_job.cancelled then
   edit_job.UserSelect()
   if not edit_job.cancelled then
    select case edit_job.selected
     case 1 'Name
      edit_name.UserType()
      jobs(select_job.selected).name = Pad(edit_name.text, 7, , FF4Text(" "))
      select_job.ChangeOption(select_job.selected, jobs(select_job.selected).name)
      select_job.Display()
     case 2 'Spell set links
      spell_link_menu.UserSelect()
      jobs(select_job.selected).white = spell_link_menu.white - 1
      jobs(select_job.selected).black = spell_link_menu.black - 1
      jobs(select_job.selected).summon = spell_link_menu.summon - 1
      jobs(select_job.selected).menu_white = spell_link_menu.menu_white - 1
      jobs(select_job.selected).menu_black = spell_link_menu.menu_black - 1
      jobs(select_job.selected).menu_summon = spell_link_menu.menu_summon - 1
     case 3 'Spell set names
      spell_name_menu.UserSelect()
      if not spell_name_menu.cancelled then
       select case spell_name_menu.selected
        case 1 'White
         edit_set_name.y = spell_name_menu.y
         edit_set_name.starting_text = white_spellset_name
         edit_set_name.UserType()
         white_spellset_name = Pad(edit_set_name.text, 5,, FF4Text(" "))
         spell_name_menu.ChangeOption(1, white_spellset_name)
        case 2 'Black
         edit_set_name.y = spell_name_menu.y + 1
         edit_set_name.starting_text = black_spellset_name
         edit_set_name.UserType()
         black_spellset_name = Pad(edit_set_name.text, 5,, FF4Text(" "))
         spell_name_menu.ChangeOption(2, black_spellset_name)
        case 3 'Call
         edit_set_name.y = spell_name_menu.y + 2
         edit_set_name.text_width = 4
         edit_set_name.starting_text = call_spellset_name
         edit_set_name.UserType()
         call_spellset_name = Pad(edit_set_name.text, 4,, FF4Text(" "))
         spell_name_menu.ChangeOption(3, call_spellset_name)
         edit_set_name.text_width = 5
       end select
      end if
     end select
   end if
  end if
 loop until select_job.cancelled

end sub
