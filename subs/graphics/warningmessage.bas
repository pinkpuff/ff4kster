sub WarningMessage(s as String)

 dim blank as Any ptr
 
 blank = ImageCreate((len(s) + 3) * 8, 3 * 8, RGB(0, 0, 0))
 'get (20 * 8, 1 * 8) - ((20 + len(s) + 3) * 8, (1 + 3) * 8), blank
 BlueBox(20, 1, len(s), 1)
 WriteText(s, 21, 2)
 getkey
 put (20 * 8, 1 * 8), blank, pset
 warning = true

end sub
