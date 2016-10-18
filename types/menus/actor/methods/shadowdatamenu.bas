constructor ShadowDataMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 
 main_menu = BlueMenu(x, y)
 load_menu = BlueMenu(x + 10, y)
 load_menu.max_rows = 1
 save_menu = BlueMenu(x + 10, y + 1)
 save_menu.max_rows = 1
 save_menu.AddOption(FF4Text("Discard"))
 for i as Integer = 1 to total_characters
  load_menu.AddOption(character_labels.ItemAt(i))
 next
 for i as Integer = 0 to 4
  load_menu.AddOption(FF4Text("Shadow slot " + str(i)))
  save_menu.AddOption(FF4Text("Shadow slot " + str(i)))
 next
 link_menu = BlueMenu(x + 10, y + 2)
 link_menu.max_rows = 1
 for i as Integer = 1 to total_characters
  link_menu.AddOption(character_labels.ItemAt(i))
 next

end constructor


function ShadowDataMenu.LoadString() as String

 dim result as String
 
 if load_initial then
  result = character_labels.ItemAt(load_slot + 1)
 else 
  result = FF4Text("Shadow slot " + str(load_slot))
 end if
 
 return result

end function


function ShadowDataMenu.SaveString() as String

 dim result as String
 
 if save_shadow then
  result = FF4Text("Shadow slot " + str(save_slot))
 else
  result = FF4Text("Discard      ")
 end if
 
 return result

end function


sub ShadowDataMenu.Display()

 main_menu.ChangeOption(1, FF4Text("Load:     ") + LoadString(), 15)
 main_menu.ChangeOption(2, FF4Text("Save:     ") + SaveString(), 15)
 main_menu.ChangeOption(3, FF4Text("Levelups: ") + character_labels.ItemAt(level_link), 15)
 
 main_menu.Display()

end sub


sub ShadowDataMenu.SetTo(index as UByte)

 load_slot = actors(index).load_slot
 save_slot = actors(index).store_slot
 load_initial = actors(index).load_initial
 save_shadow = actors(index).store_shadow
 level_link = actors(index).level_link

end sub


sub ShadowDataMenu.UserSelect()

 main_menu.cancelled = false
 
 do until main_menu.cancelled
 
  main_menu.UserSelect()
  
  if not main_menu.cancelled then
  
   select case main_menu.selected
   
    case 1 'Load
     if load_initial then
      load_menu.ChangeSelected(load_slot + 1)
     else
      load_menu.ChangeSelected(load_slot + total_characters + 1)
     end if
     load_menu.UserSelect()
     if not load_menu.cancelled then
      if load_menu.selected <= total_characters then
       load_initial = true
       load_slot = load_menu.selected - 1
       level_link = load_menu.selected
      else
       load_initial = false
       load_slot = load_menu.selected - total_characters - 1
      end if
     end if
    
    case 2 'Save
     if save_shadow then
      save_menu.ChangeSelected(save_slot + 2)
     else
      save_menu.ChangeSelected(1)
     end if
     save_menu.UserSelect()
     if not save_menu.cancelled then
      if save_menu.selected = 1 then
       save_shadow = false
       save_slot = 0
      else
       save_shadow = true
       save_slot = save_menu.selected - 2
      end if
     end if
     
    case 3 'Levelup link
     link_menu.ChangeSelected(level_link)
     link_menu.UserSelect()
     if not link_menu.cancelled then
      'characters(level_link).level = characters(link_menu.selected).level
      'for i as Integer = 1 to 70
       'characters(level_link).levelup(i) = characters(link_menu.selected).levelup(i)
      'next
      'for i as Integer = 1 to 8
       'characters(level_link).after70(i) = characters(link_menu.selected).after70(i)
      'next
      level_link = link_menu.selected
     end if
   
   end select
   
   Display()
  
  end if
 
 loop

end sub
