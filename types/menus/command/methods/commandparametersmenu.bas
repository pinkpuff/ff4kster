constructor CommandParametersMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 'initialize variables and set up menus

 x = starting_x
 y = starting_y
 
 fight_menu = BlueMenu(x, y)
 recall_menu = BlueMenu(x, y)
 recall_menu.columns = 2
 sing_menu = BlueMenu(x, y)
 sing_menu.columns = 2
 hide_menu = BlueMenu(x, y)
 split_menu = BlueMenu(x, y)
 pray_menu = BlueMenu(x, y)
 pray_menu.columns = 2
 charge_menu = BlueMenu(x, y)
 bear_menu = BlueMenu(x, y)
 twin_menu = BlueMenu(x, y)
 boast_menu = BlueMenu(x, y)
 cry_menu = BlueMenu(x, y)
 cover_menu = BlueMenu(x, y)
 steal_menu = BlueMenu(x, y)
 regen_menu = BlueMenu(x, y)
 
 item_menu = BlueMenu(x + 8, y)
 item_menu.max_rows = 1
 for i as Integer = 1 to total_items
  item_menu.AddOption(item_names.ItemAt(i))
 next
 
 spell_menu = BlueMenu(x + 8, y)
 spell_menu.max_rows = 1
 for i as Integer = 1 to total_spells
  spell_menu.AddOption(spells(i - 1).name)
 next
 
 success_input = BlueNumberInput(x + 8, y)
 success_input.min_value = 0
 
 slot_menu = BlueMenu(x + 15, y + 3)
 slot_menu.max_rows = 1
 slot_menu.AddOption(FF4Text("Common"))
 slot_menu.AddOption(FF4Text("Uncommon"))
 slot_menu.AddOption(FF4Text("Rare"))
 slot_menu.AddOption(FF4Text("Mythic"))
 
 multiplier_menu.max_rows = 1
 multiplier_menu.AddOption(FF4Text("x0"))
 multiplier_menu.AddOption(FF4Text("x0.5"))
 multiplier_menu.AddOption(FF4Text("x1"))
 multiplier_menu.AddOption(FF4Text("x1.5"))
 multiplier_menu.AddOption(FF4Text("x2"))
 multiplier_menu.AddOption(FF4Text("x2.5"))
 multiplier_menu.AddOption(FF4Text("x3"))
 multiplier_menu.AddOption(FF4Text("x3.5"))
 multiplier_menu.AddOption(FF4Text("x4"))
 
 stat_menu.max_rows = 1
 stat_menu.AddOption(FF4Text("Flags 1"))
 stat_menu.AddOption(FF4Text("Flags 2"))
 stat_menu.AddOption(FF4Text("Level"))
 stat_menu.AddOption(FF4Text("Persistent statuses"))
 stat_menu.AddOption(FF4Text("Temporary statuses"))
 stat_menu.AddOption(FF4Text("System statuses"))
 stat_menu.AddOption(FF4Text("Hidden statuses"))
 stat_menu.AddOption(FF4Text("Current HP - low byte"))
 stat_menu.AddOption(FF4Text("Current HP - high byte"))
 stat_menu.AddOption(FF4Text("Max HP - low byte"))
 stat_menu.AddOption(FF4Text("Max HP - high byte"))
 stat_menu.AddOption(FF4Text("Current MP - low byte"))
 stat_menu.AddOption(FF4Text("Current MP - high byte"))
 stat_menu.AddOption(FF4Text("Max MP - low byte"))
 stat_menu.AddOption(FF4Text("Max MP - high byte"))
 stat_menu.AddOption(FF4Text("Base STR"))
 stat_menu.AddOption(FF4Text("Base AGI"))
 stat_menu.AddOption(FF4Text("Base VIT"))
 stat_menu.AddOption(FF4Text("Base WIS"))
 stat_menu.AddOption(FF4Text("Base WIL"))
 stat_menu.AddOption(FF4Text("Modified STR"))
 stat_menu.AddOption(FF4Text("Modified AGI"))
 stat_menu.AddOption(FF4Text("Modified VIT"))
 stat_menu.AddOption(FF4Text("Modified WIS"))
 stat_menu.AddOption(FF4Text("Modified WIL"))
 stat_menu.AddOption(FF4Text("Attack elemental"))
 stat_menu.AddOption(FF4Text("Hurts race"))
 stat_menu.AddOption(FF4Text("Attack multiplier"))
 stat_menu.AddOption(FF4Text("Hit rate"))
 stat_menu.AddOption(FF4Text("Attack base"))
 stat_menu.AddOption(FF4Text("Adds - persistent"))
 stat_menu.AddOption(FF4Text("Adds - temporary"))
 stat_menu.AddOption(FF4Text("Weaknesses"))
 stat_menu.AddOption(FF4Text("Extra-weaknesses"))
 stat_menu.AddOption(FF4Text("Magic defense multiplier"))
 stat_menu.AddOption(FF4Text("Magic defense rate"))
 stat_menu.AddOption(FF4Text("Magic defense base"))
 stat_menu.AddOption(FF4Text("Resistances"))
 stat_menu.AddOption(FF4Text("Immunities"))
 stat_menu.AddOption(FF4Text("Racial defenses"))
 stat_menu.AddOption(FF4Text("Physical defense multiplier"))
 stat_menu.AddOption(FF4Text("Physical defense rate"))
 stat_menu.AddOption(FF4Text("Physical defense base"))
 stat_menu.AddOption(FF4Text("Cancels - persistent"))
 stat_menu.AddOption(FF4Text("Cancels - temporary"))
 stat_menu.AddOption(FF4Text("Critical hit rate"))
 stat_menu.AddOption(FF4Text("Critical hit bonus damage"))
 stat_menu.AddOption(FF4Text("Steal evade?"))
 stat_menu.AddOption(FF4Text("Equipped head item"))
 stat_menu.AddOption(FF4Text("Equipped body item"))
 stat_menu.AddOption(FF4Text("Equipped arms item"))
 stat_menu.AddOption(FF4Text("Equipped right hand item"))
 stat_menu.AddOption(FF4Text("Right hand item quantity"))
 stat_menu.AddOption(FF4Text("Equipped left hand item"))
 stat_menu.AddOption(FF4Text("Left hand item quantity"))
 stat_menu.AddOption(FF4Text("Experience - low byte"))
 stat_menu.AddOption(FF4Text("Experience - mid byte"))
 stat_menu.AddOption(FF4Text("Experience - high byte"))
 stat_menu.AddOption(FF4Text("Unknown"))
 stat_menu.AddOption(FF4Text("Speed modifier"))
 stat_menu.AddOption(FF4Text("Unknown"))
 stat_menu.AddOption(FF4Text("TNL - low byte"))
 stat_menu.AddOption(FF4Text("TNL - mid byte"))
 stat_menu.AddOption(FF4Text("TNL - high byte"))
 stat_menu.AddOption(FF4Text("Races"))
 for i as Integer = 1 to 16
  stat_menu.AddOption(FF4Text("Unknown"))
 next
 stat_menu.AddOption(FF4Text("Next command"))
 stat_menu.AddOption(FF4Text("Next sub-action"))
 stat_menu.AddOption(FF4Text("Monster targets of next action"))
 stat_menu.AddOption(FF4Text("Player targets of next action"))
 for i as Integer = 5 to 15
  stat_menu.AddOption(FF4Text("Unknown"))
 next
 stat_menu.AddOption(FF4Text("Speed - low byte"))
 stat_menu.AddOption(FF4Text("Speed - high byte"))
 for i as Integer = 2 to 15
  stat_menu.AddOption(FF4Text("Unknown"))
 next
 stat_menu.AddOption(FF4Text("Level / Boss"))
 stat_menu.AddOption(FF4Text("Unknown"))
 stat_menu.AddOption(FF4Text("Unknown"))
 stat_menu.AddOption(FF4Text("Item byte"))
 for i as Integer = 4 to 15
  stat_menu.AddOption(FF4Text("Unknown"))
 next 
 
 message_menu = BlueMenu(x + 9, y + 1)
 message_menu.max_rows = 1
 message_menu.AddOption(FF4Text("-- NONE --"))
 for i as Integer = 1 to total_dialogues_alerts
  message_menu.AddOption(dialogues_alerts.ItemAt(i))
 next
 
 actor_menu = BlueMenu(x + 19, y + 6)
 actor_menu.max_rows = 1
 for i as Integer = 1 to actor_names.Length()
  actor_menu.AddOption(actor_names.ItemAt(i))
 next

