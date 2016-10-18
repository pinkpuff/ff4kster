constructor MonsterGfxMenu(starting_x as UByte = 0, starting_y as UByte = 0)

 dim l as List
 
 x = starting_x
 y = starting_y
 main_menu = BlueMenu(x, y)
 
 gfx_menu = BlueMenu(x + 9, y)
 gfx_menu.max_rows = 1
 l = monstergfxnames.KeyList()
 for i as Integer = 1 to l.Length()
  gfx_menu.AddOption(l.ItemAt(i))
 next
 
 size_menu = BlueMenu(x + 9, y + 1)
 size_menu.max_rows = 1
 for i as Integer = 1 to monstersizenames.Length()
  size_menu.AddOption(monstersizenames.ItemAt(i))
 next
 
 special_size_menu = BlueMenu(x + 9, y)

end constructor


sub MonsterGfxMenu.Display()

 main_menu.Display()

end sub


sub MonsterGfxMenu.SetTo(new_index as UByte)

 index = new_index
 gfx_ptr = monsters(index).gfx_ptr1 + monsters(index).gfx_ptr2 * &h100
 size = monsters(index).size
 pal = monsters(index).pal
 UpdateMenu()

end sub


sub MonsterGfxMenu.UpdateMenu()

 main_menu.ChangeOption(1, FF4Text("Pointer: " + Pad(str(gfx_ptr), 5)), 15)
 main_menu.ChangeOption(2, FF4Text("Size:    ") + monstersizenames.ItemAt(size + 1), 15)
 main_menu.ChangeOption(3, FF4Text("Palette: " + Pad(str(pal), 3)), 15)

end sub


