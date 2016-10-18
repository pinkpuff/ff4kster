constructor ScriptEntryMenu(starting_x as UByte = 0, starting_y as UByte = 0)
 
 x = starting_x
 y = starting_y

 blank = ImageCreate(640, 480, RGB(0, 0, 0))
 
 main_menu = BlueMenu(x, y)
 main_menu.max_rows = 1
 main_menu.AddOption(FF4Text("Character movement"))
 main_menu.AddOption(FF4Text("Toggle screen shake"))
 main_menu.AddOption(FF4Text("Screen flash"))
 main_menu.AddOption(FF4Text("Screen blur and unblur"))
 main_menu.AddOption(FF4Text("Travel to/from moon"))
 main_menu.AddOption(FF4Text("Open fat chocobo screen"))
 main_menu.AddOption(FF4Text("Open a door"))
 main_menu.AddOption(FF4Text("Screen moves up and down one tile"))
 main_menu.AddOption(FF4Text("Toggle running"))
 main_menu.AddOption(FF4Text("Toggle music fade"))
 main_menu.AddOption(FF4Text("Open namingway screen"))
 main_menu.AddOption(FF4Text("Toggle screen fade"))
 main_menu.AddOption(FF4Text("Toggle statuses"))
 main_menu.AddOption(FF4Text("Inn"))
 main_menu.AddOption(FF4Text("Change character graphic"))
 main_menu.AddOption(FF4Text("Restore HP"))
 main_menu.AddOption(FF4Text("Restore MP"))
 main_menu.AddOption(FF4Text("Add item to inventory"))
 main_menu.AddOption(FF4Text("Remove item from inventory"))
 main_menu.AddOption(FF4Text("Add spell to spell set"))
 main_menu.AddOption(FF4Text("Remove statuses"))
 main_menu.AddOption(FF4Text("Add statuses"))
 main_menu.AddOption(FF4Text("Add 100x Gil"))
 main_menu.AddOption(FF4Text("Subtract 100x Gil"))
 main_menu.AddOption(FF4Text("Add actor to party"))
 main_menu.AddOption(FF4Text("Remove actor from party"))
 main_menu.AddOption(FF4Text("Pause"))
 main_menu.AddOption(FF4Text("Fade in song"))
 main_menu.AddOption(FF4Text("Simultaneously do the next actions"))
 main_menu.AddOption(FF4Text("Fight battle"))
 main_menu.AddOption(FF4Text("Shop"))
 main_menu.AddOption(FF4Text("Show message following event call"))
 main_menu.AddOption(FF4Text("Show message starting from map pointer"))
 main_menu.AddOption(FF4Text("Show message from lower half of bank 1"))
 main_menu.AddOption(FF4Text("Show message from upper half of bank 1"))
 main_menu.AddOption(FF4Text("Set event flag"))
 main_menu.AddOption(FF4Text("Clear event flag"))
 main_menu.AddOption(FF4Text("Activate NPC"))
 main_menu.AddOption(FF4Text("Deactivate NPC"))
 main_menu.AddOption(FF4Text("Show message from bank 3"))
 main_menu.AddOption(FF4Text("Item selection window"))
 main_menu.AddOption(FF4Text("Show message from bank 1 with Yes/No box"))
 main_menu.AddOption(FF4Text("Toggle screen tint"))
 main_menu.AddOption(FF4Text("Play song"))
 main_menu.AddOption(FF4Text("Play sound effect"))
 main_menu.AddOption(FF4Text(iif(ifpatch, "Do the next actions based on flag", "Crash game")))
 main_menu.AddOption(FF4Text("Play visual effect"))
 main_menu.AddOption(FF4Text("Load map"))
 
 character_movement_menu = BlueMenu(x, main_menu.y + 6)
 character_movement_menu.max_rows = 1
 character_movement_menu.AddOption(FF4Text("Move up"))
 character_movement_menu.AddOption(FF4Text("Move right"))
 character_movement_menu.AddOption(FF4Text("Move down"))
 character_movement_menu.AddOption(FF4Text("Move left"))
 character_movement_menu.AddOption(FF4Text("Face up"))
 character_movement_menu.AddOption(FF4Text("Face right"))
 character_movement_menu.AddOption(FF4Text("Face down"))
 character_movement_menu.AddOption(FF4Text("Face left"))
 character_movement_menu.AddOption(FF4Text("Toggle visibility"))
 character_movement_menu.AddOption(FF4Text("Jump sideways"))
 character_movement_menu.AddOption(FF4Text("Spin"))
 character_movement_menu.AddOption(FF4Text("Spin-jump"))
 character_movement_menu.AddOption(FF4Text("Wave in"))
 character_movement_menu.AddOption(FF4Text("Wave out"))
 character_movement_menu.AddOption(FF4Text("Bow head"))
 character_movement_menu.AddOption(FF4Text("Lie down"))
 
 character_menu = BlueMenu(x, main_menu.y + 3)
 character_menu.max_rows = 1
 for i as Integer = 1 to 12
  character_menu.AddOption(FF4Text("Placement " + str(i)))
 next
 character_menu.AddOption(FF4Text("You"))
 
 enter_xx = BlueNumberInput(x, main_menu.y + 3)
 enter_xx.min_value = 0
 enter_xx.max_value = 255
 
 enter_yy = BlueNumberInput(x, main_menu.y + 6)
 enter_yy.min_value = 0
 enter_yy.max_value = 255
 
 status_menu = BlueMenu(x, main_menu.y + 3)
 for i as Integer = 9 to 16
  status_menu.AddOption(element_names.ItemAt(i), 0)
 next
 
 item_menu = BlueMenu(x, main_menu.y + 3)
 item_menu.max_rows = 1
 for i as Integer = 1 to total_items
  item_menu.AddOption(item_names.ItemAt(i))
 next
 
 spell_menu = BlueMenu(x, main_menu.y + 3)
 spell_menu.max_rows = 1
 for i as Integer = 1 to total_spells
  spell_menu.AddOption(spells(i - 1).name)
 next
 
 spellset_menu = BlueMenu(x + spell_menu.options.Width() + 2, main_menu.y + 3)
 spellset_menu.max_rows = 1
 for i as Integer = 1 to spellsets.Length()
  spellset_menu.AddOption(spellset_names.ItemAt(i))
 next
 
 actor_menu = BlueMenu(x, main_menu.y + 3)
 actor_menu.max_rows = 1
 for i as Integer = 1 to total_actors
  actor_menu.AddOption(actor_names.ItemAt(i))
 next
 
 song_menu = BlueMenu(x, main_menu.y + 3)
 song_menu.max_rows = 1
 for i as Integer = 1 to total_songs
  song_menu.AddOption(song_names.ItemAt(i))
 next
 
 sfx_menu = BlueMenu(x, main_menu.y + 3)
 sfx_menu.max_rows = 1
 for i as Integer = 1 to total_sound_effects
  sfx_menu.AddOption(sound_effects.ItemAt(i))
 next
 
 formation_menu = BlueMenu(x, main_menu.y + 3)
 formation_menu.max_rows = 1
 for i as Integer = 1 to 512
  formation_menu.AddOption(FF4Text(str(i) + ": ") + formations(i).Preview())
 next
 
 shop_menu = BlueMenu(x, main_menu.y + 3)
 shop_menu.max_rows = 1
 for i as Integer = 1 to total_shops
  shop_menu.AddOption(shop_names.ItemAt(i))
 next
 
 flag_menu = BlueMenu(x, main_menu.y + 3)
 flag_menu.max_rows = 1
 for i as Integer = 1 to 256
  flag_menu.AddOption(flag_names.ItemAt(i))
 next
 
 onoff_menu = BlueMenu(x + flag_menu.options.Width() + 2, main_menu.y + 3)
 onoff_menu.max_rows = 1
 onoff_menu.AddOption(FF4Text("ON "))
 onoff_menu.AddOption(FF4Text("OFF"))
 
 npc_menu = BlueMenu(x, main_menu.y + 3)
 npc_menu.max_rows = 1
 for i as Integer = 1 to total_npcs
  npc_menu.AddOption(npc_names.ItemAt(i))
 next
 
 message_menu = BlueMenu(x, main_menu.y + 3)
 message_menu.max_rows = 1
 for i as Integer = 1 to total_dialogues_bank1
  message_menu.AddOption(FF4Text("Message " + str(i)))
 next
 
 vfx_menu = BlueMenu(x, main_menu.y + 3)
 vfx_menu.max_rows = 1
 for i as Integer = 1 to 256
  vfx_menu.AddOption(vfx.ItemAt(i))
 next
 
 map_menu = BlueMenu(x, main_menu.y + 9)
 map_menu.max_rows = 1
 for i as Integer = 1 to total_maps
  map_menu.AddOption(map_names.ItemAt(i))
 next
 
 properties_menu = BlueMenu(x, main_menu.y + 12)
 properties_menu.AddOption(FF4Text("Load map without pixelation transition"))
 properties_menu.AddOption(FF4Text("For airships, don't use the dust entrance or take-off animations"))
 'properties_menu.AddOption(FF4Text("Underground/Moon"))

 vehicle_menu = BlueMenu(x, main_menu.y + 16)
 vehicle_menu.AddOption(FF4Text("No vehicle"))
 vehicle_menu.AddOption(FF4Text("Yellow chocobo"))
 vehicle_menu.AddOption(FF4Text("Black chocobo"))
 vehicle_menu.AddOption(FF4Text("Hovercraft"))
 vehicle_menu.AddOption(FF4Text("Enterprise"))
 vehicle_menu.AddOption(FF4Text("Falcon"))
 vehicle_menu.AddOption(FF4Text("Lunar Whale"))
 vehicle_menu.AddOption(FF4Text("Ship"))
 
