constructor SpellLinkMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 x = starting_x
 y = starting_y
 spell_menu = BlueMenu(x + 9, y + 3)
 spell_menu.columns = 2

end constructor


sub SpellLinkMenu.Display()

 BlueBox(x, y + 3, 7, 3)
 WriteText(FF4Text("White: "), x + 1, y + 4)
 WriteText(FF4Text("Black: "), x + 1, y + 5)
 WriteText(FF4Text("Call:  "), x + 1, y + 6)
 BlueBox(x + 9, y, Max(spellset_names.Width(), 6) * 2 + 2, 1)
 WriteText(FF4Text("Combat"), x + 10, y + 1)
 WriteText(FF4Text("Menu"), x + 10 + Max(spellset_names.Width(), 6) + 2, y + 1)
 spell_menu.ChangeOption(1, Pad(spellset_names.ItemAt(white), spellset_names.Width(), , FF4Text(" ")), 15)
 spell_menu.ChangeOption(3, Pad(spellset_names.ItemAt(black), spellset_names.Width(), , FF4Text(" ")), 15)
 spell_menu.ChangeOption(5, Pad(spellset_names.ItemAt(summon), spellset_names.Width(), , FF4Text(" ")), 15)
 if unusable_job then
  spell_menu.ChangeOption(2, FF4Text(Pad("-N/A-", spellset_names.Width())), 15)
  spell_menu.ChangeOption(4, FF4Text(Pad("-N/A-", spellset_names.Width())), 15)
  spell_menu.ChangeOption(6, FF4Text(Pad("-N/A-", spellset_names.Width())), 15)
 else
  spell_menu.ChangeOption(2, Pad(spellset_names.ItemAt(menu_white), spellset_names.Width(), , FF4Text(" ")), 15)
  spell_menu.ChangeOption(4, Pad(spellset_names.ItemAt(menu_black), spellset_names.Width(), , FF4Text(" ")), 15)
  spell_menu.ChangeOption(6, Pad(spellset_names.ItemAt(menu_summon), spellset_names.Width(), , FF4Text(" ")), 15)
 end if
 spell_menu.Display()

end sub


sub SpellLinkMenu.SetTo(index as UByte)

 if index > usable_jobs then unusable_job = true else unusable_job = false
 white = jobs(index).white + 1
 black = jobs(index).black + 1
 summon = jobs(index).summon + 1
 menu_white = jobs(index).menu_white + 1
 menu_black = jobs(index).menu_black + 1
 menu_summon = jobs(index).menu_summon + 1

end sub


sub SpellLinkMenu.UserSelect()

 dim spellset_menu as BlueMenu
 
 spellset_menu.AddOption(FF4Text("-- none --"))
 for i as Integer = 1 to spellsets.Length()
  spellset_menu.AddOption(spellset_names.ItemAt(i))
 next
 spellset_menu.x = x + 7
 spellset_menu.max_rows = 1

 do
  spell_menu.UserSelect()
  if not spell_menu.cancelled then
   spellset_menu.y = y + 3 + (spell_menu.selected - 1) \ 2
   spellset_menu.x = x + 10 + ((spell_menu.selected - 1) mod 2) * (spellset_names.Width() + 2) - 1
   select case spell_menu.selected
    case 1
     if white > 0 then
      spellset_menu.ChangeSelected(white + 1)
     else
      spellset_menu.ChangeSelected(1)
     end if
     spellset_menu.UserSelect()
     if not spellset_menu.cancelled then 
      white = spellset_menu.selected - 1
      menu_white = white
     end if
    case 2
     if not unusable_job then
      if menu_white > 0 then
       spellset_menu.ChangeSelected(menu_white + 1)
      else
       spellset_menu.ChangeSelected(1)
      end if
      spellset_menu.UserSelect()
      if not spellset_menu.cancelled then menu_white = spellset_menu.selected - 1
     end if
    case 3
     if black > 0 then
      spellset_menu.ChangeSelected(black + 1)
     else
      spellset_menu.ChangeSelected(1)
     end if
     spellset_menu.UserSelect()
     if not spellset_menu.cancelled then 
      black = spellset_menu.selected - 1
      menu_black = black
     end if
    case 4
     if not unusable_job then
      if menu_black > 0 then
       spellset_menu.ChangeSelected(menu_black + 1)
      else
       spellset_menu.ChangeSelected(1)
      end if
      spellset_menu.UserSelect()
      if not spellset_menu.cancelled then menu_black = spellset_menu.selected - 1
     end if
    case 5
     if summon > 0 then
      spellset_menu.ChangeSelected(summon + 1)
     else
      spellset_menu.ChangeSelected(1)
     end if
     spellset_menu.UserSelect()
     if not spellset_menu.cancelled then 
      summon = spellset_menu.selected - 1
      menu_summon = summon
     end if
    case 6
     if not unusable_job then
      if menu_summon > 0 then
       spellset_menu.ChangeSelected(menu_summon + 1)
      else
       spellset_menu.ChangeSelected(1)
      end if
      spellset_menu.UserSelect()
      if not spellset_menu.cancelled then menu_summon = spellset_menu.selected - 1
     end if
   end select
   Display()
  end if
 loop until spell_menu.cancelled

end sub
