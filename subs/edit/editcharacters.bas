sub EditCharacters()

 dim select_character as BlueMenu
 dim levelup_menu as CharacterLevelUpMenu
 dim starting_menu as CharacterStartingMenu
 dim after70_menu as After70Menu
 dim edit_character as BlueMenu
 
 for i as Integer = 1 to total_characters - 1
  select_character.AddOption(character_labels.ItemAt(i))
 next
 
 edit_character.AddOption(FF4Text("Edit starting data"))
 edit_character.AddOption(FF4Text("Edit level up data"))
 edit_character.AddOption(FF4Text("Edit after 70 data"))
 edit_character.x = screen_width - edit_character.options.Width() - 2
 
 starting_menu = CharacterStartingMenu(select_character.options.Width() + 2)
 starting_menu.SetTo(1)
 starting_menu.Display()
 levelup_menu = CharacterLevelUpMenu(select_character.options.Width() + 2, starting_menu.starting_menu.options.Length() + 2)
 levelup_menu.SetTo(1)
 after70_menu = After70Menu(levelup_menu.x + levelup_menu.level_menu.options.Width() + 2, levelup_menu.y)
  
 do
  do
   starting_menu.SetTo(select_character.selected)
   starting_menu.Display()
   levelup_menu.SetTo(select_character.selected)
   levelup_menu.Display()
   after70_menu.SetTo(select_character.selected)
   after70_menu.Display()
  loop until select_character.UserInput()
  if not select_character.cancelled then
   edit_character.UserSelect()
   if not edit_character.cancelled then
    select case edit_character.selected
     case 1
      starting_menu.UserSelect()
      starting_menu.ApplyUpdates(select_character.selected)
     case 2
      levelup_menu.UserSelect()
      'levelup_menu.ApplyUpdates(select_character.selected)
     case 3
      after70_menu.UserSelect()
      after70_menu.ApplyUpdates(select_character.selected)
    end select
   end if
  end if
 loop until select_character.cancelled

end sub
