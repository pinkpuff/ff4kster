sub EditMonsters()

 dim select_monster as BlueMenu
 dim edit_monster as BlueMenu
 dim monster_info as MonsterInfoMenu
 dim monster_gfx as MonsterGfxMenu
 dim monster_stats as MonsterStatsMenu
 dim monster_drops as MonsterDropMenu
 dim monster_flags as BlueMenu
 dim attack_elements as FlagMenu
 dim resistances as FlagMenu
 dim weaknesses as FlagMenu
 dim races as FlagMenu
 dim spell_power_menu as BlueMenu
 dim ai_menu as AIMenu
 dim reaction_menu as AIMenu
 
 select_monster.max_rows = screen_height
 for i as Integer = 1 to total_monsters
  select_monster.AddOption(monsters(i).name)
 next
 
 monster_info = MonsterInfoMenu(select_monster.options.Width() + 2, 0)
 monster_gfx = MonsterGfxMenu(monster_info.x, 8)
 monster_stats = MonsterStatsMenu(monster_info.x, monster_gfx.y + 5)
 monster_drops = MonsterDropMenu(monster_info.x, monster_stats.y + 6)
 monster_flags.x = monster_info.x + 22
 monster_flags.y = monster_drops.y
 
 monster_flags.AddOption(FF4Text("Adds"))
 monster_flags.AddOption(FF4Text("Resistances"))
 monster_flags.AddOption(FF4Text("Weaknesses"))
 monster_flags.AddOption(FF4Text("Spell Power"))
 monster_flags.AddOption(FF4Text("Races"))
 monster_flags.AddOption(FF4Text("Reaction"))
 
 attack_elements = FlagMenu(monster_info.x, monster_flags.y + 8, "status")
 resistances = FlagMenu(monster_info.x, attack_elements.y + 10, "status")
 weaknesses = FlagMenu(monster_info.x, resistances.y + 10, "element")
 races = FlagMenu(weaknesses.x + weaknesses.flag_names.Width() + 2, weaknesses.y, "race")
 
 spell_power_menu.x = monster_info.x
 spell_power_menu.y = weaknesses.y + 10
 reaction_menu = AIMenu(46, 30)
 ai_menu = AIMenu(46, 0)
 
 edit_monster = BlueMenu(monster_info.x + 17, 0)
 edit_monster.AddOption(FF4Text("Edit Information"))
 edit_monster.AddOption(FF4Text("Edit Graphics"))
 edit_monster.AddOption(FF4Text("Edit AI"))
 edit_monster.AddOption(FF4Text("Edit Stats"))
 edit_monster.AddOption(FF4Text("Edit Drops"))
 edit_monster.AddOption(FF4Text("Edit Extras"))
 
 do
 
  do
  
   monster_info.SetTo(select_monster.selected)
   monster_gfx.SetTo(select_monster.selected)
   monster_stats.SetTo(select_monster.selected)
   monster_drops.SetTo(select_monster.selected)
   if monsters(select_monster.selected).has_attack_element then monster_flags.ChangeOption(1,, 14) else monster_flags.ChangeOption(1,, 0)
   if monsters(select_monster.selected).has_resistances then monster_flags.ChangeOption(2,, 14) else monster_flags.ChangeOption(2,, 0)
   if monsters(select_monster.selected).has_weaknesses then monster_flags.ChangeOption(3,, 14) else monster_flags.ChangeOption(3,, 0)
   if monsters(select_monster.selected).has_spell_power then monster_flags.ChangeOption(4,, 14) else monster_flags.ChangeOption(4,, 0)
   if monsters(select_monster.selected).has_race then monster_flags.ChangeOption(5,, 14) else monster_flags.ChangeOption(5,, 0)
   if monsters(select_monster.selected).has_reaction then monster_flags.ChangeOption(6,, 14) else monster_flags.ChangeOption(6,, 0)
   
   monster_info.Display()
   monster_gfx.Display()
   monster_stats.Display()
   monster_drops.Display()
   monster_flags.Display()
   
   ai_menu.SetTo(monsters(select_monster.selected).attack_sequence_group + 1, monsters(select_monster.selected).lunar)
   ai_menu.Display()

   if monsters(select_monster.selected).has_attack_element then 
    for i as Integer = 1 to 24
     attack_elements.SetFlag(i, monsters(select_monster.selected).attack_element.flags(i))
    next
    attack_elements.Display() 
   else
    attack_elements.Hide()
   end if

   if monsters(select_monster.selected).has_resistances then 
    for i as Integer = 1 to 24
     resistances.SetFlag(i, monsters(select_monster.selected).resistances.flags(i))
    next
    resistances.Display() 
   else
    resistances.Hide()
   end if
   
   if monsters(select_monster.selected).has_weaknesses then
    for i as Integer = 1 to 8
     weaknesses.SetFlag(i, monsters(select_monster.selected).weaknesses.flags(i))
    next
    weaknesses.Display()
   else
    weaknesses.Hide()
   end if
   
   if monsters(select_monster.selected).has_race then
    for i as Integer = 1 to 8
     races.SetFlag(i, monsters(select_monster.selected).races.flags(i))
    next
    races.Display()
   else
    races.Hide()
   end if
   
   if monsters(select_monster.selected).has_spell_power then
    spell_power_menu.ChangeOption(1, FF4Text("Spell Power: " + Pad(str(monsters(select_monster.selected).spell_power), 3)), 15)
    spell_power_menu.Display()
   else
    spell_power_menu.Hide()
   end if
   
   if monsters(select_monster.selected).has_reaction then
    reaction_menu.SetTo(monsters(select_monster.selected).reaction_index + 1, monsters(select_monster.selected).lunar)
    reaction_menu.Display()
   else
    reaction_menu.Hide()
   end if
   
  loop until select_monster.UserInput()
  
  if not select_monster.cancelled then
  
   edit_monster.UserSelect()
   
   if not edit_monster.cancelled then
   
    select case edit_monster.selected
    
     case 1 'Edit Information
      monster_info.UserSelect()
      select_monster.ChangeOption(select_monster.selected, monsters(select_monster.selected).name)
      
     case 2 'Edit Graphics
      monster_gfx.UserSelect()
     
     case 3 'Edit AI
      ai_menu.UserSelect()
      monsters(select_monster.selected).attack_sequence_group = ai_menu.index - 1
     
     case 4 'Edit Stats
      monster_stats.UserSelect()
     
     case 5 'Edit Drops
      monster_drops.UserSelect()
     
     case 6 'Edit Extras
      dim k as UInteger
      do
       monster_flags.Display()
       monster_flags.ShowCursor()
       k = getkey
       select case k
        case TAB_KEY
         select case monster_flags.selected
          
          case 1
           if monsters(select_monster.selected).has_attack_element then 
            attack_elements.UserSelect()
            for i as Integer = 1 to 24
             monsters(select_monster.selected).attack_element.flags(i) = attack_elements.flags(i)
            next
           end if
           
          case 2
           if monsters(select_monster.selected).has_resistances then
            resistances.UserSelect()
            for i as Integer = 1 to 24
             monsters(select_monster.selected).resistances.flags(i) = resistances.flags(i)
            next
           end if
           
          case 3
           if monsters(select_monster.selected).has_weaknesses then
            weaknesses.UserSelect()
            for i as Integer = 1 to 8
             monsters(select_monster.selected).weaknesses.flags(i) = weaknesses.flags(i)
            next
           end if
           
          case 4
           if monsters(select_monster.selected).has_spell_power then
            dim sp_input as BlueNumberInput
            sp_input = BlueNumberInput(spell_power_menu.x + 13, spell_power_menu.y)
            sp_input.starting_number = monsters(select_monster.selected).spell_power
            sp_input.UserSelect()
            monsters(select_monster.selected).spell_power = sp_input.number
           end if
          
          case 5
           if monsters(select_monster.selected).has_race then
            races.UserSelect()
            for i as Integer = 1 to 24
             monsters(select_monster.selected).races.flags(i) = races.flags(i)
            next
           end if
           
          case 6
           if monsters(select_monster.selected).has_reaction then
            reaction_menu.UserSelect()
            monsters(select_monster.selected).reaction_index = reaction_menu.index - 1
           end if
          
         end select
        case else
         if monster_flags.ProcessKey(k) then
          if not monster_flags.cancelled then

           select case monster_flags.selected
            case 1
             if monsters(select_monster.selected).has_attack_element then monsters(select_monster.selected).has_attack_element = false else monsters(select_monster.selected).has_attack_element = true
            case 2
             if monsters(select_monster.selected).has_resistances then monsters(select_monster.selected).has_resistances = false else monsters(select_monster.selected).has_resistances = true
            case 3
             if monsters(select_monster.selected).has_weaknesses then monsters(select_monster.selected).has_weaknesses = false else monsters(select_monster.selected).has_weaknesses = true
            case 4
             if monsters(select_monster.selected).has_spell_power then monsters(select_monster.selected).has_spell_power = false else monsters(select_monster.selected).has_spell_power = true
            case 5
             if monsters(select_monster.selected).has_race then monsters(select_monster.selected).has_race = false else monsters(select_monster.selected).has_race = true
            case 6
             if monsters(select_monster.selected).has_reaction then monsters(select_monster.selected).has_reaction = false else monsters(select_monster.selected).has_reaction = true
           end select

          end if
         end if
       end select

       if monsters(select_monster.selected).has_attack_element then monster_flags.ChangeOption(1,, 14) else monster_flags.ChangeOption(1,, 0)
       if monsters(select_monster.selected).has_resistances then monster_flags.ChangeOption(2,, 14) else monster_flags.ChangeOption(2,, 0)
       if monsters(select_monster.selected).has_weaknesses then monster_flags.ChangeOption(3,, 14) else monster_flags.ChangeOption(3,, 0)
       if monsters(select_monster.selected).has_spell_power then monster_flags.ChangeOption(4,, 14) else monster_flags.ChangeOption(4,, 0)
       if monsters(select_monster.selected).has_race then monster_flags.ChangeOption(5,, 14) else monster_flags.ChangeOption(5,, 0)
       if monsters(select_monster.selected).has_reaction then monster_flags.ChangeOption(6,, 14) else monster_flags.ChangeOption(6,, 0)

       if monsters(select_monster.selected).has_attack_element then 
        for i as Integer = 1 to 24
         attack_elements.SetFlag(i, monsters(select_monster.selected).attack_element.flags(i))
        next
        attack_elements.Display() 
       else
        attack_elements.Hide()
       end if

       if monsters(select_monster.selected).has_resistances then 
        for i as Integer = 1 to 24
         resistances.SetFlag(i, monsters(select_monster.selected).resistances.flags(i))
        next
        resistances.Display() 
       else
        resistances.Hide()
       end if
       
       if monsters(select_monster.selected).has_weaknesses then
        for i as Integer = 1 to 8
         weaknesses.SetFlag(i, monsters(select_monster.selected).weaknesses.flags(i))
        next
        weaknesses.Display()
       else
        weaknesses.Hide()
       end if
       
       if monsters(select_monster.selected).has_race then
        for i as Integer = 1 to 8
         races.SetFlag(i, monsters(select_monster.selected).races.flags(i))
        next
        races.Display()
       else
        races.Hide()
       end if
       
       if monsters(select_monster.selected).has_spell_power then
        spell_power_menu.ChangeOption(1, FF4Text("Spell Power: " + Pad(str(monsters(select_monster.selected).spell_power), 3)), 15)
        spell_power_menu.Display()
       else
        spell_power_menu.Hide()
       end if
       
       if monsters(select_monster.selected).has_reaction then
        reaction_menu.SetTo(monsters(select_monster.selected).reaction_index + 1, monsters(select_monster.selected).lunar)
        reaction_menu.Display()
       else
        reaction_menu.Hide()
       end if

      loop until monster_flags.cancelled
      monster_flags.cancelled = false
    
    end select
   
   end if
  
  end if
  
 loop until select_monster.cancelled

end sub
