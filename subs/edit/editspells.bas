sub EditSpells()

 dim select_spell as BlueMenu
 dim edit_spell as BlueMenu
 dim effect_menu as SpellEffectMenu
 dim visual_menu as SpellVisualMenu
 dim element_menu as ElementMenu
 
 select_spell.swap_enabled = true
 select_spell.max_rows = screen_height
 for i as Integer = 1 to total_spells
  select_spell.AddOption(spells(i).name)
 next
 
 edit_spell.AddOption(FF4Text("Name"))
 edit_spell.AddOption(FF4Text("Information"))
 edit_spell.AddOption(FF4Text("Animation"))
 edit_spell.AddOption(FF4Text("Elements"))
 edit_spell.x = 78 - edit_spell.options.Width()
 
 effect_menu = SpellEffectMenu(10, 3)
 visual_menu = SpellVisualMenu(10, 15)
 element_menu = ElementMenu(10, 22)
 
 do
 
  do
  
   BlueBox(10, 0, 14, 1)
   WriteText(FF4Text("Name: ") + spells(select_spell.selected).name, 11, 1)
   effect_menu.SetTo(select_spell.selected)
   visual_menu.SetTo(select_spell.selected)
   element_menu.index = spells(select_spell.selected).element_code
   
   effect_menu.Display()
   element_menu.Display()
   visual_menu.Display()
  
  loop until select_spell.UserInput()
  
  if not select_spell.cancelled then
  
   if select_spell.highlighted > 0 then
   
    swap spells(select_spell.selected), spells(select_spell.highlighted)
    select_spell.options.Exchange(select_spell.selected, select_spell.highlighted)
    select_spell.highlighted = 0
   
   else
  
    edit_spell.cancelled = false
    edit_spell.UserSelect()
    
    if not edit_spell.cancelled then
    
     select case edit_spell.selected
      case 1 'Name
       dim name_input as BlueTextInput
       dim name_width as UByte
       name_input = BlueTextInput(16, 0)
       name_input.starting_text = spells(select_spell.selected).name
       if select_spell.selected <= total_player_spells then name_width = 6 else name_width = 8
       name_input.text_width = name_width
       name_input.UserType()
       spells(select_spell.selected).name = Pad(name_input.text, name_width,, FF4Text(" "))
       select_spell.ChangeOption(select_spell.selected, spells(select_spell.selected).name)
      
      case 2 'Information
       effect_menu.UserSelect()
       spells(select_spell.selected).casting_time = effect_menu.casting_time
       spells(select_spell.selected).target = effect_menu.target
       spells(select_spell.selected).power = effect_menu.power
       spells(select_spell.selected).hit = effect_menu.hit
       spells(select_spell.selected).effect = effect_menu.effect
       spells(select_spell.selected).mp_cost = effect_menu.mp_cost
       spells(select_spell.selected).reflectable = effect_menu.reflectable
       spells(select_spell.selected).boss = effect_menu.boss
       spells(select_spell.selected).impact = effect_menu.impact
       spells(select_spell.selected).damage = effect_menu.damage
       
      case 3 'Animation
       visual_menu.UserSelect()
       spells(select_spell.selected).sound = visual_menu.sound - 1
       spells(select_spell.selected).colors = visual_menu.colors - 1
       spells(select_spell.selected).sprites = visual_menu.sprites
       spells(select_spell.selected).visual1 = visual_menu.visual1
       spells(select_spell.selected).visual2 = visual_menu.visual2
      
      case 4 'Elements
       element_menu.UserSelect()
       spells(select_spell.selected).element_code = element_menu.index
       
     end select
     
    end if
    
   end if
  
  end if
  
 loop until select_spell.cancelled
 
 'select_spell.ClearAll()
 'edit_spell.ClearAll()

end sub
