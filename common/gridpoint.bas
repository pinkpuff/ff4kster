type GridPoint

 x as Integer
 y as Integer
 
 declare constructor(starting_x as Integer = 0, starting_y as Integer = 0)
 
 declare function ToString() as String
 declare static function FromString(s as String) as GridPoint

end type


constructor GridPoint(starting_x as Integer = 0, starting_y as Integer = 0)

 x = starting_x
 y = starting_y

end constructor


function GridPoint.ToString() as String

 return str(x) + ", " + str(y)

end function


function GridPoint.FromString(s as String) as GridPoint

 dim result as GridPoint
 
 result.x = val(left(s, instr(s, ",") - 1))
 result.y = val(mid(s, instr(s, ",") + 1))
 
 return result

end function