end constructor


function ScriptEntryMenu.Entry() as String

 dim result as String
 
 result = chr(function_call)
 if ParameterCount(function_call) >= 1 then result += chr(xx)
 if ParameterCount(function_call) >= 2 then result += chr(yy)
 if ParameterCount(function_call) >= 3 then result += chr(zz)
 if ParameterCount(function_call) >= 4 then result += chr(ww)
 
 return result

end function


sub ScriptEntryMenu.Display()

 dim p as Placement ptr
 dim temp as Integer
 
 put (main_menu.x * 8, main_menu.y * 8), blank, pset
 main_menu.Display()

 select case main_menu.selected

  case 1
   character_movement_menu.Display()
   character_menu.Display()
   if character_menu.selected <= placement_groups(map_link).placements.Length() then
    BlueBox(character_menu.options.Width() + 2, character_menu.y, npc_names.Width(), 1)
    p = placement_groups(map_link).placements.PointerAt(character_menu.selected)
    temp = p->npc_index
    if p->underground then temp += &h100
    WriteText(npc_names.ItemAt(temp + 1), character_menu.options.Width() + 3, character_menu.y + 1)
   elseif character_menu.selected < 13 then
    BlueBox(character_menu.options.Width() + 2, character_menu.y, npc_names.Width(), 1)
    WriteText(FF4Text("-N/A-"), character_menu.options.Width() + 3, character_menu.y + 1)
   end if

  case 13, 21, 22
   status_menu.Display()
  
  case 14 to 17, 23, 24, 27, 43
   enter_xx.Display()
   
  case 18, 19, 41
   item_menu.Display()
  
  case 20
   spell_menu.Display()
   spellset_menu.Display()
   
  case 25, 26
   actor_menu.Display()
   
  case 28, 44
   song_menu.Display()
  
  case 29
   enter_xx.Display()
   enter_yy.Display()
   BlueBox(enter_xx.x + len(str(enter_xx.max_value)) + 2, enter_xx.y, 7, 1)
   WriteText(FF4Text("Times"), enter_xx.x + len(str(enter_xx.max_value)) + 3, enter_xx.y + 1)
   BlueBox(enter_yy.x + len(str(enter_yy.max_value)) + 2, enter_yy.y, 7, 1)
   WriteText(FF4Text("Actions"), enter_yy.x + len(str(enter_yy.max_value)) + 3, enter_yy.y + 1)
  
  case 30
   if map_link > 256 then
    formation_menu.ChangeSelected((((formation_menu.selected - 1) mod &h100) + 1) + &h100)
   else
    formation_menu.ChangeSelected(((formation_menu.selected - 1) mod &h100) + 1)
   end if
   formation_menu.Display()
   
  case 31
   shop_menu.Display()
   
  case 32
   message_menu.Display()
   
  case 33
   message_menu.Display()
   if xx + 1 <= maps(map_link).dialogues.Length() then
    DisplayDialogue(x + message_menu.options.Width() + 2, y + 3, maps(map_link).dialogues.ItemAt(xx + 1), 5)
   end if
   
  case 34
   message_menu.Display()
   DisplayDialogue(x + message_menu.options.Width() + 2, y + 3, dialogues_bank1.ItemAt(xx + 1), 5)

  case 35, 42
   message_menu.Display()
   DisplayDialogue(x + message_menu.options.Width() + 2, y + 3, dialogues_bank1.ItemAt(xx + 1 + &h100), 5)
   
  case 36, 37
   flag_menu.Display()
   
  case 38, 39
   if map_link > 256 then
    npc_menu.ChangeSelected((((npc_menu.selected - 1) mod &h100) + 1) + &h100)
   else
    npc_menu.ChangeSelected(((npc_menu.selected - 1) mod &h100) + 1)
   end if
   npc_menu.Display()
   
  case 40
   message_menu.Display()
   DisplayDialogue(x + message_menu.options.Width() + 2, y + 3, dialogues_bank3.ItemAt(xx + 1), 5)
   
  case 45
   sfx_menu.Display()
   
  case 46
   if ifpatch then
    flag_menu.Display()
    onoff_menu.Display()
    enter_yy.Display()
    BlueBox(enter_yy.x + len(str(enter_yy.max_value)) + 2, enter_yy.y, 7, 1)
    WriteText(FF4Text("Actions"), enter_yy.x + len(str(enter_yy.max_value)) + 3, enter_yy.y + 1)
   else
    enter_xx.Display()
   end if
   
  case 47
   vfx_menu.Display()
   
  case 48
   enter_xx.Display()
   enter_yy.Display()
   map_menu.Display()
   properties_menu.Display()
   for i as Integer = 1 to vehicle_menu.options.Length()
    if i <> vehicle_menu.selected then 
     vehicle_menu.ChangeOption(i,, 0)
    else
     vehicle_menu.ChangeOption(i,, 15)
    end if
   next
   vehicle_menu.Display()
   BlueBox(enter_xx.x + 5, enter_xx.y, 1, 1)
   WriteText(FF4Text("X"), enter_yy.x + 6, enter_xx.y + 1)
   BlueBox(enter_yy.x + 5, enter_yy.y, 1, 1)
   WriteText(FF4Text("Y"), enter_yy.x + 6, enter_yy.y + 1)
   
 end select

