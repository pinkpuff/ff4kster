constructor FlagMenu()
end constructor


constructor FlagMenu(starting_x as UByte = 0, starting_y as UByte = 0, kind as String)

 x = starting_x
 y = starting_y

 select case kind
  
  case "element"
   for i as Integer = 1 to 8
    flag_names.Append(element_names.ItemAt(i))
   next
   
  case "status"
   for i as Integer = 1 to 24
    flag_names.Append(element_names.ItemAt(i))
   next
   
  case "persistent status"
   for i as Integer = 9 to 16
    flag_names.Append(element_names.ItemAt(i))
   next
   
  case "temporary status"
   for i as Integer = 17 to 24
    flag_names.Append(element_names.ItemAt(i))
   next
   
  case "system status"
   for i as Integer = 25 to 32
    flag_names.Append(element_names.ItemAt(i))
   next
   
  case "hidden status"
   for i as Integer = 33 to 40
    flag_names.Append(element_names.ItemAt(i))
   next
   
  case "race"
   for i as Integer = 1 to 8
    flag_names.Append(race_names.ItemAt(i))
   next
   
 end select
 
 CreateMainMenu()
 
end constructor


constructor FlagMenu(starting_x as UByte = 0, starting_y as UByte = 0, names as List, settings as String)

 x = starting_x
 y = starting_y
 flag_names = names
  
 for i as Integer = 1 to len(settings)
  for j as Integer = 0 to 7
   if asc(mid(settings, i)) and 2^j then flags(j) = true else flags(j) = false
  next
 next
 
 CreateMainMenu()
 
end constructor


function FlagMenu.MenuIndexOfFlag(flag_index as UByte) as UByte

 return ((flag_index - 1) mod 8) * main_menu.columns + (flag_index - 1) \ 8 + 1

end function


function FlagMenu.FlagOfMenuIndex() as UByte

 return (main_menu.selected - 1) \ main_menu.columns + ((main_menu.selected - 1) mod main_menu.columns) * 8 + 1

end function


sub FlagMenu.CreateMainMenu()

 dim c as UByte

 main_menu.x = x
 main_menu.y = y
 main_menu.columns = RoundUp(flag_names.Length() / 8)
 for i as Integer = 1 to flag_names.Length()
  if flags(i) then c = 14 else c = 0
  main_menu.ChangeOption(((i - 1) mod 8) * main_menu.columns + (i - 1) \ 8 + 1, flag_names.ItemAt(i), c)
 next
 
 'blank = ImageCreate((main_menu.options.Width() + 2) * main_menu.columns * 8, (RoundUp(main_menu.options.Length() / main_menu.columns) + 2) * 8)
 
end sub


sub FlagMenu.Display()

 main_menu.Display()

end sub


sub FlagMenu.Hide()

 'put (x * 8, y * 8), blank, pset
 main_menu.Hide()

end sub


sub FlagMenu.SetFlag(flag_index as UByte, value as Boolean = true)

 dim c as UByte
 
 flags(flag_index) = value
 if value then c = 14 else c = 0
 'main_menu.ChangeOption(((flag_index - 1) mod 8) * main_menu.columns + (flag_index - 1) \ 8 + 1, flag_names.ItemAt(flag_index), c)
 main_menu.ChangeOption(MenuIndexOfFlag(flag_index), flag_names.ItemAt(flag_index), c)

end sub


sub FlagMenu.UserSelect()

 do
  main_menu.UserSelect()
  if not main_menu.cancelled then
   if flags(FlagOfMenuIndex()) then
    'flags(main_menu.selected) = false
    flags(FlagOfMenuIndex()) = false
    main_menu.ChangeOption(main_menu.selected,, 0)
   else
    'flags(main_menu.selected) = true
    flags(FlagOfMenuIndex()) = true
    main_menu.ChangeOption(main_menu.selected,, 14)
   end if
  end if
 loop until main_menu.cancelled

end sub
