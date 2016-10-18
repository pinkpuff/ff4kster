sub BlueBox(x as UByte, y as UByte, w as UByte, h as UByte, target as Any ptr = 0)
 
 DrawLetter(box_top_left, x, y, , target)
 DrawLetter(box_top_right, x + w + 1, y, , target)
 DrawLetter(box_bottom_left, x, y + h + 1, , target)
 DrawLetter(box_bottom_right, x + w + 1, y + h + 1, , target)
 
 for i as UByte = 1 to w
  DrawLetter(box_top, x + i, y, , target)
  DrawLetter(box_bottom, x + i, y + h + 1, , target)
 next
 
 for i as UByte = 1 to h
  DrawLetter(box_left, x, y + i, , target)
  DrawLetter(box_right, x + w + 1, y + i, , target)
 next
 
 line target, ((x + 1) * 8, (y + 1) * 8)-((x + w + 1) * 8, (y + h + 1) * 8), RGB(0, 0, 96), bf
 
end sub
