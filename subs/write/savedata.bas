sub SaveData(filename as String)

 dim start as UInteger
 dim temp as UByte
 dim rewards as UByte

 'Write the memory objects to the ROM image
 
 'Save item ranges
 SaveItemRanges()

 for i as Integer = 1 to total_element_grids
  elementgrids(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_equip_charts
  equipcharts(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_shops
  shops(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_weapons
  weapons(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_armors
  armors(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_medicines
  medicines(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_tools
  tools(i).WriteToROM(i)
 next
 
 WriteByte(&h14D9C, total_player_spells + 1)
 WriteByte(&h14DA1, total_player_spells + 1)
 WriteByte(&h12743, total_player_spells + 1)
 start = &h8906 + total_player_spells * 6
 WriteByte(&h14DB0, start mod &h100)
 WriteByte(&h14DB1, start \ &h100)
 for i as Integer = total_spells to 1 step -1
  spells(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_commands
  menucommands(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_jobs
  jobs(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_characters - 1
  characters(i).WriteToROM(i)
 next

 for i as Integer = 1 to total_actors
  actors(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_npcs
  npcs(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_maps
  placement_groups(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_tilesets
  tilesets(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_maps
  if i < 252 or i > 256 then maps(i).WriteToROM(i)
 next
 SaveMapGrids()
 
 for i as Integer = 1 to total_stat_groups
  stat_groups(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_speed_groups
  speed_groups(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_special_sizes
  special_sizes(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_item_drops
  item_drops(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_monsters
  monsters(i).WriteToROM(i)
 next
 
 temp = 0
 rewards = 0
 for i as Integer = 1 to total_formations
  formations(i).WriteToROM(i)
  if temp < 6 and formations(i).battle_music = 4 then
   WriteByte(&hA0069 + temp * 2, (i - 1) mod &h100)
   WriteByte(&hA0069 + temp * 2 + 1, (i - 1) \ &h100)
   temp += 1
  end if
  if rewards < 12 and formations(i).rewards = false then
   WriteByte(&h9FF00 + rewards * 2, (i - 1) mod &h100)
   WriteByte(&h9FF00 + rewards * 2 + 1, (i - 1) \ &h100)
   rewards += 1
  end if
 next
 for i as Integer = temp to 5
  WriteByte(&hA0069 + i * 2, 0)
  WriteByte(&hA0069 + i * 2 + 1, 2)
 next
 for i as Integer = rewards to 11
  WriteByte(&h9FF00 + i * 2, 0)
  WriteByte(&h9FF00 + i * 2 + 1, 2)
 next
  
 for i as Integer = 1 to total_autobattles
  autobattles(i).WriteToROM(i)
 next
 
 for i as Integer = 1 to total_solobattles
  solobattles(i).WriteToROM(i)
 next
 
 'Write odds and ends
 WriteByte(&h6611, solobattle_actor)
 WriteByte(&h6654, solobattle_actor)
 WriteByte(&h67B8, jobchange_actor)
 WriteByte(&h67BC, jobchange_job)

 'Write character names
 for i as Integer = 1 to total_characters
  for j as Integer = 0 to 5
   WriteByte(&h7A910 + (i - 1) * 6 + j, asc(mid(character_names.ItemAt(i), j + 1, 1)))
  next
 next
 
 'Write encounters
 for i as Integer = 1 to total_encounters
  for j as Integer = 1 to 8
   WriteByte(&h74996 + (i - 1) * 8 + j - 1, encounters(i, j))
  next
 next
 
 'Write map encounter relationships
 for i as Integer = 1 to total_encounter_tables
  WriteByte(&h74742 + i - 1, encounter_tables(i))
 next 
 
 'FF-terminated lists are more complicated to write
 SaveSpellSets()
 SaveEvents()
 SaveEventCalls()
 SaveTriggers()
 SaveLevelups()
 SaveDialogues()
 SaveAIs()
 
 SaveSpellColorNames()
 
 'Write the ROM image to the actual file.
 if not warning then
  open filename for binary access write as #1
   dim temp as String
   temp = ff4rom
   if unheadered then temp = mid(ff4rom, &h200 + 1)
   put #1, , temp
  close #1
 end if
 
end sub