end constructor


sub CommandParametersMenu.Display()

 'Updates the corresponding command's parameter menu to contain the
 ' correct information and then displays it.
 
 dim temp as String

 select case id
 
  case 1 'Fight
   fight_menu.ChangeOption(1, FF4Text("Extra-Weak to element:  ") + multiplier_menu.options.ItemAt(menucommands(1).misc_bytes(1) + 1), 15)
   fight_menu.ChangeOption(2, FF4Text("Weak to element:        ") + multiplier_menu.options.ItemAt(menucommands(1).misc_bytes(2) + 1), 15)
   fight_menu.ChangeOption(3, FF4Text("Immune to element:      ") + multiplier_menu.options.ItemAt(menucommands(1).misc_bytes(3) + 1), 15)
   fight_menu.ChangeOption(4, FF4Text("Resists element:        ") + multiplier_menu.options.ItemAt(menucommands(1).misc_bytes(4) + 1), 15)
   fight_menu.ChangeOption(5, FF4Text("Hurts race:             ") + multiplier_menu.options.ItemAt(menucommands(1).misc_bytes(5) + 1), 15)
   fight_menu.ChangeOption(6, FF4Text("Resists race:           ") + multiplier_menu.options.ItemAt(menucommands(1).misc_bytes(6) + 1), 15)
   fight_menu.ChangeOption(7, FF4Text("Add status - Attacker's ") + Pad(stat_menu.options.ItemAt((menucommands(1).misc_bytes(7) + 1) mod &h80), stat_menu.options.Width(),, FF4Text(" ")), 15)
   fight_menu.ChangeOption(8, FF4Text("           Vs. Target's ") + stat_menu.options.ItemAt(menucommands(1).misc_bytes(8) + 1), 15)
   fight_menu.Display()
 
  case 8 'Recall
   for i as Integer = 1 to 8
    recall_menu.ChangeOption(i * 2 - 1, FF4Text("Spell " + str(i) + ": ") + Pad(spells(menucommands(id).spell(i)).name, 8,, FF4Text(" ")) + FF4Text(" - "), 15)
    recall_menu.ChangeOption(i * 2, FF4Text(Pad(str(menucommands(id).success(i)), 3, true) + "/160: " + Pad(str(fix(menucommands(id).success(i)*100/160)), 3, true) + "%"), 15)
   next
   recall_menu.ChangeOption(17, FF4Text("Message: ") + message_menu.options.ItemAt((menucommands(id).message(1) + 2) mod &h100), 15)
   recall_menu.Display()
  
  case 9 'Sing
   for i as Integer = 1 to 5
    if i = 5 then temp = "" else temp = FF4Text(" - 25%")
    sing_menu.ChangeOption(i * 2 - 1, FF4Text("Spell " + str(i) + ": ") + Pad(spells(menucommands(id).spell(i)).name, 8,, FF4Text(" ")) + temp, 15)
    sing_menu.ChangeOption(i * 2, message_menu.options.ItemAt((menucommands(id).message(i) + 2) mod &h100), 15)
   next
   sing_menu.ChangeOption(11, FF4Text("If ") + Pad(stat_menu.options.ItemAt((menucommands(id).misc_bytes(1) + 1) mod &h80), stat_menu.options.Width(),, FF4Text(" ")), 15)
   select case menucommands(id).misc_bytes(1) mod &h80
    case 3
     for i as Integer = 0 to 7
      if menucommands(id).misc_bytes(2) and 2^i then temp += element_names.ItemAt(9 + i) + FF4Text(", ")
     next
     temp = left(temp, len(temp) - 2)
    case else
     temp = FF4Text(str(menucommands(id).misc_bytes(2)))
   end select
   sing_menu.ChangeOption(12, FF4Text("has value: ") + temp, 15)
   sing_menu.Display()
   
  case 10 'Hide
   hide_menu.ChangeOption(1, FF4Text("Auto-hide actor: ") + actor_names.ItemAt(menucommands(id).misc_bytes(1)), 15)
   hide_menu.Display()
  
  case 11 'Split
   split_menu.ChangeOption(1, FF4Text("Item Consumed: ") + item_names.ItemAt(menucommands(id).item_consumed + 1), 15)
   split_menu.ChangeOption(2, FF4Text("Item Effect:   ") + item_names.ItemAt(menucommands(id).item_effect + 1), 15)
   split_menu.ChangeOption(3, FF4Text("Item Visual:   ") + item_names.ItemAt(menucommands(id).item_visual + 1), 15)
   split_menu.ChangeOption(4, FF4Text("Fail message:  ") + message_menu.options.ItemAt((menucommands(id).message(1) + 2) mod &h100), 15)
   split_menu.Display()
  
  case 12 'Pray
   pray_menu.ChangeOption(1, FF4Text("Spell: ") + Pad(spells(menucommands(id).spell(1)).name, 8,, FF4Text(" ")) + FF4Text(" - "), 15)
   pray_menu.ChangeOption(2, FF4Text(Pad(str(menucommands(id).success(1)), 3, true) + "/256: " + str(fix(menucommands(id).success(1)*100/256)) + "%"), 15)
   pray_menu.ChangeOption(3, FF4Text("Message: ") + message_menu.options.ItemAt((menucommands(id).message(1) + 2) mod &h100), 15)
   pray_menu.Display()
   
  case 14 'Charge
   charge_menu.ChangeOption(1, FF4Text("Message: ") + message_menu.options.ItemAt((menucommands(id).message(1) + 2) mod &h100), 15)
   charge_menu.Display()
  
  case 16 'Bear
   bear_menu.ChangeOption(1, FF4Text("Spell:   ") + Pad(spells(menucommands(id).spell(1)).name, 8,, FF4Text(" ")), 15)
   bear_menu.ChangeOption(2, FF4Text("Message: ") + message_menu.options.ItemAt((menucommands(id).message(1) + 2) mod &h100), 15)
   bear_menu.Display()
   
  case 17 'Twin
   twin_menu.ChangeOption(1, FF4Text("Spell 1:           ") + spells(menucommands(id).spell(1)).name, 15)
   twin_menu.ChangeOption(2, FF4Text("Spell 2:           ") + spells(menucommands(id).spell(2)).name, 15)
   twin_menu.ChangeOption(3, FF4Text("Chance of spell 2: " + Pad(str(menucommands(id).success(2)), 3, true) + "/256 - " + str(fix(menucommands(id).success(2) * 100 / 256)) + "%"), 15)
   twin_menu.ChangeOption(4, FF4Text("Chance of failure: " + Pad(str(&h100 - menucommands(id).success(1)), 3, true) + "/256 - " + str(fix((&h100 - menucommands(id).success(1)) * 100 / 256)) + "%"), 15)
   twin_menu.ChangeOption(5, FF4Text("Special actor 1:   ") + Pad(actor_names.ItemAt(menucommands(id).misc_bytes(1)), actor_names.Width(),, FF4Text(" ")), 15)
   twin_menu.ChangeOption(6, FF4Text("Special actor 2:   ") + actor_names.ItemAt(menucommands(id).misc_bytes(2)), 15)
   twin_menu.ChangeOption(7, FF4Text("Special spell:     ") + spells(menucommands(id).spell(3)).name, 15)
   twin_menu.ChangeOption(8, FF4Text("Failure message:   ") + message_menu.options.ItemAt((menucommands(id).message(2) + 2) mod &h100), 15)
   twin_menu.ChangeOption(9, FF4Text("Cancel message:    ") + message_menu.options.ItemAt((menucommands(id).message(1) + 2) mod &h100), 15)
   twin_menu.Display()
   
  case 18 'Boast
   boast_menu.ChangeOption(1, FF4Text("Increase target's ") + Pad(stat_menu.options.ItemAt((menucommands(id).misc_bytes(1) + 1) mod &h80), stat_menu.options.Width(),, FF4Text(" ")), 15)
   boast_menu.ChangeOption(2, FF4Text("By " + Pad(str(menucommands(id).misc_bytes(2)), 3, true)), 15)
   boast_menu.ChangeOption(3, FF4Text("Message: ") + message_menu.options.ItemAt((menucommands(id).message(1) + 2) mod &h100), 15)
   boast_menu.Display()
   
  case 19 'Cry
   cry_menu.ChangeOption(1, FF4Text("Reduce target's ") + Pad(stat_menu.options.ItemAt((menucommands(id).misc_bytes(2) + 1) mod &h80), stat_menu.options.Width(),, FF4Text(" ")), 15)
   cry_menu.ChangeOption(2, FF4Text(" by half user's ") + Pad(stat_menu.options.ItemAt((menucommands(id).misc_bytes(1) + 1) mod &h80), stat_menu.options.Width(),, FF4Text(" ")), 15)
   cry_menu.ChangeOption(3, FF4Text("Message: ") + message_menu.options.ItemAt((menucommands(id).message(1) + 2) mod &h100), 15)
   cry_menu.Display()
   
  case 20 'Cover
   dim temp as String
   if menucommands(id).cover_by_job then temp = FF4Text("Job  ") else temp = FF4Text("Actor")
   cover_menu.ChangeOption(1, FF4Text("Cover by:           ") + temp, 15)
   if menucommands(id).cover_by_job then
    if menucommands(id).cover_actor > total_jobs then temp = FF4Text("Do not cover") else temp = jobs(menucommands(id).cover_actor).name
   else
    if menucommands(id).cover_actor > total_actors then temp = FF4Text("Do not cover") else temp = actor_names.ItemAt(menucommands(id).cover_actor)
   end if
   cover_menu.ChangeOption(2, FF4Text("Does the covering:  ") + Pad(temp, actor_names.Width(),, FF4Text(" ")), 15)
   if menucommands(id).cover_by_job then
    if menucommands(id).disable_actor > total_jobs then temp = FF4Text("Do not disable") else temp = jobs(menucommands(id).disable_actor).name
   else
    if menucommands(id).disable_actor > total_actors then temp = FF4Text("Do not disable") else temp = actor_names.ItemAt(menucommands(id).disable_actor)
   end if
   cover_menu.ChangeOption(3, FF4Text("Disable if present: ") + Pad(temp, actor_names.Width(),, FF4Text(" ")), 15)
   cover_menu.Display()
   
  case 24 'Steal
   steal_menu.ChangeOption(1, FF4Text("Base chance:   " + Pad(str(menucommands(id).misc_bytes(1)), 3)), 15)
   steal_menu.ChangeOption(2, FF4Text("   Plus user's ") + Pad(stat_menu.options.ItemAt((menucommands(id).misc_bytes(2) + 1) mod &h80), stat_menu.options.Width(),, FF4Text(" ")), 15)
   steal_menu.ChangeOption(3, FF4Text("Minus target's ") + Pad(stat_menu.options.ItemAt((menucommands(id).misc_bytes(3) + 1) mod &h80), stat_menu.options.Width(),, FF4Text(" ")), 15)
   steal_menu.ChangeOption(4, FF4Text("Steal item:    ") + Pad(slot_menu.options.ItemAt(menucommands(id).misc_bytes(4) + 1), slot_menu.options.Width()), 15)
   steal_menu.ChangeOption(5, FF4Text("'Caught' message: ") + message_menu.options.ItemAt((menucommands(id).message(1) + 2) mod &h100), 15)
   steal_menu.ChangeOption(6, FF4Text("Failure message:  ") + message_menu.options.ItemAt((menucommands(id).message(2) + 2) mod &h100), 15)
   steal_menu.ChangeOption(7, FF4Text("Success message:  ") + message_menu.options.ItemAt((menucommands(id).message(3) + 2) mod &h100), 15)
   steal_menu.Display()
  
  case 26 'Regen
   regen_menu.ChangeOption(1, FF4Text("Amount:  ") + FF4Text(Pad(str(menucommands(id).regen_amount), 3, true)), 15)
   if menucommands(id).regen_freeze then
    regen_menu.ChangeOption(2, FF4Text("Freeze:  YES"), 15)
   else
    regen_menu.ChangeOption(2, FF4Text("Freeze:  NO"), 15)
   end if
   regen_menu.ChangeOption(3, FF4Text("Message: ") + message_menu.options.ItemAt((menucommands(id).message(1) + 2) mod &h100), 15)
   regen_menu.Display()
   
 end select
 
