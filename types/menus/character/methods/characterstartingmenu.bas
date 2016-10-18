constructor CharacterStartingMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 starting_menu = BlueMenu(starting_x, starting_y)

end constructor


sub CharacterStartingMenu.ApplyUpdates(index as UByte)

 characters(index).character_id = character_id
 actors(character_id).load_initial = true
 actors(character_id).load_slot = index - 1
 characters(index).left_handed = left_handed
 characters(index).right_handed = right_handed
 characters(index).sprite = sprite
 characters(index).level = level
 characters(index).max_hp = max_hp
 characters(index).max_mp = max_mp
 for i as Integer = 1 to 5
  characters(index).stat(i) = stat(i)
 next
 characters(index).xp = xp
 characters(index).tnl = tnl
 
end sub


sub CharacterStartingMenu.Display()

 dim temp as String

 starting_menu.ClearAll()
 starting_menu.AddOption(FF4Text("Initial Actor: ") + Pad(actor_names.ItemAt(character_id), actor_names.Width(), , FF4Text(" ")))
 temp = "Handedness:    "
 if left_handed and right_handed then
  temp += "Both   "
 elseif left_handed then
  temp += "Left   "
 elseif right_handed then
  temp += "Right  "
 else
  temp += "Neither"
 end if
 starting_menu.AddOption(FF4Text(temp))
 starting_menu.AddOption(FF4Text("Job:           ") + jobs(sprite + 1).name)
 starting_menu.AddOption(FF4Text("Level:         " + str(level)))
 starting_menu.AddOption(FF4Text("Max HP:        " + str(max_hp)))
 starting_menu.AddOption(FF4Text("Max MP:        " + str(max_mp)))
 for i as Integer = 1 to 5
  starting_menu.AddOption(FF4Text(StatName(i) + ":           " + str(stat(i))))
 next
 starting_menu.AddOption(FF4Text("Experience:    " + str(xp)))
 starting_menu.AddOption(FF4Text("TNL:           " + str(tnl)))

 starting_menu.Display()

end sub


sub CharacterStartingMenu.SetTo(index as UByte)

 character_id = characters(index).character_id
 left_handed = characters(index).left_handed
 right_handed = characters(index).right_handed
 sprite = characters(index).sprite
 level = characters(index).level
 max_hp = characters(index).max_hp
 max_mp = characters(index).max_mp
 for i as Integer = 1 to 5
  stat(i) = characters(index).stat(i)
 next
 xp = characters(index).xp
 tnl = characters(index).tnl

end sub


sub CharacterStartingMenu.UserSelect()

 do
 
  starting_menu.UserSelect()
  
  if not starting_menu.cancelled then
  
   select case starting_menu.selected
   
    case 1 'Initial Actor
     dim actor_select as BlueMenu
     actor_select = BlueMenu(x + 15, y)
     actor_select.max_rows = 1
     for i as Integer = 1 to total_actors
      actor_select.AddOption(actor_names.ItemAt(i))
     next
     actor_select.ChangeSelected(character_id)
     actor_select.UserSelect()
     if not actor_select.cancelled then 
      character_id = actor_select.selected
      Display()
     end if
    
    case 2 'Handedness
     dim handed_menu as BlueMenu
     handed_menu = BlueMenu(x + 15, y + 1)
     handed_menu.max_rows = 1
     handed_menu.AddOption(FF4Text("Neither"))
     handed_menu.AddOption(FF4Text("Left"))
     handed_menu.AddOption(FF4Text("Right"))
     handed_menu.AddOption(FF4Text("Both"))
     if left_handed and right_handed then
      handed_menu.ChangeSelected(4)
     elseif right_handed then
      handed_menu.ChangeSelected(3)
     elseif left_handed then
      handed_menu.ChangeSelected(2)
     end if
     handed_menu.UserSelect()
     if not handed_menu.cancelled then
      select case handed_menu.selected
       case 1
        left_handed = false
        right_handed = false
       case 2
        left_handed = true
        right_handed = false
       case 3
        left_handed = false
        right_handed = true
       case 4
        left_handed = true
        right_handed = true
      end select
      Display()
     end if
        
    case 3 'Job
     dim job_menu as BlueMenu
     job_menu = BlueMenu(x + 15, y + 2)
     for i as Integer = 1 to total_jobs
      job_menu.AddOption(jobs(i).name)
     next
     job_menu.max_rows = 1
     job_menu.ChangeSelected(sprite + 1)
     job_menu.UserSelect()
     if not job_menu.cancelled then
      sprite = job_menu.selected - 1
      Display()
     end if
    
    case 4 'Level
     dim level_input as BlueNumberInput
     level_input = BlueNumberInput(x + 15, y + 3)
     level_input.starting_number = level
     level_input.min_value = 1
     level_input.max_value = 99
     level_input.UserSelect()
     level = level_input.number
     Display()
    
    case 5 'Max HP
     dim hp_input as BlueNumberInput
     hp_input = BlueNumberInput(x + 15, y + 4)
     hp_input.starting_number = max_hp
     hp_input.max_value = 9999
     hp_input.UserSelect()
     max_hp = hp_input.number
     Display()
    
    case 6 'Max MP
     dim mp_input as BlueNumberInput
     mp_input = BlueNumberInput(x + 15, y + 5)
     mp_input.starting_number = max_mp
     mp_input.max_value = 999
     mp_input.UserSelect()
     max_mp = mp_input.number
     Display()
    
    case 7 to 11 'Stats
     dim stat_index as UByte
     dim stat_input as BlueNumberInput
     stat_index = starting_menu.selected - 6
     stat_input = BlueNumberInput(x + 15, y + 5 + stat_index)
     stat_input.starting_number = stat(stat_index)
     stat_input.max_value = 99
     stat_input.UserSelect()
     stat(stat_index) = stat_input.number
     Display()
    
    case 12 'Experience
     dim xp_input as BlueNumberInput
     xp_input = BlueNumberInput(x + 15, y + 11)
     xp_input.starting_number = xp
     xp_input.max_value = &h1000000
     xp_input.UserSelect()
     xp = xp_input.number
     Display()
    
    case 13 'TNL
     dim tnl_input as BlueNumberInput
     tnl_input = BlueNumberInput(x + 15, y + 12)
     tnl_input.starting_number = tnl
     tnl_input.max_value = &h1000000
     tnl_input.UserSelect()
     tnl = tnl_input.number
     Display()
   
   end select
  
  end if
  
 loop until starting_menu.cancelled

end sub
