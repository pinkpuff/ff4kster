function ParseDTE(s as String, pad_names as Boolean = false) as List

 dim result as List
 dim text as String
 
 for i as Integer = 1 to len(s)
 
  select case asc(mid(s, i, 1))
  
   case &h01, &h09
    result.Append(text)
    text = ""
      
   case &h03
    if i < len(s) then
     i += 1
    end if
  
   case &h04
    if i < len(s) then
     i += 1
     text += character_names.ItemAt(asc(mid(s, i, 1)) + 1)
     if not pad_names then
      do while asc(right(text, 1)) = &hFF
       text = left(text, len(text) - 1)
      loop
     end if
    end if
    
   case &h05
    if i < len(s) then
     i += 1
     'result.Append(text)
     'text = ""
    end if
    
   case &h8A: text += FF4Text("e ")
   case &h8B: text += FF4Text(" t")
   case &h8C: text += FF4Text("th")
   case &h8D: text += FF4Text("he")
   case &h8E: text += FF4Text("t ")
   case &h8F: text += FF4Text("ou")
   case &h90: text += FF4Text(" a")
   case &h91: text += FF4Text("s ")
   case &h92: text += FF4Text("er")
   case &h93: text += FF4Text("in")
   case &h94: text += FF4Text("re")
   case &h95: text += FF4Text("d ")
   case &h96: text += FF4Text("an")
   case &h97: text += FF4Text(" o")
   case &h98: text += FF4Text("on")
   case &h99: text += FF4Text("st")
   case &h9A: text += FF4Text(" w")
   case &h9B: text += FF4Text("o ")
   case &h9C: text += FF4Text(" m")
   case &h9D: text += FF4Text("ha")
   case &h9E: text += FF4Text("to")
   case &h9F: text += FF4Text("is")
   case &hA0: text += FF4Text("yo")
   case &hA1: text += FF4Text(" y")
   case &hA2: text += FF4Text(" i")
   case &hA3: text += FF4Text("al")
   case &hA4: text += FF4Text("ar")
   case &hA5: text += FF4Text(" h")
   case &hA6: text += FF4Text("r ")
   case &hA7: text += FF4Text(" s")
   case &hA8: text += FF4Text("at")
   case &hA9: text += FF4Text("n ")
   case &hAA: text += FF4Text(" c")
   case &hAB: text += FF4Text("ng")
   case &hAC: text += FF4Text("ve")
   case &hAD: text += FF4Text("ll")
   case &hAE: text += FF4Text("y ")
   case &hAF: text += FF4Text("nd")
   case &hB0: text += FF4Text("en")
   case &hB1: text += FF4Text("ed")
   case &hB2: text += FF4Text("hi")
   case &hB3: text += FF4Text("or")
   case &hB4: text += FF4Text(", ")
   case &hB5: text += FF4Text("I ")
   case &hB6: text += FF4Text("u ")
   case &hB7: text += FF4Text("me")
   case &hB8: text += FF4Text("ta")
   case &hB9: text += FF4Text(" b")
   case &hBA: text += FF4Text(" I")
   case &hBB: text += FF4Text("te")
   case &hBC: text += FF4Text("of")
   case &hBD: text += FF4Text("ea")
   case &hBE: text += FF4Text("ur")
   case &hBF: text += FF4Text("l ")
   
   case &hCA: text += FF4Text(" f")
   case &hCB: text += FF4Text(" d")
   case &hCC: text += FF4Text("ow")
   case &hCD: text += FF4Text("se")
   case &hCE: text += FF4Text("  ")
   case &hCF: text += FF4Text("it")
   case &hD0: text += FF4Text("et")
   case &hD1: text += FF4Text("le")
   case &hD2: text += FF4Text("f ")
   case &hD3: text += FF4Text(" g")
   case &hD4: text += FF4Text("es")
   case &hD5: text += FF4Text("ro")
   case &hD6: text += FF4Text("ne")
   case &hD7: text += FF4Text("ry")
   case &hD8: text += FF4Text(" l")
   case &hD9: text += FF4Text("us")
   case &hDA: text += FF4Text("no")
   case &hDB: text += FF4Text("ut")
   case &hDC: text += FF4Text("ca")
   case &hDD: text += FF4Text("as")
   case &hDE: text += FF4Text("Th")
   case &hDF: text += FF4Text("ai")
   case &hE0: text += FF4Text("ot")
   case &hE1: text += FF4Text("be")
   case &hE2: text += FF4Text("el")
   case &hE3: text += FF4Text("om")
   case &hE4: text += FF4Text("'s")
   case &hE5: text += FF4Text("il")
   case &hE6: text += FF4Text("de")
   case &hE7: text += FF4Text("gh")
   case &hE8: text += FF4Text("ay")
   case &hE9: text += FF4Text("nt")
   case &hEA: text += FF4Text("Wh")
   case &hEB: text += FF4Text("Yo")
   case &hEC: text += FF4Text("wa")
   case &hED: text += FF4Text("oo")
   case &hEE: text += FF4Text("We")
   case &hEF: text += FF4Text("g ")
   case &hF0: text += FF4Text("ge")
   case &hF1: text += FF4Text(" n")
   case &hF2: text += FF4Text("ee")
   case &hF3: text += FF4Text("wi")
   case &hF4: text += FF4Text(" M")
   case &hF5: text += FF4Text("ke")
   case &hF6: text += FF4Text("we")
   case &hF7: text += FF4Text(" p")
   case &hF8: text += FF4Text("ig")
   case &hF9: text += FF4Text("ys")
   case &hFA: text += FF4Text(" B")
   case &hFB: text += FF4Text("am")
   case &hFC: text += FF4Text("ld")
   case &hFD: text += FF4Text(" W")
   case &hFE: text += FF4Text("la")
   
   case else: text += mid(s, i, 1)
  
  end select
 
 next
 
 result.Append(text)
 
 return result

end function