end sub


sub ScriptEntryMenu.SetFunctionType()

 dim underground as Integer
 dim temp as Integer
 
 if map_link > 256 then underground = &h100 else underground = 0

 if function_call < &hD0 then
  main_menu.ChangeSelected(1) 
 else
  main_menu.ChangeSelected(function_call - &hD0 + 2)
 end if

 select case main_menu.selected
  case 1
   character_menu.ChangeSelected((function_call \ &h10) + 1)
   character_movement_menu.ChangeSelected((function_call mod &h10) + 1)
   if function_call \ &h10 = &hC then
    character_movement_menu.ChangeOption(9, FF4Text("Become invisible "))
    character_movement_menu.ChangeOption(10, FF4Text("Become visible"))
    character_movement_menu.ChangeOption(11, FF4Text("Wave in"))
    character_movement_menu.ChangeOption(12, FF4Text("Wave out"))
    character_movement_menu.ChangeOption(13, FF4Text("Bow head"))
    character_movement_menu.ChangeOption(14, FF4Text("Lie down"))
    character_movement_menu.ChangeOption(15, FF4Text("Toggle turning"))
    character_movement_menu.ChangeOption(16, FF4Text("Toggle spinning"))
   else
    character_movement_menu.ChangeOption(9, FF4Text("Toggle visibility"))
    character_movement_menu.ChangeOption(10, FF4Text("Jump sideways"))
    character_movement_menu.ChangeOption(11, FF4Text("Spin"))
    character_movement_menu.ChangeOption(12, FF4Text("Spin-jump"))
    character_movement_menu.ChangeOption(13, FF4Text("Wave in"))
    character_movement_menu.ChangeOption(14, FF4Text("Wave out"))
    character_movement_menu.ChangeOption(15, FF4Text("Bow head"))
    character_movement_menu.ChangeOption(16, FF4Text("Lie down"))
   end if
  case 13, 21, 22
   for i as Integer = 0 to 7
    if xx and 2^i then status_menu.ChangeOption(i + 1,, 14) else status_menu.ChangeOption(i + 1,, 0)
   next
  case 14 to 17, 23, 24, 27, 43
   enter_xx.number = xx
  case 18, 19, 41
   item_menu.ChangeSelected(xx + 1)
  case 20
   spell_menu.ChangeSelected(yy + 1)
   spellset_menu.ChangeSelected(xx + 1)
  case 25, 26
   actor_menu.ChangeSelected(xx)
  case 28, 44
   song_menu.ChangeSelected(xx + 1)
  case 29
   enter_xx.number = xx
   enter_yy.number = yy
  case 30
   formation_menu.ChangeSelected(xx + 1 + underground)
  case 31
   shop_menu.ChangeSelected(xx + 1)
  case 32 to 34
   message_menu.ChangeSelected(xx + 1)
  case 35, 42
   'enter_xx.number = xx
   message_menu.ChangeSelected(xx + &h100 + 1)
  case 36, 37
   flag_menu.ChangeSelected(xx + 1)
  case 38, 39
   npc_menu.ChangeSelected(xx + 1 + underground)
  case 40
   message_menu.ChangeSelected(xx + 1)
  case 45
   sfx_menu.ChangeSelected(xx + 1)
  case 46
   if ifpatch then
    flag_menu.ChangeSelected((xx mod &h80) + 1)
    if xx and &h80 then
     onoff_menu.ChangeSelected(2)
    else
     onoff_menu.ChangeSelected(1)
    end if
    enter_yy.number = yy
   else
    enter_xx.number = xx
   end if
  case 47
   vfx_menu.ChangeSelected(xx + 1)
  case 48
   enter_xx.number = yy
   enter_yy.number = zz
   if (ww and 2^7) and xx + &h101 <= map_menu.options.Length() then 
    map_menu.ChangeSelected(xx + &h101)
   else
    map_menu.ChangeSelected(xx + 1)
   end if
   if ww mod &h20 < 7 then
    vehicle_menu.ChangeSelected((ww mod &h20) + 1)
   else
    vehicle_menu.ChangeSelected(8)
   end if
   for i as Integer = 1 to 2
    if ww and 2^(i + 4) then
     properties_menu.ChangeOption(i,, 14) 
    else
     properties_menu.ChangeOption(i,, 0)
    end if
   next
   
 end select

