constructor StatUpMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y

 statflags = BlueMenu(x, y)
 amount = BlueMenu(x, y + 7)
 
 for i as Integer = 1 to 5
  statflags.AddOption(FF4Text(StatName(i)))
 next
 
 for i as Integer = 0 to 6
  amount.AddOption(FF4Text("  " + str(i)))
 next
 amount.AddOption(FF4Text(" -1"))
 amount.max_rows = 1

end constructor


sub StatUpMenu.Display()

 dim c as UByte

 for i as Integer = 1 to 5
  if stat(i) then c = 15 else c = 0
  statflags.ChangeOption(i, , c)
 next
 
 amount.ChangeSelected(bonus + 1)

 statflags.Display()
 amount.Display()

end sub


sub StatUpMenu.SetTo(s as StatLevelUp)

 for i as Integer = 1 to 5
  stat(i) = s.stat(i)
 next
 bonus = s.amount
 
end sub


sub StatUpMenu.UserSelect()

 do
  statflags.UserSelect()
  if not statflags.cancelled then
   stat(statflags.selected) = not stat(statflags.selected)
   Display()
  end if
 loop until statflags.cancelled
 
 amount.UserSelect()
 if not amount.cancelled then
  bonus = amount.selected - 1
  Display()
 end if

end sub
