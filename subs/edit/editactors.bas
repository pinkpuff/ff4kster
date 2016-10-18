sub EditActors()

 dim select_actor as BlueMenu
 dim edit_actor as BlueMenu
 dim command_menu as CommandMenu
 dim equipment_menu as EquipmentMenu
 dim data_menu as ShadowDataMenu
 dim name_menu as BlueMenu
 dim rename_input as BlueTextInput
 dim special_name as BlueTextInput
 dim special_actor as BlueMenu
 dim job_menu as BlueMenu
 dim blank as Any ptr
 
 blank = ImageCreate(640, 480, RGB(0, 0 ,0))

 for i as Integer = 1 to total_actors
  select_actor.AddOption(actor_names.ItemAt(i))
 next
 
 edit_actor.AddOption(FF4Text("Edit Commands"))
 edit_actor.AddOption(FF4Text("Edit Equipment"))
 edit_actor.AddOption(FF4Text("Edit Load/Save"))
 edit_actor.AddOption(FF4Text("Edit Name"))
 edit_actor.AddOption(FF4Text("Edit Special Set"))
 edit_actor.AddOption(FF4Text("Edit Job Change"))
 edit_actor.x = 78 - edit_actor.options.Width()
 
 command_menu = CommandMenu(select_actor.options.Width() + 2)
 equipment_menu = EquipmentMenu(select_actor.options.Width() + 9)
 data_menu = ShadowDataMenu(select_actor.options.Width() + 2, 7)
 
 special_name.x = data_menu.x + 19
 special_name.y = 12
 special_name.text_width = 5
 
 special_actor.x = special_name.x + 10
 special_actor.y = special_name.y
 special_actor.max_rows = 1
 for i as Integer = 1 to total_actors
  special_actor.AddOption(actor_names.ItemAt(i))
 next
 
 job_menu.x = data_menu.x + actor_names.Width() + 14
 job_menu.y = special_name.y + 3
 job_menu.max_rows = 1
 for i as Integer = 1 to total_jobs
  job_menu.AddOption(jobs(i).name)
 next
 
 for i as Integer = 1 to total_characters
  name_menu.AddOption(character_names.ItemAt(i))
 next
 
 'name_menu.max_rows = 1
 name_menu.x = data_menu.x
 name_menu.y = job_menu.y + 3
 
 rename_input.x = name_menu.x + name_menu.options.Width() + 2
 rename_input.y = name_menu.y
 rename_input.text_width = 6
 rename_input.cursor = true
 
 do
  
  do
  
   command_menu.SetTo(select_actor.selected)
   equipment_menu.SetTo(select_actor.selected)
   data_menu.SetTo(select_actor.selected)
   
   command_menu.Display()
   equipment_menu.Display()
   data_menu.Display()
   'name_menu.Display()
   
   BlueBox(name_menu.x, name_menu.y, name_menu.options.Width(), 1)
   WriteText(character_names.ItemAt(actors(select_actor.selected).name_index + 1), name_menu.x + 1, name_menu.y + 1)
   
   BlueBox(data_menu.x, special_name.y, actor_names.Width() + 24, 1)
   WriteText(FF4Text("Replace ") + black_spellset_name + FF4Text(" with ") + special_spellset_name + FF4Text(" for ") + actor_names.ItemAt(special_spellset_actor), data_menu.x + 1, special_name.y + 1)
   
   BlueBox(data_menu.x, job_menu.y, actor_names.Width() + 33, 1)
   WriteText(FF4Text("Change ") + actor_names.ItemAt(jobchange_actor) + FF4Text("'s job to ") + jobs(jobchange_job + 1).name + FF4Text(" upon return"), data_menu.x + 1, job_menu.y + 1)
  
  loop until select_actor.UserInput()
  
  if not select_actor.cancelled then
  
   edit_actor.UserSelect()
   
   if not edit_actor.cancelled then
    
    select case edit_actor.selected
    
     case 1 'Edit commands
      command_menu.UserSelect()
      for i as Integer = 1 to 5
       actors(select_actor.selected).menu_command(i) = command_menu.menu_command(i)
      next
      
     case 2 'Edit equipment
      equipment_menu.UserSelect()
      for i as Integer = 1 to 5
       actors(select_actor.selected).starting_gear(i) = equipment_menu.starting_gear(i)
      next
      actors(select_actor.selected).right_ammo = equipment_menu.right_ammo
      actors(select_actor.selected).left_ammo = equipment_menu.left_ammo
      
     case 3 'Edit load/save
      data_menu.UserSelect()
      actors(select_actor.selected).load_initial = data_menu.load_initial
      actors(select_actor.selected).load_slot = data_menu.load_slot
      actors(select_actor.selected).store_shadow = data_menu.save_shadow
      actors(select_actor.selected).store_slot = data_menu.save_slot
      if actors(select_actor.selected).load_initial then
       characters(actors(select_actor.selected).load_slot + 1).character_id = select_actor.selected
      end if
      actors(select_actor.selected).level_link = data_menu.level_link
      
     case 4 'Edit name
      name_menu.ChangeSelected(actors(select_actor.selected).name_index + 1)
      name_menu.UserSelect()
      if not name_menu.cancelled then
       actors(select_actor.selected).name_index = name_menu.selected - 1
       rename_input.starting_text = character_names.ItemAt(name_menu.selected)
       BlueBox(name_menu.x, name_menu.y, name_menu.options.Width(), 1)
       WriteText(character_names.ItemAt(actors(select_actor.selected).name_index + 1), name_menu.x + 1, name_menu.y + 1)
       rename_input.UserType()
       character_names.Assign(name_menu.selected, Pad(rename_input.text, 6,, FF4Text(" ")))
       name_menu.ChangeOption(name_menu.selected, character_names.ItemAt(name_menu.selected))
      end if
      put (name_menu.x * 8, name_menu.y * 8), blank, pset
      
     case 5 'Edit special set
      special_name.starting_text = special_spellset_name
      special_name.UserType()
      special_spellset_name = Pad(special_name.text, 5,, FF4Text(" "))
      special_name.Display()
      special_actor.x = special_name.x + 10
      special_actor.y = special_name.y
      special_actor.ChangeSelected(special_spellset_actor)
      special_actor.UserSelect()
      if not special_actor.cancelled then special_spellset_actor = special_actor.selected
      
     case 6 'Edit jobchange actor
      special_actor.x = data_menu.x + 7
      special_actor.y = job_menu.y
      special_actor.ChangeSelected(jobchange_actor)
      special_actor.UserSelect()
      if not special_actor.cancelled then jobchange_actor = special_actor.selected
      job_menu.ChangeSelected(jobchange_job + 1)
      job_menu.UserSelect()
      if not job_menu.selected then jobchange_job = job_menu.selected - 1
    
    end select
    
   end if
  
  end if
  
 loop until select_actor.cancelled

end sub
