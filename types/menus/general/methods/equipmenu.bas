constructor EquipMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 index = 0
 
 flag_menu = BlueMenu(x, y + 3)
 flag_menu.columns = 2
 for i as Integer = 1 to total_jobs
  flag_menu.AddOption(jobs(i).name, 0)
 next

end constructor


sub EquipMenu.Display()

 BlueBox(x, y, flag_menu.options.Width() * 2 + 2, 1)
 WriteText(FF4Text("Index: " + Pad(str(index), 2, true)), x + 1, y + 1)

 for i as Integer = 1 to total_jobs
  if equipcharts(index + 1).flags(i) then
   flag_menu.ChangeOption(i, jobs(i).name, 14)
  else
   flag_menu.ChangeOption(i, jobs(i).name, 0)
  end if
 next
 flag_menu.Display()

end sub


sub EquipMenu.UserSelect()

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
    if index < total_equip_charts - 1 then index += 1
   case DOWN_KEY
    if index > 0 then index -= 1
   case TAB_KEY
    do until flag_menu.cancelled
     flag_menu.UserSelect()
     if not flag_menu.cancelled then
      equipcharts(index + 1).flags(flag_menu.selected) = not equipcharts(index + 1).flags(flag_menu.selected)
      Display()
     end if
    loop
    flag_menu.cancelled = false
  end select
 loop

end sub
