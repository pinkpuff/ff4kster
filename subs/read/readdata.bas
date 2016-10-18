sub ReadData(filename as String)
 
 'Reads all the relevant objects from the ROM into memory.
 ' filename -- The name of the ROM file from which to read.
 
 dim temp as String
 dim old_path as String
 dim start as UInteger
 
 'Start by reading the bytes from the file into the global string.
 open filename for binary access read as #1
  if err > 0 then 
   print "FILE ACCESS ERROR"
   getkey
   end
  end if
  if lof(1) > 0 then
   ff4rom = String(lof(1), 0)
   get #1, , ff4rom
   if lof(1) = 1048576 then 'it must be unheadered
    ff4rom = String(&h200, 0) + ff4rom 'give it a dummy header
    unheadered = true
   elseif lof(1) <> 1049088 then 'it isn't FF4
    print "FILE SIZE ERROR"
    getkey
    end
   end if
  else
   print "FILE EMPTY"
   getkey
   end
  end if
 close
 
 old_path = curdir
 chdir(system_path)
 
 ifpatch = false
 for i as Integer = 1 to 8
  if ByteAt(&h7F70 + i) <> &hFF then
   ifpatch = true
   exit for
  end if
 next
 
 'Get the font information so boxes and text can be displayed.
 print "Reading game font... ";
 ReadFont()
 print "DONE"
 
 'Read information from config files.
 print "Reading config files... ";
 ReadFontConfig()
 ReadShopNames()
 ReadElementNames()
 ReadRaceNames()
 ReadWeaponAnimationNames()
 ReadWeaponPropertyNames()
 ReadSpellEffects()
 ReadEffects()
 ReadSequences()
 ReadTargetTypes()
 ReadSoundEffects()
 ReadActorNames()
 ReadEventNames()
 ReadMapNames()
 ReadSongNames()
 ReadCharacterLabels()
 ReadNPCSprites()
 ReadNPCNames()
 ReadTilesetNames()
 ReadBattleBGNames()
 ReadMonsterGfxNames()
 ReadMonsterSizeNames()
 ReadFlagNames()
 ReadVisualFX()
 ReadPoseNames()
 ReadStanceNames()
 print "DONE"
 
 chdir(old_path)
 
 'Read element grids
 print "Reading element grids... ";
 for i as Integer = 1 to total_element_grids
  elementgrids(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read equip charts
 print "Reading equip charts... ";
 for i as Integer = 1 to total_equip_charts
  equipcharts(i).ReadFromROM(i)
 next
 print "DONE"
  
 'Read job names
 print "Reading job names... ";
 for i as Integer = 1 to total_jobs
  jobs(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read character names
 print "Reading character names... ";
 for i as Integer = 1 to total_characters
  temp = ""
  for j as Integer = 0 to 5
   temp += chr(ByteAt(&h7A910 + (i - 1) * 6 + j))
  next
  character_names.Append(temp)
 next
 print "DONE"
 
 'Read spell data
 print "Reading spell data... ";
 total_player_spells = ByteAt(&h14D9C) - 1
 for i as Integer = 1 to total_spells
  spells(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read ranges
 print "Reading feature ranges... ";
 ReadItemRanges()
 print "DONE"

 'Read weapon data
 print "Reading weapon data... ";
 for i as Integer = 1 to total_weapons
  weapons(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read armor data
 print "Reading armor data... ";
 for i as Integer = 1 to total_armors
  armors(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read medicine data
 print "Reading medicine data... ";
 for i as Integer = 1 to total_medicines
  medicines(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read tool data
 print "Reading tool data... ";
 for i as Integer = 1 to total_tools
  tools(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read shop data
 print "Reading shop data... ";
 for i as Integer = 1 to total_shops
  shops(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read command data
 print "Reading command data... ";
 for i as Integer = 1 to total_commands
  menucommands(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read actor data
 print "Reading actor data... ";
 for i as Integer = 1 to total_actors
  actors(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read character data
 print "Reading character data... ";
 for i as Integer = 1 to total_characters - 1
  characters(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read event scripts
 print "Reading event scripts... ";
 for i as Integer = 1 to total_events
  events(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read tilesets
 print "Reading tilesets... ";
 spritesheets(1).bpp = 4
 spritesheets(1).offset = &hADE00  'Airship / Ship
 spritesheets(1).animated_offset = &hFBBC0
 spritesheets(2).offset = &hF61A8  'Lunar Core
 spritesheets(2).animated_offset = &hFBBC0
 spritesheets(3).offset = &hF0220  'Sealed Cave
 spritesheets(3).animated_offset = &hFBBC0
 spritesheets(4).offset = &hEEF40  'Castle Exterior
 spritesheets(4).animated_offset = &hFBEC0
 spritesheets(5).offset = &hF1768  'Town
 spritesheets(5).animated_offset = &hFC040
 spritesheets(6).offset = &hF2EC0  'House
 spritesheets(6).animated_offset = &hFC4C0
 spritesheets(7).offset = &hF3AC0  'Castle Interior
 spritesheets(7).animated_offset = &hFC640
 spritesheets(8).offset = &hF51E8  'Crystal Room
 spritesheets(8).animated_offset = &hFCAC0
 spritesheets(9).offset = &hF9700  'Lunar Whale / Tower / Giant
 spritesheets(9).animated_offset = &hFCAC0
 spritesheets(10).offset = &hF8200 'Feymarch
 spritesheets(10).animated_offset = &hFCAC0
 spritesheets(11).offset = &hF61A8 'Lunar Subterrane
 spritesheets(11).animated_offset = &hFCAC0
 spritesheets(12).offset = &hFD408 'Mountain
 spritesheets(12).animated_offset = &hFCF40
 spritesheets(13).offset = &hFEA88 'Cave
 spritesheets(13).animated_offset = &hFCF40
 for i as Integer = 1 to total_spritesheets
  spritesheets(i).ReadFromROM()
 next
 for i as Integer = 0 to 31
  SetPalette(&hA6000, i)
 next
 for i as Integer = 1 to total_tilesets
  tilesets(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read map data
 print "Reading map data... ";
 for i as Integer = 1 to total_maps
  maps(i).ReadFromROM(i)
 next
 ReadMapGrids()
 print "DONE"
 
 'Read npc data
 print "Reading NPC data... ";
 for i as Integer = 1 to total_npcs
  npcs(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read npc placement data
 print "Reading NPC placement data... ";
 for i as Integer = 1 to total_maps
  if i > &h100 then placement_groups(i).underground = true else placement_groups(i).underground = false
  placement_groups(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read item drops
 print "Reading item drops... ";
 for i as Integer = 1 to total_item_drops
  item_drops(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read monster stat groups
 print "Reading monster stat groups... ";
 for i as Integer = 1 to total_stat_groups
  stat_groups(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read monster speed groups
 print "Reading monster speed groups... ";
 for i as Integer = 1 to total_speed_groups
  speed_groups(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read special monster sizes
 print "Reading monster special sizes... ";
 for i as Integer = 1 to total_special_sizes
  special_sizes(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read monsters
 print "Reading monster data... ";
 for i as Integer = 1 to total_monsters
  monsters(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read formations
 print "Reading formation data... ";
 for i as Integer = 1 to total_formations
  formations(i).ReadFromROM(i)
 next
 for i as Integer = 0 to 5
  start = ByteAt(&hA0069 + i * 2) + ByteAt(&hA0069 + i * 2 + 1) * &h100
  if start < total_formations then
   if formations(start + 1).battle_music = 3 then formations(start + 1).battle_music = 4
  end if
 next
 for i as Integer = 0 to 11
  start = ByteAt(&h9FF00 + i * 2) + ByteAt(&h9FF00 + i * 2 + 1) * &h100
  if start < total_formations then
   formations(start + 1).rewards = false
  end if
 next
 print "DONE"
 
 'Read autobattles
 print "Reading autobattles... ";
 for i as Integer = 1 to total_autobattles
  autobattles(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read solobattles
 print "Reading solobattles... ";
 for i as Integer = 1 to total_solobattles
  solobattles(i).ReadFromROM(i)
 next
 print "DONE"
 
 'Read odds and ends
 print "Reading odds and ends... ";
 solobattle_actor = ByteAt(&h6611)
 jobchange_actor = ByteAt(&h67B8)
 jobchange_job = ByteAt(&h67BC)
 print "DONE"
 
 print "Reading monster palette data... ";
 ReadMonsterPalettes()
 print "DONE"
 
 'Read dynamically sized lists
 print "Reading dynamically sized lists... ";
 ReadSpellSets()
 ReadDialogues()
 ReadLevelups()
 ReadEventCalls()
 ReadTriggers()
 ReadAIs()
 print "DONE"

 'Construct item name list
 print "Constructing item name list... ";
 item_names.Assign(1, FF4Text(Pad("No weapon", 9)))
 for i as Integer = 1 to total_weapons
  item_names.Assign(i + 1, weapons(i).name)
 next
 item_names.Assign(total_weapons + 2, FF4Text(Pad("No armor", 9)))
 for i as Integer = 1 to total_armors
  item_names.Assign(i + total_weapons + 2, armors(i).name)
 next
 for i as Integer = 1 to total_medicines
  item_names.Assign(i + total_weapons + total_armors + 2, medicines(i).name)
 next
 for i as Integer = 1 to total_tools
  item_names.Assign(i + total_weapons + total_armors + total_medicines + 2, tools(i).name)
 next
 print "DONE"
 
 'Temporary formation name list
 for i as Integer = 1 to total_formations
  formation_names.Append(FF4Text("Formation " + Pad(str(i), 3, true)))
 next
 
 'Read encounters
 print "Reading encounters... ";
 for i as Integer = 1 to total_encounters
  for j as Integer = 1 to 8
   encounters(i, j) = ByteAt(&h74996 + (i - 1) * 8 + j - 1)
  next
 next
 print "DONE"
 
 'Read map encounter relationships
 print "Reading map encounter relationships... ";
 for i as Integer = 1 to total_encounter_tables
  encounter_tables(i) = ByteAt(&h74742 + i - 1)
 next
 print "DONE"
 
 print "Applying finishing touches... ";
 FlagMoonCreatures()
 SetEventMapLinks()
 'print "OK"
 'getkey
 'end
 ReadSpellColorNames()
 print "DONE"
 
end sub
