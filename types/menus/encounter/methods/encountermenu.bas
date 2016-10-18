constructor EncounterMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 main_menu = BlueMenu(x, y)
 encounter_menu = BlueMenu(x, y + 3)
 
 battle_percentages(1) = 43
 battle_percentages(2) = 43
 battle_percentages(3) = 43
 battle_percentages(4) = 43
 battle_percentages(5) = 32
 battle_percentages(6) = 32
 battle_percentages(7) = 16
 battle_percentages(8) = 4

end constructor


sub EncounterMenu.Display()

 main_menu.ChangeOption(1, FF4Text("Encounter: " + Pad(str(encounter_tables(index)), 2, true)), 15)
 UpdateEncounter(encounter_tables(index)) 
 main_menu.Display()
 encounter_menu.Display()

end sub


sub EncounterMenu.SetTo(new_index as UInteger)

 index = new_index
 if index > 64 + 16 + 4 then inside = 16 else inside = 0
 if index > 64 + 16 + 4 + &h100 or index <= 64 + 16 + 4 and index > 64 then underground = &h100 else underground = 0

end sub


sub EncounterMenu.UpdateEncounter(e as UInteger)

 dim temp as String
 
 for i as Integer = 1 to 8
  temp = FF4Text(str(i) + ": ") + formation_names.ItemAt(encounters(e + inside + 1, i) + underground + 1) + FF4Text(" -- ")
  for j as Integer = 1 to 3
   if formations(encounters(e + inside + 1, i) + underground + 1).monster_type(j) + 1 <= total_monsters then
    temp += FF4Text(str(formations(encounters(e + inside + 1, i) + underground + 1).monster_qty(j)) + " ")
    temp += monsters(formations(encounters(e + inside + 1, i) + underground + 1).monster_type(j) + 1).name
    temp += FF4Text("  ")
   else
    temp += FF4Text(space(12))
   end if
  next
  temp += FF4Text(Pad(str(battle_percentages(i)), 2, true) + "/256 " + Pad(str(battle_percentages(i) * 100 \ 256), 2, true) + "%")
  encounter_menu.ChangeOption(i, temp, 15)
 next

end sub


sub EncounterMenu.UserSelect()

 dim old_index as UInteger
 dim enter_index as BlueNumberInput
 dim select_formation as BlueMenu
 dim temp as String
 dim total as UInteger
 
 old_index = index
 
 enter_index = BlueNumberInput(x + 11, y)
 if inside then
  enter_index.max_value = total_encounters - 16
 else
  enter_index.max_value = 15
 end if
 enter_index.starting_number = encounter_tables(index)
 enter_index.number = enter_index.starting_number
 
 select_formation.x = encounter_menu.x + 3
 select_formation.max_rows = 1
 for i as Integer = 1 + underground to 256 + underground
  temp = formation_names.ItemAt(i) + FF4Text(" -- ")
  for j as Integer = 1 to 3
   if formations(i).monster_type(j) <= total_monsters then
    temp += FF4Text(str(formations(i).monster_qty(j)) + " ") + monsters(formations(i).monster_type(j) + 1).name + FF4Text("  ")
   else
    temp += space(12)
   end if
  next
  select_formation.AddOption(temp)
 next
 
 do until enter_index.UserInput()
  UpdateEncounter(enter_index.number)
  if enter_index.number > 0 then
   encounter_menu.Display()
  else
   encounter_menu.Hide()
  end if
 loop
 
 encounter_tables(index) = enter_index.number
 
 do
 
  encounter_menu.UserSelect()
  
  if not encounter_menu.cancelled then
  
   select_formation.y = encounter_menu.y + encounter_menu.selected - 1
   select_formation.ChangeSelected(encounters(encounter_tables(index) + inside + 1, encounter_menu.selected) + 1)
   select_formation.UserSelect()
   if not select_formation.cancelled then
    encounters(encounter_tables(index) + inside + 1, encounter_menu.selected) = select_formation.selected - 1
   end if
   
   Display()
  
  end if
 
 loop until encounter_menu.cancelled

end sub
