type GridLine

 x1 as Integer
 y1 as Integer
 x2 as Integer
 y2 as Integer
 
 declare constructor(starting_x1 as Integer = 0, starting_y1 as Integer = 0, starting_x2 as Integer = 0, starting_y2 as Integer = 0)
 
 declare function PointList() as List
 declare function Slope() as Double

end type


constructor GridLine(starting_x1 as Integer = 0, starting_y1 as Integer = 0, starting_x2 as Integer = 0, starting_y2 as Integer = 0)

 x1 = starting_x1
 y1 = starting_y1
 x2 = starting_x2
 y2 = starting_y2

end constructor


function GridLine.PointList() as List

 dim result as List
 dim total_error as Double
 dim line_x1 as Integer = x1
 dim line_y1 as Integer = y1
 dim line_x2 as Integer = x2
 dim line_y2 as Integer = y2
 dim steep as Boolean
 dim deltax as Integer
 dim deltay as Integer
 dim deltaerr as Double
 dim ystep as Byte
 dim y as Integer
 
 steep = abs(line_y2 - line_y1) > abs(line_x2 - line_x1)
 if steep then
  swap line_x1, line_y1
  swap line_x2, line_y2
 end if
 if line_x1 > line_x2 then
  swap line_x1, line_x2
  swap line_y1, line_y2
 end if
 deltax = line_x2 - line_x1
 deltay = abs(line_y2 - line_y1)
 total_error = 0
 deltaerr = deltay / deltax
 y = line_y1
 if line_y1 < line_y2 then ystep = 1 else ystep = -1
 for x as Integer = line_x1 to line_x2
  if steep then result.Append(str(y) + ", " + str(x)) else result.Append(str(x) + ", " + str(y))
  total_error += deltaerr
  if total_error >= 0.5 then
   y += ystep
   total_error -= 1.0
  end if
 next

 return result

end function


function GridLine.Slope() as Double

 return (y2 - y1) / (x2 - x1)

end function
