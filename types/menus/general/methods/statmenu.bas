constructor StatMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 flag_menu = BlueMenu(x, y)
 for i as UByte = 1 to 5
  flag_menu.AddOption(FF4Text(StatName(i)), 15)
 next
 index_menu = BlueMenu(x, y + 7)
 index_menu.max_rows = 1
 for i as UByte = 1 to 8
  index_menu.AddOption(FF4Text(right(Bonus(i - 1), 2) + " / " + Penalty(i - 1)))
 next

end constructor


function StatMenu.Bonus(index as UByte) as String
 
 dim result as String
 
 select case index
 case 0: result = "  3"
 case 1: result = "  5"
 case 2: result = " 10"
 case 3: result = " 15"
 case 4: result = "  5"
 case 5: result = " 10"
 case 6: result = " 15"
 case 7: result = "  5"
 end select
 
 return result
 
end function


function StatMenu.Penalty(index as UByte) as String
 
 dim result as String
 
 select case index
 case 0 to 3: result = "  0"
 case 4: result = "- 5"
 case 5: result = "-10"
 case 6: result = "-15"
 case 7: result = "-10"
 end select
 
 return result
 
end function


sub StatMenu.Display()
 
 dim c as UByte
 
 BlueBox(x + 5, y, 3, 5)
 for i as UByte = 1 to 5
  if flags(i) then
   WriteText(FF4Text(Bonus(mod_index)), x + 6, y + i, 10)
  else
   WriteText(FF4Text(Penalty(mod_index)), x + 6, y + i, 12)
  end if
 next

 index_menu.ChangeSelected(mod_index + 1)
 
 flag_menu.Display()
 index_menu.Display()
 
end sub


sub StatMenu.UserSelect()

 index_menu.cancelled = false
 index_menu.UserSelect()
 if not index_menu.cancelled then mod_index = index_menu.selected - 1
 Display()
 
 flag_menu.cancelled = false
 do until flag_menu.cancelled
  flag_menu.UserSelect()
  if not flag_menu.cancelled then 
   flags(flag_menu.selected) = not flags(flag_menu.selected)
   Display()
  end if
 loop  

end sub
