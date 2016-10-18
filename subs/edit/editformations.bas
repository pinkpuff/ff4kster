sub EditFormations()

 dim select_formation as BlueMenu
 dim edit_formation as FormationInfoMenu
 dim temp as String
 
 select_formation.max_rows = screen_height
 for i as Integer = 1 to total_formations
  select_formation.AddOption(formation_names.ItemAt(i))
 next
 
 edit_formation = FormationInfoMenu(select_formation.options.Width() + 2)
 
 do
 
  do
   edit_formation.SetTo(select_formation.selected)
   edit_formation.Display()
  loop until select_formation.UserInput()
  
  if not select_formation.cancelled then edit_formation.UserSelect()
  
 loop until select_formation.cancelled

end sub
