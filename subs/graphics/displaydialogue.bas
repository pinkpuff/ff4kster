sub DisplayDialogue(x as UByte, y as UByte, text as String, max_boxes as UByte = 0, top_box as UByte = 1, target as Any ptr = 0, pad_names as Boolean = false)

 dim lines as List
 dim boxes as UByte
 
 lines = ParseDTE(text, pad_names)
 boxes = RoundUp(lines.Length() / 4)
 if max_boxes > 0 and boxes > max_boxes then boxes = max_boxes
 
 for i as Integer = 0 to boxes - 1
  BlueBox(x, y + i * 6, 26, 4, target)
  for j as Integer = 1 to 4
   WriteText(left(lines.ItemAt((i + top_box - 1) * 4 + j), 26), x + 1, y + i * 6 + j, 15, target)
  next
 next
 
 lines.Destroy()

end sub