sub MonsterGfxMenu.UserSelect()

 dim enter_byte as BlueNumberInput
 dim template_menu as BlueMenu
 dim preview as Any ptr 
 
 enter_byte = BlueNumberInput(main_menu.x + 9)
 
 template_menu = BlueMenu(x + 16, y)
 template_menu.AddOption(FF4Text("Template"))
 template_menu.AddOption(FF4Text("Manual"))

 do
 
  main_menu.UserSelect()
  
  if not main_menu.cancelled then
  
   select case main_menu.selected
   
    case 1 'Pointer
     template_menu.UserSelect()
     if not template_menu.cancelled then
     
      select case template_menu.selected
       
       case 1
        gfx_menu.UserSelect()
        if not gfx_menu.cancelled then
         gfx_ptr = val(left(monstergfxnames.Lookup(gfx_menu.options.ItemAt(gfx_menu.selected)), 5))
         size = val(mid(monstergfxnames.Lookup(gfx_menu.options.ItemAt(gfx_menu.selected)), 7))
        end if
       
       case 2
        enter_byte.y = main_menu.y
        enter_byte.max_value = &hFFFF
        enter_byte.starting_number = gfx_ptr
        enter_byte.UserSelect()
        enter_byte.max_value = &hFF
        gfx_ptr = enter_byte.number
      
      end select
     
     end if
    
    case 2 'Size
     size_menu.ChangeSelected(size + 1)
     size_menu.UserSelect()
     if not size_menu.cancelled then 
      size = size_menu.selected - 1
      if size >= &h80 and size <= &hBF then
       dim n as BlueNumberInput
       dim ss as UByte
       ss = size - &h80 + 1
       n.x = special_size_menu.x + 15
       special_size_menu.ChangeOption(1, FF4Text("X Position:    " + Pad(str(special_sizes(ss).x), 2)), 15)
       special_size_menu.ChangeOption(2, FF4Text("Mystery Amt:   " + Pad(str(special_sizes(ss).mystery_amount), 2)), 15)
       special_size_menu.ChangeOption(3, FF4Text("Size Table:    " + Pad(str(special_sizes(ss).size_table_pointer), 3)), 15)
       special_size_menu.ChangeOption(4, FF4Text("Mystery Bit 1: " + YesNo(special_sizes(ss).mystery_bit1)), 15)
       special_size_menu.ChangeOption(5, FF4Text("Mystery Bit 2: " + YesNo(special_sizes(ss).mystery_bit2)), 15)
       special_size_menu.ChangeOption(6, FF4Text("Palette:       " + Pad(str(special_sizes(ss).palette_index), 3)), 15)
       special_size_menu.ChangeOption(7, FF4Text("Mystery Byte:  " + Pad(str(special_sizes(ss).mystery_byte), 3)), 15)
       special_size_menu.ChangeOption(8, FF4Text("Arrangement:   " + Pad(str(special_sizes(ss).arrangement_pointer), 3)), 15)
       special_size_menu.TakeSnapshot()
       do
        do until special_size_menu.UserInput()
        loop
        if not special_size_menu.cancelled then
         select case special_size_menu.selected
          case 1 'X Position
           n.y = special_size_menu.y
           n.max_value = 15
           n.starting_number = special_sizes(ss).x
           n.UserSelect()
           special_sizes(ss).x = n.number
          case 2 'Mystery Amount
           n.y = special_size_menu.y + 1
           n.max_value = 15
           n.starting_number = special_sizes(ss).mystery_amount
           n.UserSelect()
           special_sizes(ss).mystery_amount = n.number
          case 3 'Size Table
           n.y = special_size_menu.y + 2
           n.max_value = 255
           n.starting_number = special_sizes(ss).size_table_pointer
           n.UserSelect()
           special_sizes(ss).size_table_pointer = n.number
          case 4 'Mystery Bit 1
           special_sizes(ss).mystery_bit1 = not special_sizes(ss).mystery_bit1
          case 5 'Mystery Bit 2
           special_sizes(ss).mystery_bit2 = not special_sizes(ss).mystery_bit2
          case 6 'Palette
           n.y = special_size_menu.y + 5
           n.max_value = total_monster_palettes - 1
           n.starting_number = special_sizes(ss).palette_index
           n.number = n.starting_number
           preview = ImageCreate(10 * 8, 3 * 8, RGB(0, 0, 0))
           do
            bluebox(0, 0, 8, 1, preview)
            for i as Integer = 0 to 7
             line preview, ((i + 1) * 8, 8)-((i + 2) * 8 - 1, 16 - 1), monster_palettes(n.number + 1, i), bf 
            next
            put ((special_size_menu.x + special_size_menu.options.Width() - 8) * 8, (special_size_menu.y - 3) * 8), preview, pset
           loop until n.UserInput()
           ImageDestroy(preview)
           preview = ImageCreate(10 * 8, 3 * 8, RGB(0, 0, 0))
           put ((special_size_menu.x + special_size_menu.options.Width() - 8) * 8, (special_size_menu.y - 3) * 8), preview, pset
           ImageDestroy(preview)
           special_sizes(ss).palette_index = n.number
          case 7 'Mystery Byte
           n.y = special_size_menu.y + 6
           n.max_value = 255
           n.starting_number = special_sizes(ss).mystery_byte
           n.UserSelect()
           special_sizes(ss).mystery_byte = n.number
          case 8 'Arrangement
           n.y = special_size_menu.y + 7
           n.max_value = 255
           n.starting_number = special_sizes(ss).arrangement_pointer
           n.UserSelect()
           special_sizes(ss).arrangement_pointer = n.number
         end select
         special_size_menu.ChangeOption(1, FF4Text("X Position:    " + Pad(str(special_sizes(ss).x), 2)), 15)
         special_size_menu.ChangeOption(2, FF4Text("Mystery Amt:   " + Pad(str(special_sizes(ss).mystery_amount), 2)), 15)
         special_size_menu.ChangeOption(3, FF4Text("Size Table:    " + Pad(str(special_sizes(ss).size_table_pointer), 3)), 15)
         special_size_menu.ChangeOption(4, FF4Text("Mystery Bit 1: " + YesNo(special_sizes(ss).mystery_bit1)), 15)
         special_size_menu.ChangeOption(5, FF4Text("Mystery Bit 2: " + YesNo(special_sizes(ss).mystery_bit2)), 15)
         special_size_menu.ChangeOption(6, FF4Text("Palette:       " + Pad(str(special_sizes(ss).palette_index), 3)), 15)
         special_size_menu.ChangeOption(7, FF4Text("Mystery Byte:  " + Pad(str(special_sizes(ss).mystery_byte), 3)), 15)
         special_size_menu.ChangeOption(8, FF4Text("Arrangement:   " + Pad(str(special_sizes(ss).arrangement_pointer), 3)), 15)
        end if
       loop until special_size_menu.cancelled
       special_size_menu.Hide()
      end if
     end if
    
    case 3 'Palette
     enter_byte.y = main_menu.y + 2
     enter_byte.max_value = total_monster_palettes - 1
     enter_byte.starting_number = pal
     enter_byte.number = enter_byte.starting_number
     preview = ImageCreate(10 * 8, 3 * 8, RGB(0, 0, 0))
     do
      bluebox(0, 0, 8, 1, preview)
      for i as Integer = 0 to 7
       line preview, ((i + 1) * 8, 8)-((i + 2) * 8 - 1, 16 - 1), monster_palettes(enter_byte.number + 1, i), bf 
      next
      put ((x + main_menu.options.Width() + 2) * 8, (enter_byte.y) * 8), preview, pset
     loop until enter_byte.UserInput()
     ImageDestroy(preview)
     preview = ImageCreate(10 * 8, 3 * 8, RGB(0, 0, 0))
     put ((x + main_menu.options.Width() + 2) * 8, (enter_byte.y) * 8), preview, pset
     ImageDestroy(preview)
     pal = enter_byte.number
   
   end select
   
   UpdateMenu()
   Display()
  
  end if
  
 loop until main_menu.cancelled
 
 monsters(index).gfx_ptr1 = gfx_ptr mod &h100
 monsters(index).gfx_ptr2 = gfx_ptr \ &h100
 monsters(index).size = size
 monsters(index).pal = pal

end sub
