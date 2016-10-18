constructor TriggerInfoMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 location_menu = BlueMenu(x, y)
 type_menu = BlueMenu(x, y + 4)
 parameters_menu = BlueMenu(x, y + 7)
 call_menu = EventCallMenu(x, y + 10)

 operation_menu.AddOption(FF4Text("Edit location"))
 operation_menu.AddOption(FF4Text("Edit type"))
 operation_menu.AddOption(FF4Text("Edit parameters"))
 operation_menu.x = screen_width - operation_menu.options.Width() - 2
 operation_menu.y = y
 
 type_menu.AddOption(FF4Text("Type: Teleport"))
 type_menu.AddOption(FF4Text("Type: Treasure"))
 type_menu.AddOption(FF4Text("Type: Event"))
 type_menu.max_rows = 1

end constructor


sub TriggerInfoMenu.Display()

 dim temp as String

 location_menu.ChangeOption(1, FF4Text("X: " + Pad(str(t->x), 3, true)), 15)
 location_menu.ChangeOption(2, FF4Text("Y: " + Pad(str(t->y), 3, true)), 15)
 
 parameters_menu.Hide()
 parameters_menu.ClearAll()
 parameters_menu.max_rows = 0
 if t->warp then
  type_menu.ChangeSelected(1)
  if underworld then
   if t->new_map < 128 then
    temp = map_names.ItemAt(t->new_map + 257)
   elseif t->new_map >= 251 then
    temp = map_names.ItemAt(t->new_map + 1)
   else
    temp = FF4Text("UNKNOWN")
   end if
  else
   temp = map_names.ItemAt(t->new_map + 1)
  end if
  parameters_menu.AddOption(FF4Text("To:     ") + Pad(temp, map_names.Width(), , FF4Text(" ")))
  parameters_menu.AddOption(FF4Text("X:      " + str(t->new_x)))
  parameters_menu.AddOption(FF4Text("Y:      " + str(t->new_y)))
  parameters_menu.AddOption(FF4Text("Facing: " + FacingString(t->facing)))
  parameters_menu.ChangeSelected(1)
 elseif t->treasure then
  type_menu.ChangeSelected(2)
  if t->item then temp = "Item" else temp = "Gil      "
  parameters_menu.AddOption(FF4Text("Type:     " + temp))
  if t->item then
   temp = item_names.ItemAt(t->contents + 1)
  else
   temp = FF4Text(PriceName(t->contents))
  end if
  parameters_menu.AddOption(FF4Text("Contents: ") + temp)
  if t->trapped then temp = "YES" else temp = "NO "
  parameters_menu.AddOption(FF4Text("Trapped:  " + temp))
  parameters_menu.AddOption(FF4Text("Battle:   ") + formation_names.ItemAt(t->formation + 449) + FF4Text(" - ") + formations(t->formation + 449).Preview())
  parameters_menu.ChangeSelected(1)
 else
  type_menu.ChangeSelected(3)
  parameters_menu.max_rows = 1
  for i as Integer = 1 to eventcalls.Length()
   parameters_menu.AddOption(FF4Text("Event call: " + str(i)))
  next
  if t->event = 0 then t->event = 1
  parameters_menu.ChangeSelected(t->event)
  call_menu.SetTo(eventcalls.PointerAt(t->event), m)
  call_menu.Display()
 end if

 location_menu.Display()
 type_menu.Display()
 parameters_menu.Display()

end sub


