randomize timer

function RollDie(sides as UInteger = 6) as UInteger

 return fix(rnd * sides) + 1

end function


function RollDice(dice as UInteger, sides as UInteger = 6) as Integer

 dim result as Integer

 for i as UInteger = 1 to dice
  result += RollDie(sides)
 next

 return result

end function