end sub


sub CommandParametersMenu.SetTo(index as UByte)

 id = index
 
end sub


sub CommandParametersMenu.UserSelect()

 'Edit the currently selected command's parameters.
 ' Since each command is so different, this basically contains a unique
 ' process for each different command.

 select case id
   
  case 1 'Fight
   stat_menu.x = x + 24
   multiplier_menu.x = x + 24
   fight_menu.cancelled = false
   do until fight_menu.cancelled
    fight_menu.UserSelect()
    if not fight_menu.cancelled then
     select case fight_menu.selected
      case 1 to 6
       multiplier_menu.ChangeSelected(menucommands(1).misc_bytes(fight_menu.selected) + 1)
       multiplier_menu.y = y + fight_menu.selected - 1
       multiplier_menu.UserSelect()
       if not multiplier_menu.cancelled then menucommands(1).misc_bytes(fight_menu.selected) = multiplier_menu.selected - 1
      case 7 to 8
       stat_menu.ChangeSelected((menucommands(1).misc_bytes(fight_menu.selected) + 1) mod &h80)
       stat_menu.y = y + fight_menu.selected - 1
       stat_menu.UserSelect()
       if not stat_menu.cancelled then
        menucommands(1).misc_bytes(fight_menu.selected) = stat_menu.selected - 1
        if fight_menu.selected = 7 then menucommands(1).misc_bytes(fight_menu.selected) += &h80
       end if
     end select
    end if
    Display()
   loop
  
  case 8 'Recall
   recall_menu.cancelled = false
   do until recall_menu.cancelled
    recall_menu.UserSelect()
    if not recall_menu.cancelled then
     if recall_menu.selected = 17 then
      message_menu.x = x + 9
      message_menu.y = y + 8
      message_menu.ChangeSelected(menucommands(id).message(1) + 2)
      message_menu.UserSelect()
      if not message_menu.cancelled then menucommands(id).message(1) = message_menu.selected - 2
     elseif recall_menu.selected mod 2 = 1 then
      spell_menu.x = x + 9
      spell_menu.y = y + (recall_menu.selected \ 2)
      spell_menu.ChangeSelected(menucommands(id).spell((recall_menu.selected \ 2) + 1) + 1)
      spell_menu.UserSelect()
      if not spell_menu.cancelled then
       menucommands(id).spell((recall_menu.selected \ 2) + 1) = spell_menu.selected - 1
      end if
     else
      success_input.x = x + recall_menu.options.Width() + 2
      success_input.y = y + (recall_menu.selected - 1) \ 2
      success_input.max_value = 160
      success_input.starting_number = menucommands(id).success(((recall_menu.selected - 1) \ 2) + 1)
      success_input.UserSelect()
      menucommands(id).success(((recall_menu.selected - 1) \ 2) + 1) = success_input.number
     end if
    end if
    Display()
   loop
   
  case 9 'Sing
   sing_menu.cancelled = false
   do until sing_menu.cancelled
    sing_menu.UserSelect()
    if not sing_menu.cancelled then
     sing_menu.Display()
     if sing_menu.selected = 11 then
      stat_menu.x = x + 3
      stat_menu.y = y + 5
      stat_menu.ChangeSelected((menucommands(id).misc_bytes(1) mod &h80) + 1)
      stat_menu.UserSelect()
      if not stat_menu.cancelled then menucommands(id).misc_bytes(1) = &h80 + stat_menu.selected - 1
     elseif sing_menu.selected = 12 then
      select case menucommands(id).misc_bytes(1)
       case else
        success_input.x = x + sing_menu.options.Width() + 13
        success_input.y = y + 5
        success_input.max_value = &hFF
        success_input.starting_number = menucommands(id).misc_bytes(2)
        success_input.UserSelect()
        menucommands(id).misc_bytes(2) = success_input.number
      end select
     elseif sing_menu.selected mod 2 = 1 then
      spell_menu.x = x + 9
      spell_menu.y = y + sing_menu.selected \ 2
      spell_menu.ChangeSelected(menucommands(id).spell(sing_menu.selected \ 2 + 1) + 1)
      spell_menu.UserSelect()
      if not spell_menu.cancelled then
       menucommands(id).spell(sing_menu.selected \ 2 + 1) = spell_menu.selected - 1
      end if
     else
      message_menu.x = x + sing_menu.options.Width() + 2
      message_menu.y = y + sing_menu.selected \ 2 - 1
      message_menu.ChangeSelected(menucommands(id).message(sing_menu.selected \ 2) + 2)
      message_menu.UserSelect()
      if not message_menu.cancelled then menucommands(id).message(sing_menu.selected \ 2) = message_menu.selected - 2
     end if
    end if
    Display()
   loop
   
  case 10
   actor_menu.x = x + 17
   actor_menu.y = y
   actor_menu.ChangeSelected(menucommands(id).misc_bytes(1))
   actor_menu.UserSelect()
   if not actor_menu.cancelled then menucommands(id).misc_bytes(1) = actor_menu.selected
  
  case 11 'Split
   split_menu.cancelled = false
   do until split_menu.cancelled
    split_menu.UserSelect()
    if not split_menu.cancelled then
     if split_menu.selected <= 3 then
      item_menu.x = x + 15
      item_menu.y = y + split_menu.selected - 1
      select case split_menu.selected
       case 1: item_menu.ChangeSelected(menucommands(id).item_consumed + 1)
       case 2: item_menu.ChangeSelected(menucommands(id).item_effect + 1)
       case 3: item_menu.ChangeSelected(menucommands(id).item_visual + 1)
      end select
      item_menu.UserSelect()
      if not item_menu.cancelled then
       select case split_menu.selected
        case 1: menucommands(id).item_consumed = item_menu.selected - 1
        case 2: menucommands(id).item_effect = item_menu.selected - 1
        case 3: menucommands(id).item_visual = item_menu.selected - 1
       end select
      end if
     else
      message_menu.x = x + 15
      message_menu.y = y + 3
      message_menu.ChangeSelected(menucommands(id).message(1) + 2)
      message_menu.UserSelect()
      if not message_menu.cancelled then menucommands(id).message(1) = message_menu.selected - 2
     end if
    end if
    Display()
   loop
   
  case 12 'Pray
   pray_menu.cancelled = false
   do until pray_menu.cancelled
    pray_menu.UserSelect()
    if not pray_menu.cancelled then
     select case pray_menu.selected
      case 1
       spell_menu.x = x + 7
       spell_menu.y = y
       spell_menu.ChangeSelected(menucommands(id).spell(1) + 1)
       spell_menu.UserSelect()
       if not spell_menu.cancelled then
        menucommands(id).spell(1) = spell_menu.selected - 1
       end if
      case 2
       success_input.x = x + pray_menu.options.Width() + 2
       success_input.y = y
       success_input.max_value = 255
       success_input.starting_number = menucommands(id).success(1)
       success_input.UserSelect()
       menucommands(id).success(1) = success_input.number
      case 3
       message_menu.x = x + 9
       message_menu.y = y + 1
       message_menu.ChangeSelected(menucommands(id).message(1) + 2)
       message_menu.UserSelect()
       if not message_menu.cancelled then menucommands(id).message(1) = message_menu.selected - 2
     end select
    end if
    Display()
   loop
   
  case 14 'Charge
   do
    charge_menu.UserSelect()
    if not charge_menu.cancelled then
     message_menu.x = x + 9
     message_menu.y = y
     message_menu.ChangeSelected(menucommands(id).message(1) + 2)
     message_menu.UserSelect()
     if not message_menu.cancelled then menucommands(id).message(1) = message_menu.selected - 2
    end if
    Display()
   loop until charge_menu.cancelled
  
  case 16 'Bear
   bear_menu.cancelled = false
   bear_menu.UserSelect()
   if not bear_menu.cancelled then
    select case bear_menu.selected
     case 1 'Spell
      spell_menu.x = x + 9
      spell_menu.y = y
      spell_menu.ChangeSelected(menucommands(id).spell(1) + 1)
      spell_menu.UserSelect()
      if not spell_menu.cancelled then menucommands(id).spell(1) = spell_menu.selected - 1
     case 2 'Message
      message_menu.x = x + 9
      message_menu.y = y + 1
      message_menu.ChangeSelected(menucommands(id).message(1) + 2)
      message_menu.UserSelect()
      if not message_menu.cancelled then menucommands(id).message(1) = message_menu.selected - 2
    end select
   end if
   
  case 17 'Twin
   do
    twin_menu.UserSelect()
    if not twin_menu.cancelled then
     select case twin_menu.selected
      case 1 'Spell 1
       spell_menu.x = x + 19
       spell_menu.y = y
       spell_menu.ChangeSelected(menucommands(id).spell(1) + 1)
       spell_menu.UserSelect()
       if not spell_menu.cancelled then menucommands(id).spell(1) = spell_menu.selected - 1
      case 2 'Spell 2
       spell_menu.x = x + 19
       spell_menu.y = y + 1
       spell_menu.ChangeSelected(menucommands(id).spell(2) + 1)
       spell_menu.UserSelect()
       if not spell_menu.cancelled then menucommands(id).spell(2) = spell_menu.selected - 1
      case 3 'Chance of spell 2
       success_input.x = x + 19
       success_input.y = y + 2
       success_input.max_value = &hFF
       success_input.min_value = 0
       success_input.starting_number = menucommands(id).success(2)
       success_input.UserSelect()
       menucommands(id).success(2) = success_input.number
      case 4 'Chance of failure
       success_input.x = x + 19
       success_input.y = y + 3
       success_input.max_value = &h100
       success_input.min_value = 1
       success_input.starting_number = &h100 - menucommands(id).success(1)
       success_input.UserSelect()
       menucommands(id).success(1) = &h100 - success_input.number
      case 5 'Special actor 1
       actor_menu.x = x + 19
       actor_menu.y = y + 4
       actor_menu.ChangeSelected(menucommands(id).misc_bytes(1))
       actor_menu.UserSelect()
       if not actor_menu.cancelled then menucommands(id).misc_bytes(1) = actor_menu.selected
      case 6 'Special actor 2
       actor_menu.x = x + 19
       actor_menu.y = y + 5
       actor_menu.ChangeSelected(menucommands(id).misc_bytes(2))
       actor_menu.UserSelect()
       if not actor_menu.cancelled then menucommands(id).misc_bytes(2) = actor_menu.selected
      case 7 'Special spell
       spell_menu.x = x + 19
       spell_menu.y = y + 6
       spell_menu.ChangeSelected(menucommands(id).spell(3) + 1)
       spell_menu.UserSelect()
       if not spell_menu.cancelled then menucommands(id).spell(3) = spell_menu.selected - 1
      case 8 'Failure message
       message_menu.x = x + 19
       message_menu.y = y + 7
       message_menu.ChangeSelected(menucommands(id).message(2) + 2)
       message_menu.UserSelect()
       if not message_menu.cancelled then menucommands(id).message(2) = message_menu.selected - 2
      case 9 'Cancel message
       message_menu.x = x + 19
       message_menu.y = y + 8
       message_menu.ChangeSelected(menucommands(id).message(1) + 2)
       message_menu.UserSelect()
       if not message_menu.cancelled then menucommands(id).message(1) = message_menu.selected - 2
     end select
    end if
    Display()
   loop until twin_menu.cancelled
   
   
  case 18 'Boast
   boast_menu.cancelled = false
   stat_menu.x = x + 18
   stat_menu.y = y
   success_input.x = x + 3
   success_input.y = y + 1
   success_input.max_value = &hFF
   do until boast_menu.cancelled
    boast_menu.UserSelect()
    if not boast_menu.cancelled then
     select case boast_menu.selected
      case 1 'Stat
       stat_menu.ChangeSelected((menucommands(id).misc_bytes(1) + 1) mod &h80)
       stat_menu.UserSelect()
       if not stat_menu.cancelled then menucommands(id).misc_bytes(1) = stat_menu.selected - 1
      case 2 'Amount
       success_input.starting_number = menucommands(id).misc_bytes(2)
       success_input.UserSelect()
       menucommands(id).misc_bytes(2) = success_input.number
      case 3 'Message
       message_menu.x = x + 9
       message_menu.y = y + 2
       message_menu.ChangeSelected(menucommands(id).message(1) + 2)
       message_menu.UserSelect()
       if not message_menu.cancelled then menucommands(id).message(1) = message_menu.selected - 2
     end select
    end if
    Display()
   loop
   
  case 19 'Cry
   cry_menu.cancelled = false
   stat_menu.x = x + 16
   do until cry_menu.cancelled
    cry_menu.UserSelect()
    if not cry_menu.cancelled then
     select case cry_menu.selected
      case 1 'Write stat
       stat_menu.y = y
       stat_menu.ChangeSelected((menucommands(id).misc_bytes(2) + 1) mod &h80)
       stat_menu.UserSelect()
       if not stat_menu.cancelled then menucommands(id).misc_bytes(2) = stat_menu.selected - 1
      case 2 'Read stat
       stat_menu.y = y + 1
       stat_menu.ChangeSelected((menucommands(id).misc_bytes(1) + 1) mod &h80)
       stat_menu.UserSelect()
       if not stat_menu.cancelled then menucommands(id).misc_bytes(1) = stat_menu.selected - 1' + &h80
      case 3 'Message
       message_menu.x = x + 9
       message_menu.y = y + 2
       message_menu.ChangeSelected(menucommands(id).message(1) + 2)
       message_menu.UserSelect()
       if not message_menu.cancelled then menucommands(id).message(1) = message_menu.selected - 2
     end select
    end if
    Display()
   loop
   
  case 20 'Cover
   dim actor_list as BlueMenu
   dim job_list as BlueMenu
   dim current_list as BlueMenu ptr
   actor_list = BlueMenu(x + 20, y)
   actor_list.max_rows = 1
   for i as Integer = 1 to actor_names.Length()
    actor_list.AddOption(actor_names.ItemAt(i))
   next
   actor_list.AddOption(FF4Text("--none--"))
   job_list = BlueMenu(actor_list.x, actor_list.y)
   job_list.max_rows = 1
   for i as Integer = 1 to total_jobs
    job_list.AddOption(jobs(i).name)
   next
   job_list.AddOption(FF4Text("--none--"))
   do
    cover_menu.UserSelect()
    if not cover_menu.cancelled then
     select case cover_menu.selected
      case 1
       if menucommands(id).cover_by_job then
        menucommands(id).cover_by_job = false
        current_list = @actor_list
       else
        menucommands(id).cover_by_job = true
        current_list = @job_list
       end if
      case 2
       current_list->y = y + 1
       if menucommands(id).cover_actor > current_list->options.Length() then 
        current_list->ChangeSelected(current_list->options.Length())
       else
        current_list->ChangeSelected(menucommands(id).cover_actor)
       end if
       current_list->UserSelect()
       if not current_list->cancelled then 
        'if current_list->selected = current_list->options.Length() then menucommands(id).cover_actor = &h20 else menucommands(id).cover_actor = current_list->selected
        menucommands(id).cover_actor = current_list->selected
       end if
      case 3
       current_list->y = y + 2
       if menucommands(id).disable_actor >= current_list->options.Length() then 
        current_list->ChangeSelected(current_list->options.Length())
       else
        current_list->ChangeSelected(menucommands(id).disable_actor)
       end if
       current_list->UserSelect()
       if not current_list->cancelled then 
        'if current_list->selected > total_actors then menucommands(id).disable_actor = &h20 else menucommands(id).disable_actor = current_list->selected
        menucommands(id).disable_actor = current_list->selected
       end if
     end select
    end if
    Display()
   loop until cover_menu.cancelled
   
  case 24 'Steal
   steal_menu.cancelled = false
   success_input.max_value = &hFF
   success_input.x = x + 15
   success_input.y = y
   stat_menu.x = x + 15
   do until steal_menu.cancelled
    steal_menu.UserSelect()
    if not steal_menu.cancelled then
     select case steal_menu.selected
      case 1 'Base
       success_input.starting_number = menucommands(id).misc_bytes(1)
       success_input.UserSelect()
       menucommands(id).misc_bytes(1) = success_input.number
      case 2 'Bonus stat
       stat_menu.y = y + 1
       stat_menu.ChangeSelected((menucommands(id).misc_bytes(2) + 1) mod &h80)
       stat_menu.UserSelect()
       if not stat_menu.cancelled then menucommands(id).misc_bytes(2) = stat_menu.selected - 1 + &h80
      case 3 'Penalty stat
       stat_menu.y = y + 2
       stat_menu.ChangeSelected((menucommands(id).misc_bytes(3) + 1) mod &h80)
       stat_menu.UserSelect()
       if not stat_menu.cancelled then menucommands(id).misc_bytes(3) = stat_menu.selected - 1
      case 4 'Slot
       slot_menu.ChangeSelected(menucommands(id).misc_bytes(4) + 1)
       slot_menu.UserSelect()
       if not slot_menu.cancelled then menucommands(id).misc_bytes(4) = slot_menu.selected - 1
      case 5 'Caught message
       message_menu.x = x + 18
       message_menu.y = y + 4
       message_menu.ChangeSelected(menucommands(id).message(1) + 2)
       message_menu.UserSelect()
       if not message_menu.cancelled then menucommands(id).message(1) = message_menu.selected - 2
      case 6 'Failure message
       message_menu.x = x + 18
       message_menu.y = y + 5
       message_menu.ChangeSelected(menucommands(id).message(2) + 2)
       message_menu.UserSelect()
       if not message_menu.cancelled then menucommands(id).message(2) = message_menu.selected - 2
      case 7 'Success message
       message_menu.x = x + 18
       message_menu.y = y + 6
       message_menu.ChangeSelected(menucommands(id).message(3) + 2)
       message_menu.UserSelect()
       if not message_menu.cancelled then menucommands(id).message(3) = message_menu.selected - 2
     end select
    end if
    Display()
   loop
       
  case 26 'Regen
   regen_menu.cancelled = false
   do until regen_menu.cancelled
    regen_menu.UserSelect()
    if not regen_menu.cancelled then
     select case regen_menu.selected
      case 1
       success_input.x = x + 9
       success_input.y = y
       success_input.max_value = 255
       success_input.starting_number = menucommands(id).regen_amount 'menucommands(id).success(1)
       success_input.UserSelect()
       menucommands(id).regen_amount = success_input.number
      case 2
       menucommands(id).regen_freeze = not menucommands(id).regen_freeze
      case 3
       message_menu.x = x + 9
       message_menu.y = y + 2
       message_menu.ChangeSelected(menucommands(id).message(1) + 2)
       message_menu.UserSelect()
       if not message_menu.cancelled then menucommands(id).message(1) = message_menu.selected - 2
     end select      
    end if
    Display()
   loop
 
 end select
 
end sub
