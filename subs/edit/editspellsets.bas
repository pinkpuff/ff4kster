sub EditSpellSets()

 dim select_spellset as BlueMenu
 dim edit_spellset as BlueMenu
 dim starting_menu as SpellSetStartingMenu
 dim learning_menu as SpellSetLearningMenu
 dim s as SpellSet ptr
 
 'select_spellset.max_rows = screen_height
 for i as Integer = 1 to spellsets.Length()
  's = spellsets.PointerAt(i)
  select_spellset.AddOption(spellset_names.ItemAt(i))
 next
 
 edit_spellset.AddOption(FF4Text("Starting spells"))
 edit_spellset.AddOption(FF4Text("Learned spells"))
 'edit_spellset.AddOption(FF4Text("Create new set"))
 edit_spellset.x = 78 - edit_spellset.options.Width()
 
 starting_menu = SpellSetStartingMenu(select_spellset.options.Width() + 2, 0)
 learning_menu = SpellSetLearningMenu(select_spellset.options.Width() + 10, 0)

 do
  
  do 
   starting_menu.SetTo(select_spellset.selected)
   learning_menu.SetTo(select_spellset.selected)
   starting_menu.Display()
   learning_menu.Display()
  loop until select_spellset.UserInput()
  
  if not select_spellset.cancelled then
  
   edit_spellset.UserSelect()
   
   if not edit_spellset.cancelled then
   
    select case edit_spellset.selected
    
     case 1 'Starting spells
      starting_menu.UserSelect()
      
     case 2 'Learning spells
      learning_menu.UserSelect()
    
     case 3 'Create new spell set
      'spellsets.Append(callocate(SizeOf(SpellSet)))
      'spellset_names.Assign(spellsets.Length(), FF4Text("Spell Set " + Pad(str(spellsets.Length()), 3, true, "0")))
      'select_spellset.AddOption(spellset_names.ItemAt(spellsets.Length()))
          
    end select
   
   end if
  
  end if
  
 loop until select_spellset.cancelled

end sub
