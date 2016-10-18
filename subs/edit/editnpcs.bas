sub EditNPCs()

 dim select_map as BlueMenu
 dim select_placement as BlueMenu
 dim edit_placement as BlueMenu
 dim edit_npc as BlueMenu
 dim speech_menu as EventCallMenu
 dim enter_number as BlueNumberInput
 dim select_npc as BlueMenu
 dim facing_menu as BlueMenu
 dim blank as Any ptr
 dim p as Placement ptr
 dim done as Boolean
 dim a as UInteger
 dim temp as Integer
 dim underground as Integer

 blank = ImageCreate(640, 480, RGB(0, 0, 0))
 
 select_map.max_rows = 8
 for i as Integer = 1 to total_maps
  select_map.AddOption(Pad(map_names.ItemAt(i), screen_width - 2, , FF4Text(" ")))
 next
 
 select_placement.y = 10
 
 edit_placement.x = 14
 edit_placement.y = select_placement.y
 
 edit_npc.x = edit_placement.x
 edit_npc.y = edit_placement.y + 12
 
 speech_menu = EventCallMenu(edit_placement.x, edit_npc.y + 5)
 
 facing_menu.max_rows = 1
 facing_menu.x = edit_placement.x + 12
 facing_menu.y = edit_placement.y + 8
 for i as Integer = 0 to 3
  facing_menu.AddOption(FF4Text(FacingString(i)))
 next
 
 select_npc.max_rows = 1
 select_npc.x = edit_placement.x + 12
 select_npc.y = edit_placement.y + 9
 for i as Integer = 1 to total_npcs
  select_npc.AddOption(npc_names.ItemAt(i))
 next
 
 do
  
  do
   select_placement.ClearAll()
   for i as Integer = 1 to placement_groups(select_map.selected).placements.Length()
    select_placement.AddOption(FF4Text("Placement " + Pad(str(i), 2, true)))
   next
   if select_placement.options.Length() = 0 then select_placement.AddOption(FF4Text(Pad("-- EMPTY --", 12)))
   put (select_placement.x * 8, select_placement.y * 8), blank, pset
   select_placement.Display()
  loop until select_map.UserInput()
  
  if not select_map.cancelled then

   select_placement.ChangeSelected(1)

   do
    
    done = false
    do
     if select_placement.selected <= placement_groups(select_map.selected).placements.Length() then
      if select_map.selected > &h100 then underground = &h100 else underground = 0
      p = placement_groups(select_map.selected).placements.PointerAt(select_placement.selected)
      edit_placement.ChangeOption(1, FF4Text("X:          " + Pad(str(p->x), 3)), 15)
      edit_placement.ChangeOption(2, FF4Text("Y:          " + Pad(str(p->y), 3)), 15)
      edit_placement.ChangeOption(3, FF4Text("Speed:      " + Pad(str(p->speed), 3)), 15)
      edit_placement.ChangeOption(4, FF4Text("Palette:    " + Pad(str(p->palette_index), 3)), 15)
      edit_placement.ChangeOption(5, FF4Text("Walks:      " + YesNo(p->walks)), 15)
      edit_placement.ChangeOption(6, FF4Text("Intangible: " + YesNo(p->intangible)), 15)
      edit_placement.ChangeOption(7, FF4Text("Turns:      " + YesNo(p->turns)), 15)
      edit_placement.ChangeOption(8, FF4Text("Marches:    " + YesNo(p->marches)), 15)
      edit_placement.ChangeOption(9, FF4Text("Facing:     " + Pad(FacingString(p->facing), 5)), 15)
      edit_placement.ChangeOption(10, FF4Text("NPC:        ") + Pad(npc_names.ItemAt(p->npc_index + underground + 1), npc_names.Width()), 15)
      temp = p->npc_index
      if select_map.selected > &h100 then temp += &h100
      edit_npc.ChangeOption(1, FF4Text("Sprite:  ") + Pad(npc_sprite_names.ItemAt(npcs(temp).sprite + 1), npc_sprite_names.Width()), 15)
      edit_npc.ChangeOption(2, FF4Text("Visible: " + YesNo(npcs(temp).visible)), 15)
      edit_npc.ChangeOption(3, FF4Text("Speech"), 15)
      speech_menu.SetTo(@npcs(temp).speech, select_map.selected)
      edit_placement.Display()
      edit_npc.Display()
      put (speech_menu.x * 8, speech_menu.y * 8), blank, pset
      speech_menu.Display()
     end if
     select_placement.Display()
     select_placement.ShowCursor()
     a = getkey
     select case a
      case DELETE_KEY
       if placement_groups(select_map.selected).placements.Length() > 0 then
        placement_groups(select_map.selected).placements.Remove(select_placement.selected)
        select_placement.Remove(select_placement.options.Length())
        if placement_groups(select_map.selected).placements.Length() = 0 then select_placement.AddOption(FF4Text(Pad("-- EMPTY --", 12)))
        put (select_placement.x * 8, select_placement.y * 8), blank, pset
       end if
      case INSERT_KEY
       dim space_after_insert as Integer
       space_after_insert = PlacementSpace() + 4
       if placement_groups(select_map.selected).placements.Length() = 0 then space_after_insert += 1
       if placement_groups(select_map.selected).placements.Length() < 12 and space_after_insert < max_placement_room then
        p = callocate(SizeOf(Placement))
        placement_groups(select_map.selected).placements.Append(p)
        select_placement.AddOption(FF4Text("Placement " + Pad(str(placement_groups(select_map.selected).placements.Length()), 2, true)))
        if placement_groups(select_map.selected).placements.Length() = 1 then select_placement.Remove(1)
       end if
      case else
       done = select_placement.ProcessKey(a)
     end select
    loop until done
    
    if not select_placement.cancelled and select_placement.selected <= placement_groups(select_map.selected).placements.Length() then
     
     do
      
      edit_placement.UserSelect()
      
      if not edit_placement.cancelled then
     
       select case edit_placement.selected
       
        case 1 'X
         enter_number.x = edit_placement.x + 12
         enter_number.y = edit_placement.y
         enter_number.max_value = &hFF
         enter_number.starting_number = p->x
         enter_number.UserSelect()
         p->x = enter_number.number
         edit_placement.ChangeOption(1, FF4Text("X:          " + Pad(str(p->x), 3)), 15)
         edit_placement.Display()
        
        case 2 'Y
         enter_number.x = edit_placement.x + 12
         enter_number.y = edit_placement.y + 1
         enter_number.max_value = &hFF
         enter_number.starting_number = p->y
         enter_number.UserSelect()
         p->y = enter_number.number
         edit_placement.ChangeOption(2, FF4Text("Y:          " + Pad(str(p->y), 3)), 15)
         edit_placement.Display()
        
        case 3 'Speed
         enter_number.x = edit_placement.x + 12
         enter_number.y = edit_placement.y + 2
         enter_number.max_value = 3
         enter_number.starting_number = p->speed
         enter_number.UserSelect()
         p->speed = enter_number.number
         edit_placement.ChangeOption(3, FF4Text("Speed:      " + Pad(str(p->speed), 3)), 15)
         edit_placement.Display()
        
        case 4 'Palette
         enter_number.x = edit_placement.x + 12
         enter_number.y = edit_placement.y + 3
         enter_number.max_value = &hFF
         enter_number.starting_number = p->palette_index
         enter_number.UserSelect()
         p->palette_index = enter_number.number
         edit_placement.ChangeOption(4, FF4Text("Palette:    " + Pad(str(p->palette_index), 3)), 15)
         edit_placement.Display()
        
        case 5 'Walks
         p->walks = not p->walks
         edit_placement.ChangeOption(5, FF4Text("Walks:      " + YesNo(p->walks)), 15)
         edit_placement.Display()
         
        case 6 'Intangible
         p->intangible = not p->intangible
         edit_placement.ChangeOption(6, FF4Text("Intangible: " + YesNo(p->intangible)), 15)
         edit_placement.Display()
         
        case 7 'Turns
         p->turns = not p->turns
         edit_placement.ChangeOption(7, FF4Text("Turns:      " + YesNo(p->turns)), 15)
         edit_placement.Display()
        
        case 8 'Marches
         p->marches = not p->marches
         edit_placement.ChangeOption(8, FF4Text("Marches:    " + YesNo(p->marches)), 15)
         edit_placement.Display()
        
        case 9 'Facing
         facing_menu.ChangeSelected(p->facing + 1)
         facing_menu.UserSelect()
         if not facing_menu.cancelled then
          p->facing = facing_menu.selected - 1
          edit_placement.ChangeOption(9, FF4Text("Facing:     " + Pad(FacingString(p->facing), 5)), 15)
         end if         
         edit_placement.Display()
       
        case 10 'NPC
         if p->underground then temp = &h100 else temp = 0
         select_npc.ChangeSelected(p->npc_index + temp + 1)
         do
          temp = select_npc.selected - 1
          'if select_map.selected > &h100 then temp += &h100
          edit_npc.ChangeOption(1, FF4Text("Sprite:  ") + Pad(npc_sprite_names.ItemAt(npcs(temp).sprite + 1), npc_sprite_names.Width()), 15)
          edit_npc.ChangeOption(2, FF4Text("Visible: " + YesNo(npcs(temp).visible)), 15)
          edit_npc.ChangeOption(3, FF4Text("Speech"), 15)
          speech_menu.SetTo(@npcs(temp).speech, select_map.selected)
          'edit_placement.Display()
          edit_npc.Display()
          put (speech_menu.x * 8, speech_menu.y * 8), blank, pset
          speech_menu.Display()
         loop until select_npc.UserInput() 'enter_number.UserInput()
         p->npc_index = (select_npc.selected - 1) mod &h100
         if select_map.selected > &h100 then p->underground = true else p->underground = false
         temp = p->npc_index
         if p->underground then temp += &h100
         edit_placement.ChangeOption(10, FF4Text("NPC:        ") + Pad(npc_names.ItemAt(temp + 1), npc_names.Width()), 15)
         edit_placement.Display()
         do
          edit_npc.UserSelect()
          if not edit_npc.cancelled then
           temp = p->npc_index
           if p->underground then temp += &h100
           select case edit_npc.selected
            case 1 'Sprite
             npcs(temp).sprite = ListItem(edit_npc.x + 9, edit_npc.y, npc_sprite_names, npcs(temp).sprite + 1) - 1
             edit_npc.ChangeOption(1, FF4Text("Sprite:  ") + Pad(npc_sprite_names.ItemAt(npcs(temp).sprite + 1), npc_sprite_names.Width()), 15)
             edit_npc.Display()
            case 2 'Visible
             npcs(temp).visible = not npcs(temp).visible
             edit_npc.ChangeOption(2, FF4Text("Visible: " + YesNo(npcs(temp).visible)), 15)
             edit_npc.Display()
            case 3 'Speech
             speech_menu.UserSelect()
             speech_menu.Display()
           end select
          end if
         loop until edit_npc.cancelled
        
       end select
       
      end if
      
     loop until edit_placement.cancelled
     
    end if
    
   loop until select_placement.cancelled
    
  end if

 loop until select_map.cancelled

end sub