end sub


sub ScriptEntryMenu.SetTo(new_entry as String, actual_map as UInteger)

 map_link = actual_map
 if map_link > total_maps then map_link -= &h100
 function_call = asc(left(new_entry, 1))
 if ParameterCount(function_call) >= 1 then xx = asc(mid(new_entry, 2, 1)) else xx = 0
 if ParameterCount(function_call) >= 2 then yy = asc(mid(new_entry, 3, 1)) else yy = 0
 if ParameterCount(function_call) >= 3 then zz = asc(mid(new_entry, 4, 1)) else zz = 0
 if ParameterCount(function_call) >= 4 then ww = asc(mid(new_entry, 5, 1)) else ww = 0
 SetFunctionType()

end sub


sub ScriptEntryMenu.UserSelect()

 dim old as UByte
 dim p as Placement ptr
 dim temp as Integer

 old = function_call
 main_menu.UserSelect()
 
 if not main_menu.cancelled then

  if main_menu.selected > 1 then
   function_call = main_menu.selected + &hD0 - 2
  else
   if old < &hD0 then function_call = old else function_call = 0
  end if

  SetFunctionType()
  Display()

  select case main_menu.selected

   case 1
    do
     BlueBox(character_menu.options.Width() + 2, character_menu.y, npc_names.Width(), 1)
     if character_menu.selected <= placement_groups(map_link).placements.Length() then
      p = placement_groups(map_link).placements.PointerAt(character_menu.selected)
      temp = p->npc_index
      if p->underground then temp += &h100
      WriteText(npc_names.ItemAt(temp + 1), character_menu.options.Width() + 3, character_menu.y + 1)
     elseif character_menu.selected = 13 then
      WriteText(FF4Text("You"), character_menu.options.Width() + 3, character_menu.y + 1)
     else
      WriteText(FF4Text("-N/A-"), character_menu.options.Width() + 3, character_menu.y + 1)
     end if
    loop until character_menu.UserInput()
    if not character_menu.cancelled then
     xx = character_menu.selected - 1
     if xx = &hC then
      character_movement_menu.ChangeOption(9, FF4Text("Become invisible "))
      character_movement_menu.ChangeOption(10, FF4Text("Become visible"))
      character_movement_menu.ChangeOption(11, FF4Text("Wave in"))
      character_movement_menu.ChangeOption(12, FF4Text("Wave out"))
      character_movement_menu.ChangeOption(13, FF4Text("Bow head"))
      character_movement_menu.ChangeOption(14, FF4Text("Lie down"))
      character_movement_menu.ChangeOption(15, FF4Text("Toggle turning"))
      character_movement_menu.ChangeOption(16, FF4Text("Toggle spinning"))
     else
      character_movement_menu.ChangeOption(9, FF4Text("Toggle visibility"))
      character_movement_menu.ChangeOption(10, FF4Text("Jump sideways"))
      character_movement_menu.ChangeOption(11, FF4Text("Spin"))
      character_movement_menu.ChangeOption(12, FF4Text("Spin-jump"))
      character_movement_menu.ChangeOption(13, FF4Text("Wave in"))
      character_movement_menu.ChangeOption(14, FF4Text("Wave out"))
      character_movement_menu.ChangeOption(15, FF4Text("Bow head"))
      character_movement_menu.ChangeOption(16, FF4Text("Lie down"))
     end if
     character_menu.Display()
     character_movement_menu.max_rows = 0
     character_movement_menu.UserSelect()
     character_movement_menu.max_rows = 1
     if not character_movement_menu.cancelled then
      function_call = xx * &h10 + (character_movement_menu.selected - 1)
     end if
    end if

   case 13, 21, 22
    do 
     status_menu.UserSelect()
     if not status_menu.cancelled then
      if xx and 2 ^ (status_menu.selected - 1) then
       status_menu.ChangeOption(status_menu.selected, , 0)
       xx -= 2 ^ (status_menu.selected - 1)
      else
       status_menu.ChangeOption(status_menu.selected, , 14)
       xx += 2 ^ (status_menu.selected - 1)
      end if
     end if
    loop until status_menu.cancelled

   case 14 to 17, 23, 24, 27, 43
    enter_xx.starting_number = xx
    enter_xx.UserSelect()
    xx = enter_xx.number

   case 18, 19, 41
    item_menu.max_rows = screen_height - item_menu.y
    item_menu.top_row = 1
    item_menu.ChangeSelected(item_menu.selected)
    item_menu.UserSelect()
    item_menu.max_rows = 1
    if not item_menu.cancelled then xx = item_menu.selected - 1

   case 20
    spell_menu.max_rows = screen_height - spell_menu.y
    spell_menu.top_row = 1
    spell_menu.ChangeSelected(spell_menu.selected)
    spell_menu.UserSelect()
    spell_menu.max_rows = 1
    if not spell_menu.cancelled then
     spell_menu.ChangeSelected(spell_menu.selected)
     spell_menu.Display()
     spellset_menu.max_rows = 0
     spellset_menu.UserSelect()
     spellset_menu.max_rows = 1
     if not spellset_menu.cancelled then
      yy = spell_menu.selected - 1
      xx = spellset_menu.selected - 1
     end if
    end if
    
   case 25, 26
    actor_menu.max_rows = 0
    actor_menu.UserSelect()
    actor_menu.max_rows = 1
    if not actor_menu.cancelled then xx = actor_menu.selected

   case 28, 44
    song_menu.max_rows = screen_height - song_menu.y
    song_menu.top_row = 1
    song_menu.ChangeSelected(song_menu.selected)
    song_menu.UserSelect()
    song_menu.max_rows = 1
    if not song_menu.cancelled then xx = song_menu.selected - 1

   case 29
    enter_xx.starting_number = xx
    enter_yy.starting_number = yy
    enter_xx.UserSelect()
    enter_xx.Display()
    enter_yy.UserSelect()
    xx = enter_xx.number
    yy = enter_yy.number

   case 30
    formation_menu.max_rows = screen_height - formation_menu.y
    formation_menu.top_row = 1
    formation_menu.ChangeSelected(formation_menu.selected)
    formation_menu.UserSelect()
    formation_menu.max_rows = 1
    if not formation_menu.cancelled then xx = (formation_menu.selected - 1) mod &h100

   case 31
    shop_menu.max_rows = screen_height - shop_menu.y
    shop_menu.top_row = 1
    shop_menu.ChangeSelected(shop_menu.selected)
    shop_menu.UserSelect()
    shop_menu.max_rows = 1
    if not shop_menu.cancelled then xx = shop_menu.selected - 1
    
   case 32
    message_menu.UserSelect()
    if not message_menu.cancelled then xx = (message_menu.selected - 1) mod &h100
    
   case 33
    do
     put ((x + message_menu.options.Width() + 2) * 8, (y + 3) * 8), blank, pset
     if message_menu.selected <= maps(map_link).dialogues.Length() then
      DisplayDialogue(x + message_menu.options.Width() + 2, y + 3, maps(map_link).dialogues.ItemAt(message_menu.selected), 5)
     end if
    loop until message_menu.UserInput()
    if not message_menu.cancelled then xx = (message_menu.selected - 1) mod &h100

   case 34
    do
     put ((x + message_menu.options.Width() + 2) * 8, (y + 3) * 8), blank, pset
     DisplayDialogue(x + message_menu.options.Width() + 2, y + 3, dialogues_bank1.ItemAt(message_menu.selected), 5)
    loop until message_menu.UserInput()
    if not message_menu.cancelled then xx = (message_menu.selected - 1) mod &h100

   case 35, 42
    do
     put ((x + message_menu.options.Width() + 2) * 8, (y + 3) * 8), blank, pset
     DisplayDialogue(x + message_menu.options.Width() + 2, y + 3, dialogues_bank1.ItemAt(message_menu.selected), 5)
    loop until message_menu.UserInput()
    if not message_menu.cancelled then xx = (message_menu.selected - 1) mod &h100
    
   case 36, 37
    flag_menu.max_rows = screen_height - flag_menu.y
    flag_menu.top_row = 1
    flag_menu.ChangeSelected(xx + 1)
    flag_menu.UserSelect()
    flag_menu.max_rows = 1
    if not flag_menu.cancelled then xx = flag_menu.selected - 1
    
   case 38, 39
    npc_menu.max_rows = screen_height - npc_menu.y
    npc_menu.top_row = 1
    npc_menu.ChangeSelected(npc_menu.selected)
    npc_menu.UserSelect()
    npc_menu.max_rows = 1
    if not npc_menu.cancelled then xx = (npc_menu.selected - 1) mod &h100
    
   case 40
    do
     put ((x + message_menu.options.Width() + 2) * 8, (y + 3) * 8), blank, pset
     DisplayDialogue(x + message_menu.options.Width() + 2, y + 3, dialogues_bank3.ItemAt(message_menu.selected), 5)
    loop until message_menu.UserInput()
    if not message_menu.cancelled then xx = (message_menu.selected - 1) mod &h100
    
   case 45
    sfx_menu.max_rows = screen_height - sfx_menu.y
    sfx_menu.top_row = 1
    sfx_menu.ChangeSelected(xx + 1)
    sfx_menu.UserSelect()
    sfx_menu.max_rows = 1
    if not sfx_menu.cancelled then xx = sfx_menu.selected - 1
    
   case 46
    if ifpatch then
     flag_menu.max_rows = screen_height - flag_menu.y
     flag_menu.top_row = 1
     flag_menu.ChangeSelected(flag_menu.selected)
     flag_menu.UserSelect()
     flag_menu.max_rows = 1
     if not flag_menu.cancelled then xx = (flag_menu.selected - 1) mod &h80
     flag_menu.ChangeSelected(flag_menu.selected)
     flag_menu.Display()
     onoff_menu.max_rows = 2
     onoff_menu.top_row = 1
     onoff_menu.UserSelect()
     onoff_menu.max_rows = 1
     if not onoff_menu.cancelled and onoff_menu.selected = 2 then xx += &h80
     onoff_menu.ChangeSelected(onoff_menu.selected)
     onoff_menu.Display()
     enter_yy.starting_number = yy
     enter_yy.UserSelect()
     yy = enter_yy.number
    else
     enter_xx.starting_number = xx
     enter_xx.UserSelect()
     xx = enter_xx.number
    end if
    
   case 47
    vfx_menu.max_rows = screen_height - vfx_menu.y
    vfx_menu.top_row = 1
    vfx_menu.ChangeSelected(xx + 1)
    vfx_menu.UserSelect()
    vfx_menu.max_rows = 1
    if not vfx_menu.cancelled then xx = vfx_menu.selected - 1
    
   case 48
    enter_xx.starting_number = yy
    enter_xx.UserSelect()
    yy = enter_xx.number
    enter_xx.Display()
    enter_yy.starting_number = zz
    enter_yy.UserSelect()
    zz = enter_yy.number
    enter_yy.Display()
    map_menu.max_rows = screen_height - map_menu.y
    map_menu.top_row = 1
    map_menu.ChangeSelected(map_menu.selected)
    map_menu.UserSelect()
    map_menu.max_rows = 1
    if not map_menu.cancelled then
     if map_menu.selected > &h100 then
      xx = map_menu.selected - &h101
      ww = ww or 2^7
     else
      xx = map_menu.selected - 1
      ww = ww mod 2^7
     end if
     map_menu.ChangeSelected(map_menu.selected)
     map_menu.Display()
     do
      properties_menu.UserSelect()
      if not properties_menu.cancelled then
       if ww and 2 ^ (properties_menu.selected + 4) then
        properties_menu.ChangeOption(properties_menu.selected,, 0)
        ww -= 2 ^ (properties_menu.selected + 4)
       else
        properties_menu.ChangeOption(properties_menu.selected,, 14)
        ww += 2 ^ (properties_menu.selected + 4)
       end if
      end if
     loop until properties_menu.cancelled
     properties_menu.Display()
     vehicle_menu.UserSelect()
     ww = (ww \ &h20) * &h20 + (vehicle_menu.selected - 1)
    end if

  end select

 end if
 
 put (main_menu.x * 8, main_menu.y * 8), blank, pset

end sub
