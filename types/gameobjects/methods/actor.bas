sub Actor.ReadFromROM(index as UByte)

 dim start as UInteger
 dim temp as UByte
 
 start = &h8657
 name_index = ByteAt(start + index - 1)

 start = &h0689A
 
 temp = ByteAt(start + index - 1)
 load_initial = (temp < &h80)
 load_slot = temp mod &h80
 
 start = &h0691D
 
 temp = ByteAt(start + index - 1)
 store_shadow = (temp < &h80)
 if store_shadow then store_slot = temp
 
 start = &h9FF50 + (index) * 5
 
 for i as Integer = 1 to 5
  menu_command(i) = ByteAt(start + i - 1)
 next
 
 start = &h7AD00 + (index - 1) * 7
 
 starting_gear(1) = ByteAt(start + 3)
 starting_gear(2) = ByteAt(start + 5)
 for i as Integer = 1 to 3
  starting_gear(i + 2) = ByteAt(start + i - 1)
 next
 right_ammo = ByteAt(start + 4)
 left_ammo = ByteAt(start + 6)

end sub


sub Actor.WriteToROM(index as UByte)

 dim start as UInteger
 dim temp as UByte
 
 'start = &h8657
 WriteByte(&h8657 + index - 1, name_index)
 WriteByte(&hB7D3F + index - 1, name_index)
 
 start = &h0689A
 
 temp = load_slot
 if not load_initial then temp += &h80
 WriteByte(start + index - 1, temp)
 
 start = &h0691D
 
 if store_shadow then temp = store_slot else temp = &h80
 WriteByte(start + index - 1, temp)
 
 start = &h9FF50 + (index) * 5
 
 for i as Integer = 1 to 5
  WriteByte(start + i - 1, menu_command(i))
 next
 
 start = &h7AD00 + (index - 1) * 7
 
 WriteByte(start + 3, starting_gear(1))
 WriteByte(start + 5, starting_gear(2))
 for i as Integer = 1 to 3
  WriteByte(start + i - 1, starting_gear(i + 2))
 next
 WriteByte(start + 4, right_ammo)
 WriteByte(start + 6, left_ammo)

end sub

