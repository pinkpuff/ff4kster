constructor CharacterLevelUpMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 level_menu = BlueMenu(x, y + 3)
 level_menu.max_rows = screen_height - y - 3

end constructor


sub CharacterLevelUpMenu.Display()

 BlueBox(x, y, level_menu.options.Width(), 1)
 WriteText(FF4Text("Lv  Stat Bonuses                 MHP  MMP  TNL"), x + 1, y + 1)
 level_menu.Display()

end sub


sub CharacterLevelUpMenu.SetTo(index as UByte)

 dim temp as String
 dim c as UByte

 character_id = index

 level_menu.ClearAll()
 for i as Integer = 1 to 69

  'level_menu.AddOption(FF4Text(Pad(str(i), 2, true, "0") + ":"))
  'for j as Integer = 1 to 5
   'if characters(index).levelup(i).stat_bonus.stat(j) then c = 14 else c = 0
   'level_menu.AddOption(FF4Text(StatName(j)), c)
  'next
  'if characters(index).levelup(i).stat_bonus.amount = 7 then
   'level_menu.AddOption(FF4Text("-1"))
  'else
   'level_menu.AddOption(FF4Text(" " + str(characters(index).levelup(i).stat_bonus.amount)))
  'end if
  'level_menu.AddOption(FF4Text(Pad(str(characters(index).levelup(i).hp_bonus), 3, true)))
  'level_menu.AddOption(FF4Text(Pad(str(characters(index).levelup(i).mp_bonus), 3, true)))
  'level_menu.AddOption(FF4Text(Pad(str(characters(index).levelup(i).tnl), 6, true)))
    
  temp = Pad(str(i), 2, true, "0") + ": "
  for j as Integer = 1 to 5
   if characters(index).levelup(i).stat_bonus.stat(j) then 
    temp += StatName(j) + "  "
   else
    temp += space(5)
   end if
  next
  if characters(index).levelup(i).stat_bonus.amount = 7 then
   temp += "-1"
  else
   temp += " " + str(characters(index).levelup(i).stat_bonus.amount)
  end if
  temp += "  " + Pad(str(characters(index).levelup(i).hp_bonus), 3, true)
  temp += "  " + Pad(str(characters(index).levelup(i).mp_bonus), 3, true)
  temp += "  " + Pad(str(characters(index).levelup(i).tnl), 6, true)
  level_menu.AddOption(FF4Text(temp))
 next

end sub


sub CharacterLevelUpMenu.UserSelect()

 dim stat_bonuses as BlueMenu
 dim amount_menu as BlueMenu
 dim hp_input as BlueNumberInput
 dim mp_input as BlueNumberInput
 dim tnl_input as BlueNumberInput
 dim c as UByte
 
 stat_bonuses.x = x + 4
 stat_bonuses.columns = 5
 for i as Integer = 1 to 5
  stat_bonuses.AddOption(FF4Text(StatName(i)))
 next
 
 amount_menu.x = x + 29
 for i as Integer = 0 to 6
  amount_menu.AddOption(FF4Text(" " + str(i)))
 next
 amount_menu.AddOption(FF4Text("-1"))
 amount_menu.max_rows = 1
 
 hp_input.x = x + 33
 mp_input.x = x + 39
 mp_input.max_value = 31
 tnl_input.x = x + 43
 tnl_input.max_value = 2^19

 do
  level_menu.UserSelect()
  if not level_menu.cancelled then
   stat_bonuses.y = level_menu.CursorY() - 1
   for i as Integer = 1 to 5
    if characters(character_id).levelup(level_menu.selected).stat_bonus.stat(i) then c = 14 else c = 0
    stat_bonuses.ChangeOption(i, , c)
   next
   do
    Display()
    stat_bonuses.UserSelect()
    if not stat_bonuses.cancelled then
     characters(character_id).levelup(level_menu.selected).stat_bonus.stat(stat_bonuses.selected) = not characters(character_id).levelup(level_menu.selected).stat_bonus.stat(stat_bonuses.selected)
     if characters(character_id).levelup(level_menu.selected).stat_bonus.stat(stat_bonuses.selected) then c = 14 else c = 0
     stat_bonuses.ChangeOption(stat_bonuses.selected, , c)
    end if
   loop until stat_bonuses.cancelled
   SetTo(character_id)
   Display()
   amount_menu.y = level_menu.CursorY() - 1
   amount_menu.ChangeSelected(characters(character_id).levelup(level_menu.selected).stat_bonus.amount + 1)
   amount_menu.UserSelect()
   characters(character_id).levelup(level_menu.selected).stat_bonus.amount = amount_menu.selected - 1
   SetTo(character_id)
   Display()
   hp_input.y = level_menu.CursorY() - 1
   hp_input.starting_number = characters(character_id).levelup(level_menu.selected).hp_bonus
   hp_input.UserSelect()
   characters(character_id).levelup(level_menu.selected).hp_bonus = hp_input.number
   SetTo(character_id)
   Display()
   mp_input.y = level_menu.CursorY() - 1
   mp_input.starting_number = characters(character_id).levelup(level_menu.selected).mp_bonus
   mp_input.UserSelect()
   characters(character_id).levelup(level_menu.selected).mp_bonus = mp_input.number
   SetTo(character_id)
   Display()
   tnl_input.y = level_menu.CursorY() - 1
   tnl_input.starting_number = characters(character_id).levelup(level_menu.selected).tnl
   tnl_input.UserSelect()
   characters(character_id).levelup(level_menu.selected).tnl = tnl_input.number
   SetTo(character_id)
   Display()
  end if
 loop until level_menu.cancelled

end sub
