sub EditItemRanges()

 dim range_menu as BlueMenu
 dim item_menu as BlueMenu
 dim spell_menu as BlueMenu
 
 range_menu.x = 15
 range_menu.y = 3
 range_menu.columns = 2
 
 item_menu.max_rows = 1
 for i as Integer = 1 to total_items
  item_menu.AddOption(item_names.ItemAt(i))
 next
 
 spell_menu.max_rows = 1
 for i as Integer = 1 to total_spells
  spell_menu.AddOption(spells(i).name)
 next
 
 do
 
  BlueBox(0, 0, 35, 1)
  WriteText(FF4Text("Feature        From       To       "), 1, 1)
  BlueBox(0, 3, 13, 13)
  WriteText(FF4Text("White"), 1, 4)
  WriteText(FF4Text("Summon"), 1, 5)
  WriteText(FF4Text("Out-of-battle"), 1, 6)
  WriteText(FF4Text("Six-letter"), 1, 7)
  WriteText(FF4Text("Two handed"), 1, 8)
  WriteText(FF4Text("Bow"), 1, 9)
  WriteText(FF4Text("Arrow"), 1, 10)
  WriteText(FF4Text("Shield"), 1, 11)
  WriteText(FF4Text("Head"), 1, 12)
  WriteText(FF4Text("Body"), 1, 13)
  WriteText(FF4Text("Arms"), 1, 14)
  WriteText(FF4Text("Descriptions"), 1, 15)
  WriteText(FF4Text("Key item"), 1, 16)
  range_menu.ChangeOption(1, FF4Text("The start"), 15)
  range_menu.ChangeOption(2, Pad(spells(white_end).name, 9,, FF4Text(" ")), 15)
  range_menu.ChangeOption(3, Pad(spells(summon_start).name, 9,, FF4Text(" ")), 15)
  range_menu.ChangeOption(4, Pad(spells(summon_end).name, 9,, FF4Text(" ")), 15)
  range_menu.ChangeOption(5, Pad(spells(oob_start).name, 9,, FF4Text(" ")), 15)
  range_menu.ChangeOption(6, Pad(spells(oob_end).name, 9,, FF4Text(" ")), 15)
  range_menu.ChangeOption(7, FF4Text("The start"), 15)
  range_menu.ChangeOption(8, Pad(spells(total_player_spells).name, 9,, FF4Text(" ")), 15)
  range_menu.ChangeOption(9, item_names.ItemAt(twohanded_start + 1), 15)
  range_menu.ChangeOption(10, item_names.ItemAt(bow_start), 15)
  range_menu.ChangeOption(11, item_names.ItemAt(bow_start + 1), 15)
  range_menu.ChangeOption(12, item_names.ItemAt(arrow_start), 15)
  range_menu.ChangeOption(13, item_names.ItemAt(arrow_start + 1), 15)
  range_menu.ChangeOption(14, item_names.ItemAt(arrow_end + 1), 15)
  range_menu.ChangeOption(15, item_names.ItemAt(shield_start + 1), 15)
  range_menu.ChangeOption(16, item_names.ItemAt(head_start), 15)
  range_menu.ChangeOption(17, item_names.ItemAt(head_start + 1), 15)
  range_menu.ChangeOption(18, item_names.ItemAt(body_start), 15)
  range_menu.ChangeOption(19, item_names.ItemAt(body_start + 1), 15)
  range_menu.ChangeOption(20, item_names.ItemAt(arms_start), 15)
  range_menu.ChangeOption(21, item_names.ItemAt(arms_start + 1), 15)
  range_menu.ChangeOption(22, item_names.ItemAt(arms_end + 1), 15)
  range_menu.ChangeOption(23, item_names.ItemAt(descriptions_start + 1), 15)
  range_menu.ChangeOption(24, item_names.ItemAt(descriptions_end), 15)
  range_menu.ChangeOption(25, item_names.ItemAt(keyitem_start + 1), 15)
  range_menu.ChangeOption(26, FF4Text("The end"), 15)
  range_menu.ChangeOption(27, item_names.ItemAt(keyitem_special1 + 1), 15)
  range_menu.ChangeOption(28, item_names.ItemAt(keyitem_special2 + 1), 15)
  range_menu.Display()
  
  range_menu.UserSelect()
  
  if not range_menu.cancelled then
  
   select case range_menu.selected
   
    case 2 'White magic end
     spell_menu.x = range_menu.x + 11
     spell_menu.y = range_menu.y
     spell_menu.ChangeSelected(white_end)
     spell_menu.UserSelect()
     if not spell_menu.cancelled then white_end = spell_menu.selected
     
    case 3 'Summon start
     spell_menu.x = range_menu.x
     spell_menu.y = range_menu.y + 1
     spell_menu.ChangeSelected(summon_start)
     spell_menu.UserSelect()
     if not spell_menu.cancelled then summon_start = spell_menu.selected
     
    case 4 'Summon end
     spell_menu.x = range_menu.x + 11
     spell_menu.y = range_menu.y + 1
     spell_menu.ChangeSelected(summon_end)
     spell_menu.UserSelect()
     if not spell_menu.cancelled then summon_end = spell_menu.selected
     
    case 5 'Out-of-battle start
     spell_menu.x = range_menu.x
     spell_menu.y = range_menu.y + 2
     spell_menu.ChangeSelected(oob_start)
     spell_menu.UserSelect()
     if not spell_menu.cancelled then oob_start = spell_menu.selected
     
    case 6 'Out-of-battle end
     spell_menu.x = range_menu.x + 11
     spell_menu.y = range_menu.y + 2
     spell_menu.ChangeSelected(oob_end)
     spell_menu.UserSelect()
     if not spell_menu.cancelled then oob_end = spell_menu.selected
   
    case 8 'six-letter end
     spell_menu.x = range_menu.x + 11
     spell_menu.y = range_menu.y + 3
     spell_menu.ChangeSelected(total_player_spells)
     spell_menu.UserSelect()
     if not spell_menu.cancelled then
      total_player_spells = spell_menu.selected
      for i as Integer = 1 to total_spells
       if i <= total_player_spells and len(spells(i).name) > 6 then spells(i).name = left(spells(i).name, 6)
       if i > total_player_spells and len(spells(i).name) < 8 then spells(i).name = Pad(spells(i).name, 8, false, FF4Text(" "))
      next
     end if

    case 9 'Two handed start
     item_menu.x = range_menu.x
     item_menu.y = range_menu.y + 3
     item_menu.ChangeSelected(twohanded_start + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then twohanded_start = item_menu.selected - 1
     
    case 10 'Two handed end
     item_menu.x = range_menu.x + 11
     item_menu.y = range_menu.y + 3
     item_menu.ChangeSelected(bow_start)
     item_menu.UserSelect()
     if not item_menu.cancelled then bow_start = item_menu.selected
     
    case 11 'Bow start
     item_menu.x = range_menu.x
     item_menu.y = range_menu.y + 4
     item_menu.ChangeSelected(bow_start + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then bow_start = item_menu.selected - 1
    
    case 12 'Bow end
     item_menu.x = range_menu.x + 11
     item_menu.y = range_menu.y + 4
     item_menu.ChangeSelected(arrow_start)
     item_menu.UserSelect()
     if not item_menu.cancelled then arrow_start = item_menu.selected
     
    case 13 'Arrow start
     item_menu.x = range_menu.x
     item_menu.y = range_menu.y + 5
     item_menu.ChangeSelected(arrow_start + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then arrow_start = item_menu.selected - 1
    
    case 14 'Arrow end
     item_menu.x = range_menu.x + 11
     item_menu.y = range_menu.y + 5
     item_menu.ChangeSelected(arrow_end + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then arrow_end = item_menu.selected - 1
     
    case 15 'Shield start
     item_menu.x = range_menu.x
     item_menu.y = range_menu.y + 6
     item_menu.ChangeSelected(shield_start + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then shield_start = item_menu.selected - 1
    
    case 16 'Shield end
     item_menu.x = range_menu.x + 11
     item_menu.y = range_menu.y + 6
     item_menu.ChangeSelected(head_start)
     item_menu.UserSelect()
     if not item_menu.cancelled then head_start = item_menu.selected
          
    case 17 'Head start
     item_menu.x = range_menu.x
     item_menu.y = range_menu.y + 7
     item_menu.ChangeSelected(head_start + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then head_start = item_menu.selected - 1
    
    case 18 'Head end
     item_menu.x = range_menu.x + 11
     item_menu.y = range_menu.y + 7
     item_menu.ChangeSelected(body_start)
     item_menu.UserSelect()
     if not item_menu.cancelled then body_start = item_menu.selected
    
    case 19 'Body start
     item_menu.x = range_menu.x
     item_menu.y = range_menu.y + 8
     item_menu.ChangeSelected(body_start + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then body_start = item_menu.selected - 1
    
    case 20 'Body end
     item_menu.x = range_menu.x + 11
     item_menu.y = range_menu.y + 8
     item_menu.ChangeSelected(arms_start)
     item_menu.UserSelect()
     if not item_menu.cancelled then arms_start = item_menu.selected
    
    case 21 'Arms start
     item_menu.x = range_menu.x
     item_menu.y = range_menu.y + 9
     item_menu.ChangeSelected(arms_start + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then arms_start = item_menu.selected - 1
    
    case 22 'Arms end
     item_menu.x = range_menu.x + 11
     item_menu.y = range_menu.y + 9
     item_menu.ChangeSelected(arms_end + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then arms_end = item_menu.selected - 1
     
    case 23 'Descriptions start
     item_menu.x = range_menu.x
     item_menu.y = range_menu.y + 10
     item_menu.ChangeSelected(descriptions_start + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then descriptions_start = item_menu.selected - 1
     for i as Integer = 1 to total_weapons
      if i >= descriptions_start and i <= descriptions_end then
       if weapons(i).description = &hFF then weapons(i).description = 0
      else
       weapons(i).description = &hFF
      end if
     next
     for i as Integer = 1 to total_armors
      if i + total_weapons + 2 > descriptions_start and i + total_weapons + 2 <= descriptions_end then
       if armors(i).description = &hFF then armors(i).description = 0
      else
       armors(i).description = &hFF
      end if
     next
     for i as Integer = 1 to total_medicines
      if i + total_weapons + total_armors + 2 > descriptions_start and i + total_weapons + total_armors + 2 <= descriptions_end then
       if medicines(i).description = &hFF then medicines(i).description = 0
      else
       medicines(i).description = &hFF
      end if
     next
     for i as Integer = 1 to total_tools
      if i + total_weapons + total_armors + total_medicines + 2 > descriptions_start and i + total_weapons + total_armors + total_medicines + 2 <= descriptions_end then
       if tools(i).description = &hFF then tools(i).description = 0
      else
       tools(i).description = &hFF
      end if
     next
    
    case 24 'Descriptions end
     item_menu.x = range_menu.x + 11
     item_menu.y = range_menu.y + 10
     item_menu.ChangeSelected(descriptions_end)
     item_menu.UserSelect()
     if not item_menu.cancelled then descriptions_end = item_menu.selected
     for i as Integer = 1 to total_weapons
      if i >= descriptions_start and i <= descriptions_end then
       if weapons(i).description = &hFF then weapons(i).description = 0
      else
       weapons(i).description = &hFF
      end if
     next
     for i as Integer = 1 to total_armors
      if i + total_weapons + 2 > descriptions_start and i + total_weapons + 2 <= descriptions_end then
       if armors(i).description = &hFF then armors(i).description = 0
      else
       armors(i).description = &hFF
      end if
     next
     for i as Integer = 1 to total_medicines
      if i + total_weapons + total_armors + 2 > descriptions_start and i + total_weapons + total_armors + 2 <= descriptions_end then
       if medicines(i).description = &hFF then medicines(i).description = 0
      else
       medicines(i).description = &hFF
      end if
     next
     for i as Integer = 1 to total_tools
      if i + total_weapons + total_armors + total_medicines + 2 > descriptions_start and i + total_weapons + total_armors + total_medicines + 2 <= descriptions_end then
       if tools(i).description = &hFF then tools(i).description = 0
      else
       tools(i).description = &hFF
      end if
     next
     
    case 25 'Key item start
     item_menu.x = range_menu.x
     item_menu.y = range_menu.y + 11
     item_menu.ChangeSelected(keyitem_start + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then keyitem_start = item_menu.selected - 1
     
    case 27 'Key item special 1
     item_menu.x = range_menu.x
     item_menu.y = range_menu.y + 12
     item_menu.ChangeSelected(keyitem_special1 + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then keyitem_special1 = item_menu.selected - 1
     
    case 28 'Key item special 2
     item_menu.x = range_menu.x + 11
     item_menu.y = range_menu.y + 12
     item_menu.ChangeSelected(keyitem_special2 + 1)
     item_menu.UserSelect()
     if not item_menu.cancelled then keyitem_special2 = item_menu.selected - 1
     
   end select
  
  end if
 
 loop until range_menu.cancelled

end sub