sub TriggerInfoMenu.UserSelect()

 dim xy as BlueNumberInput
 dim destination_menu_overworld as BlueMenu
 dim destination_menu_underworld as BlueMenu
 dim facing_menu as BlueMenu
 dim contents_menu as BlueMenu
 dim formation_menu as BlueMenu
 dim gil_menu as BlueMenu
 dim blank as Any ptr
 
 blank = ImageCreate(640, 480, RGB(0, 0, 0))

 xy.max_value = &hFF
 
 destination_menu_overworld.x = x + 8
 destination_menu_overworld.y = y + 7
 destination_menu_overworld.max_rows = 1
 for i as Integer = 1 to 256
  destination_menu_overworld.AddOption(map_names.ItemAt(i))
 next

 destination_menu_underworld.x = destination_menu_overworld.x
 destination_menu_underworld.y = destination_menu_overworld.y
 destination_menu_underworld.max_rows = destination_menu_overworld.max_rows
 for i as Integer = 257 to total_maps
  destination_menu_underworld.AddOption(map_names.ItemAt(i))
 next
 for i as Integer = 252 to 256
  destination_menu_underworld.AddOption(map_names.ItemAt(i))
 next
 
 facing_menu.x = destination_menu_overworld.x
 facing_menu.y = y + 10
 facing_menu.max_rows = 1
 facing_menu.AddOption(FF4Text("Up"))
 facing_menu.AddOption(FF4Text("Right"))
 facing_menu.AddOption(FF4Text("Down"))
 facing_menu.AddOption(FF4Text("Left"))

 contents_menu.x = x + 10
 contents_menu.y = y + 8
 contents_menu.max_rows = 1
 for i as Integer = 1 to total_items
  contents_menu.AddOption(item_names.ItemAt(i))
 next
 
 formation_menu.x = contents_menu.x
 formation_menu.y = contents_menu.y + 2
 formation_menu.max_rows = 1
 for i as Integer = 449 to 512
  formation_menu.AddOption(formation_names.ItemAt(i) + FF4Text(" - ") + formations(i).Preview())
 next
 
 gil_menu.x = contents_menu.x
 gil_menu.y = contents_menu.y
 gil_menu.max_rows = 1
 for i as Integer = 0 to 255
  gil_menu.AddOption(FF4Text(PriceName(i)))
 next
 
 operation_menu.UserSelect()
 
 if not operation_menu.cancelled then
 
  select case operation_menu.selected
  
   case 1 'Location
    do
     location_menu.UserSelect()
     if not location_menu.cancelled then
      if location_menu.selected = 1 then
       xy.x = x + 3
       xy.y = location_menu.y
       xy.starting_number = t->x
       xy.UserSelect()
       t->x = xy.number
      else
       xy.max_value = 127
       xy.x = x + 3
       xy.y = location_menu.y + 1
       xy.starting_number = t->y
       xy.UserSelect()
       t->y = xy.number
       xy.max_value = &hFF
      end if
      Display()
     end if
    loop until location_menu.cancelled    
   
   case 2 'Type
    type_menu.UserSelect()
    if not type_menu.cancelled then
     select case type_menu.selected
      case 1
       t->warp = true
       t->treasure = false
      case 2
       t->warp = false
       t->treasure = true
      case 3
       t->warp = false
       t->treasure = false
     end select
     Display()
    end if
   
   case 3 'Parameters
    if t->warp then
     do
      parameters_menu.UserSelect()
      if not parameters_menu.cancelled then
       select case parameters_menu.selected
        case 1 'Destination
         if underworld then
          if t->new_map < 128 then
           destination_menu_underworld.ChangeSelected(t->new_map + 1)
          else
           destination_menu_underworld.ChangeSelected(t->new_map + 128 - 250)
          end if
          destination_menu_underworld.UserSelect()
          if not destination_menu_underworld.cancelled then
           if destination_menu_underworld.selected > 128 then
            t->new_map = destination_menu_underworld.selected - 128 + 250
           else
            t->new_map = destination_menu_underworld.selected - 1
           end if
          end if
         else
          destination_menu_overworld.ChangeSelected(t->new_map + 1)
          destination_menu_overworld.UserSelect()
          if not destination_menu_overworld.cancelled then t->new_map = destination_menu_overworld.selected - 1
         end if
        case 2 'X
         xy.x = destination_menu_overworld.x
         xy.y = destination_menu_overworld.y + 1
         xy.starting_number = t->new_x
         xy.UserSelect()
         t->new_x = xy.number
        case 3 'Y
         xy.x = destination_menu_overworld.x
         xy.y = destination_menu_overworld.y + 2
         xy.starting_number = t->new_y
         xy.UserSelect()
         t->new_y = xy.number
        case 4 'Facing
         facing_menu.ChangeSelected(t->facing + 1)
         facing_menu.UserSelect()
         if not facing_menu.cancelled then t->facing = facing_menu.selected - 1
       end select
       Display()
      end if
     loop until parameters_menu.cancelled
    elseif t->treasure then
     do
      parameters_menu.UserSelect()
      if not parameters_menu.cancelled then
       select case parameters_menu.selected
        case 1 'Type
         t->item = not t->item
        case 2 'Contents
         if t->item then
          contents_menu.ChangeSelected(t->contents + 1)
          contents_menu.UserSelect()
          if not contents_menu.cancelled then t->contents = contents_menu.selected - 1
         else
          gil_menu.ChangeSelected(t->contents + 1)
          gil_menu.UserSelect()
          if not gil_menu.cancelled then t->contents = gil_menu.selected - 1
         end if
        case 3 'Trapped
         t->trapped = not t->trapped
        case 4 'Battle
         formation_menu.ChangeSelected(t->formation + 1)
         formation_menu.UserSelect()
         if not formation_menu.cancelled then t->formation = formation_menu.selected - 1
       end select
       Display()
      end if
     loop until parameters_menu.cancelled
    else
     do
      put (call_menu.x * 8, call_menu.y * 8), blank, pset
      call_menu.SetTo(eventcalls.PointerAt(parameters_menu.selected), m)
      call_menu.Display()
     loop until parameters_menu.UserInput()
     if not parameters_menu.cancelled then
      t->event = parameters_menu.selected
      call_menu.UserSelect()
     end if
    end if
     
  
  end select
 
 end if

end sub
