sub EditEncounters()

 dim select_map as BlueMenu
 dim edit_encounter as EncounterMenu
 
 select_map.max_rows = 10
 
 for i as Integer = 1 to 64
  select_map.AddOption(FF4Text("Overworld section " + str(i) + "/64"))
 next
 
 for i as Integer = 1 to 16
  select_map.AddOption(FF4Text("Underground section " + str(i) + "/16"))
 next
 
 for i as Integer = 1 to 4
  select_map.AddOption(FF4Text(Pad("Moon section " + str(i) + "/4", screen_width - 2)))
 next
 
 for i as Integer = 1 to total_maps
  select_map.AddOption(map_names.ItemAt(i))
 next
 
 edit_encounter = EncounterMenu(0, select_map.max_rows + 2)
 
 do
 
  do
   edit_encounter.SetTo(select_map.selected)
   edit_encounter.Display()
  loop until select_map.UserInput()
  
  if not select_map.cancelled then

   edit_encounter.UserSelect()
  
  end if
  
 loop until select_map.cancelled
 
 FlagMoonCreatures()

end sub
