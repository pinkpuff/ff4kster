sub WriteDTE(s as String, x as Integer = -1, y as Integer = -1, c as UByte = 15)

 dim result as String
 dim cursor_x as Integer
 dim cursor_y as Integer
 
 if x = -1 then x = pos(0)
 if y = -1 then y = csrlin
 
 cursor_x = x
 cursor_y = y

 for i as Integer = 1 to len(s)

  select case asc(mid(s, i, 1))
  
   case &h01, &h09
    WriteText(result, cursor_x, cursor_y, c)
    cursor_x = x
    cursor_y += 1
    result = ""
      
   case &h03
    if i < len(s) then
     i += 1
     'result += FF4Text("--") + song_names.ItemAt(asc(mid(s, i, 1)) + 1) + FF4Text("--")
    end if
  
   case &h04
    if i < len(s) then
     i += 1
     result += character_names.ItemAt(asc(mid(s, i, 1)) + 1)
     do while asc(right(result, 1)) = &hFF
      result = left(result, len(result) - 1)
     loop
    end if
    
   case &h05
    if i < len(s) then
     i += 1
     WriteText(result, cursor_x, cursor_y, c)
     cursor_x = x
     'WriteText(FF4Text("--AUTO-ADVANCE--"), cursor_x, cursor_y + 1, c)
     cursor_y += 2
     result = ""
    end if
    
   case &h8A: result += FF4Text("e ")
   case &h8B: result += FF4Text(" t")
   case &h8C: result += FF4Text("th")
   case &h8D: result += FF4Text("he")
   case &h8E: result += FF4Text("t ")
   case &h8F: result += FF4Text("ou")
   case &h90: result += FF4Text(" a")
   case &h91: result += FF4Text("s ")
   case &h92: result += FF4Text("er")
   case &h93: result += FF4Text("in")
   case &h94: result += FF4Text("re")
   case &h95: result += FF4Text("d ")
   case &h96: result += FF4Text("an")
   case &h97: result += FF4Text(" o")
   case &h98: result += FF4Text("on")
   case &h99: result += FF4Text("st")
   case &h9A: result += FF4Text(" w")
   case &h9B: result += FF4Text("o ")
   case &h9C: result += FF4Text(" m")
   case &h9D: result += FF4Text("ha")
   case &h9E: result += FF4Text("to")
   case &h9F: result += FF4Text("is")
   case &hA0: result += FF4Text("yo")
   case &hA1: result += FF4Text(" y")
   case &hA2: result += FF4Text(" i")
   case &hA3: result += FF4Text("al")
   case &hA4: result += FF4Text("ar")
   case &hA5: result += FF4Text(" h")
   case &hA6: result += FF4Text("r ")
   case &hA7: result += FF4Text(" s")
   case &hA8: result += FF4Text("at")
   case &hA9: result += FF4Text("n ")
   case &hAA: result += FF4Text(" c")
   case &hAB: result += FF4Text("ng")
   case &hAC: result += FF4Text("ve")
   case &hAD: result += FF4Text("ll")
   case &hAE: result += FF4Text("y ")
   case &hAF: result += FF4Text("nd")
   case &hB0: result += FF4Text("en")
   case &hB1: result += FF4Text("ed")
   case &hB2: result += FF4Text("hi")
   case &hB3: result += FF4Text("or")
   case &hB4: result += FF4Text(", ")
   case &hB5: result += FF4Text("I ")
   case &hB6: result += FF4Text("u ")
   case &hB7: result += FF4Text("me")
   case &hB8: result += FF4Text("ta")
   case &hB9: result += FF4Text(" b")
   case &hBA: result += FF4Text(" I")
   case &hBB: result += FF4Text("te")
   case &hBC: result += FF4Text("of")
   case &hBD: result += FF4Text("ea")
   case &hBE: result += FF4Text("ur")
   case &hBF: result += FF4Text("l ")
   
   case &hCA: result += FF4Text(" f")
   case &hCB: result += FF4Text(" d")
   case &hCC: result += FF4Text("ow")
   case &hCD: result += FF4Text("se")
   case &hCE: result += FF4Text("  ")
   case &hCF: result += FF4Text("it")
   case &hD0: result += FF4Text("et")
   case &hD1: result += FF4Text("le")
   case &hD2: result += FF4Text("f ")
   case &hD3: result += FF4Text(" g")
   case &hD4: result += FF4Text("es")
   case &hD5: result += FF4Text("ro")
   case &hD6: result += FF4Text("ne")
   case &hD7: result += FF4Text("ry")
   case &hD8: result += FF4Text(" l")
   case &hD9: result += FF4Text("us")
   case &hDA: result += FF4Text("no")
   case &hDB: result += FF4Text("ut")
   case &hDC: result += FF4Text("ca")
   case &hDD: result += FF4Text("as")
   case &hDE: result += FF4Text("Th")
   case &hDF: result += FF4Text("ai")
   case &hE0: result += FF4Text("ot")
   case &hE1: result += FF4Text("be")
   case &hE2: result += FF4Text("el")
   case &hE3: result += FF4Text("om")
   case &hE4: result += FF4Text("'s")
   case &hE5: result += FF4Text("il")
   case &hE6: result += FF4Text("de")
   case &hE7: result += FF4Text("gh")
   case &hE8: result += FF4Text("ay")
   case &hE9: result += FF4Text("nt")
   case &hEA: result += FF4Text("Wh")
   case &hEB: result += FF4Text("Yo")
   case &hEC: result += FF4Text("wa")
   case &hED: result += FF4Text("oo")
   case &hEE: result += FF4Text("We")
   case &hEF: result += FF4Text("g ")
   case &hF0: result += FF4Text("ge")
   case &hF1: result += FF4Text(" n")
   case &hF2: result += FF4Text("ee")
   case &hF3: result += FF4Text("wi")
   case &hF4: result += FF4Text(" M")
   case &hF5: result += FF4Text("ke")
   case &hF6: result += FF4Text("we")
   case &hF7: result += FF4Text(" p")
   case &hF8: result += FF4Text("ig")
   case &hF9: result += FF4Text("ys")
   case &hFA: result += FF4Text(" B")
   case &hFB: result += FF4Text("am")
   case &hFC: result += FF4Text("ld")
   case &hFD: result += FF4Text(" W")
   case &hFE: result += FF4Text("la")
   
   case else: result += mid(s, i, 1)
  
  end select

 next
 
 WriteText(result, cursor_x, cursor_y, c)

end sub
