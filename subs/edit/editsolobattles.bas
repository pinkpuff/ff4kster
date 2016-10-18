sub EditSoloBattles()

 dim select_solobattle as BlueMenu
 dim edit_solobattle as BlueMenu
 dim formation_menu as BlueMenu
 dim actor_menu as BlueMenu
 
 for i as Integer = 1 to total_solobattles
  select_solobattle.AddOption(FF4Text("Solobattle " + Pad(str(i), 2, true)))
 next
 
 edit_solobattle.x = select_solobattle.options.Width() + 2
 
 formation_menu.x = edit_solobattle.x + 11
 formation_menu.y = edit_solobattle.y
 formation_menu.max_rows = 1
 for i as Integer = 1 to total_formations
  formation_menu.AddOption(FF4Text(str(i) + " - ") + formations(i).Preview())
 next
 
 actor_menu.x = formation_menu.x
 actor_menu.max_rows = 1
 for i as Integer = 1 to total_actors
  actor_menu.AddOption(actor_names.ItemAt(i))
 next
 
 do
 
  do
   edit_solobattle.ChangeOption(1, FF4Text("Formation: " + str(solobattles(select_solobattle.selected).formation + 1) + " - ") + Pad(formations(solobattles(select_solobattle.selected).formation + 1).Preview(), formation_menu.options.Width(), false, FF4Text(" ")), 15)
   edit_solobattle.ChangeOption(2, FF4Text("Actor:     ") + actor_names.ItemAt(solobattles(select_solobattle.selected).actor), 15)
   edit_solobattle.ChangeOption(3, FF4Text("Non-solo:  ") + Pad(actor_names.ItemAt(solobattle_actor), actor_names.Width(),, FF4Text(" ")), 15)
   edit_solobattle.Display()
  loop until select_solobattle.UserInput()
  
  if not select_solobattle.cancelled then
  
   do
   
    edit_solobattle.UserSelect()
   
    if not edit_solobattle.cancelled then
     
     select case edit_solobattle.selected
    
      case 1 'Formation
       formation_menu.ChangeSelected(solobattles(select_solobattle.selected).formation + 1)
       formation_menu.UserSelect()
       if not formation_menu.cancelled then solobattles(select_solobattle.selected).formation = formation_menu.selected - 1
       
      case 2 'Actor
       actor_menu.y = formation_menu.y + 1
       actor_menu.ChangeSelected(solobattles(select_solobattle.selected).actor)
       actor_menu.UserSelect()
       if not actor_menu.cancelled then solobattles(select_solobattle.selected).actor = actor_menu.selected
       
      case 3 'Non-solo
       actor_menu.y = formation_menu.y + 2
       actor_menu.ChangeSelected(solobattle_actor)
       actor_menu.UserSelect()
       if not actor_menu.cancelled then solobattle_actor = actor_menu.selected
            
     end select
     
     edit_solobattle.ChangeOption(1, FF4Text("Formation: " + str(solobattles(select_solobattle.selected).formation + 1) + " - ") + Pad(formations(solobattles(select_solobattle.selected).formation + 1).Preview(), formation_menu.options.Width(), false, FF4Text(" ")), 15)
     edit_solobattle.ChangeOption(2, FF4Text("Actor:     ") + actor_names.ItemAt(solobattles(select_solobattle.selected).actor), 15)
     edit_solobattle.ChangeOption(3, FF4Text("Non-solo:  ") + Pad(actor_names.ItemAt(solobattle_actor), actor_names.Width(),, FF4Text(" ")), 15)
     edit_solobattle.Display()
    
    end if
    
   loop until edit_solobattle.cancelled
  
  end if
  
 loop until select_solobattle.cancelled
 
end sub
