constructor ElementMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 flag_menu.x = x
 flag_menu.y = y + 3
 flag_menu.columns = 3
 for i as Byte = 1 to 8
  for j as Byte = 0 to 2
   flag_menu.AddOption(element_names.ItemAt(j * 8 + i), 0)
  next
 next

end constructor

sub ElementMenu.Display()
 
 BlueBox(x, y, (flag_menu.options.Width() + 2) * 3 - 2, 1)
 WriteText(FF4Text("Index: " + Pad(str(index), 3, true)), x + 1, y + 1)
 
 for i as Integer = 1 to 24
  if elementgrids(index).flags(i) then
   flag_menu.ChangeOption(i, flag_menu.options.ItemAt(i), 14)
  else
   flag_menu.ChangeOption(i, flag_menu.options.ItemAt(i), 0)
  end if
 next
 
 flag_menu.Display()
 
end sub


sub ElementMenu.UserSelect()

 dim done as Boolean
 dim starting_index as UByte = index
 
 do until done
  Display()
  DrawLetter(20, x, y + 1)
  select case getkey
   case ESC_KEY
    index = starting_index
    done = true
   case ENTER_KEY
    done = true
   case UP_KEY
    if index < total_element_grids - 1 then index += 1
   case DOWN_KEY
    if index > 0 then index -= 1
   case TAB_KEY
    do until flag_menu.cancelled
     flag_menu.UserSelect()
     if not flag_menu.cancelled then
      elementgrids(index).flags(flag_menu.selected) = not elementgrids(index).flags(flag_menu.selected)
      Display()
     end if
    loop
    flag_menu.cancelled = false
  end select
 loop

end sub
