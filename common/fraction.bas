#include once "boolean.bas"

type Fraction

 private:

 numerator as ULongInt
 denominator as ULongInt
 sign as Byte

 declare sub Reduce()

 public:

 declare constructor(n as LongInt = 0, d as LongInt = 1)
 declare constructor(value as Double)

 declare function Decimal() as Double
 declare function Inverse() as Fraction
 declare function Reciprocal() as Fraction
 declare function ToString() as String

 declare sub Add overload (f as Fraction)
 declare sub Add overload (d as Double)
 declare sub Flip()
 declare sub Invert()
 declare sub Multiply overload (f as Fraction)
 declare sub Multiply overload (d as Double)

end type


constructor Fraction(n as LongInt = 0, d as LongInt = 1)

 numerator = abs(n)
 denominator = abs(d)
 if n < 0 xor d < 0 then sign = -1 else sign = 1
 Reduce()

end constructor


constructor Fraction(value as Double)

 dim temp as String

 temp = str(value)
 if left(temp, 1) = "-" then 
  sign = -1
  temp = right(temp, len(temp) - 1)
 else
  sign = 1
 end if
 if instr(temp, "e") > 0 then
  'dim x as Integer
  'x = val(right(temp, len(temp) - instr(temp, "e")))
  'numerator = val(left(temp, 1) + mid(temp, 3, instr(temp, "e") - 3))
  'if x < 0 then
  ' denominator = 10 ^ -x
  'else
  ' numerator *= 10 ^ x
  'end if
 elseif instr(temp, ".") > 0 then
  numerator = val(left(temp, instr(temp, ".") - 1) + right(temp, len(temp) - instr(temp, ".")))
  temp = right(temp, len(temp) - instr(temp, "."))
  denominator = 10 ^ len(temp)
 else
  numerator = val(temp)
  denominator = 1
 end if
 Reduce()
 
end constructor


function Fraction.Decimal() as Double

 return sign * numerator / denominator

end function


function Fraction.Inverse() as Fraction

 return Fraction(-1 * sign * numerator, denominator)

end function


function Fraction.Reciprocal() as Fraction

 return Fraction(sign * denominator, numerator)

end function


function Fraction.ToString() as String

 print (sign * numerator); denominator
 end

 return str(sign * numerator) + "/" + str(denominator)

end function


sub Fraction.Add(f as Fraction)

 dim f1 as Fraction
 dim f2 as Fraction

 f1 = Fraction(sign * numerator * f.denominator, denominator * f.denominator)
 f2 = Fraction(f.sign * f.numerator * denominator, denominator * f.denominator)
 denominator *= f.denominator
 numerator = abs(f1.sign * f1.numerator + f2.sign * f2.numerator)
 sign = (f1.sign * f1.numerator + f2.sign * f2.numerator) / numerator
 Reduce()

end sub


sub Fraction.Add(d as Double)

 Add(Fraction(d))

end sub


sub Fraction.Flip()

 swap numerator, denominator

end sub


sub Fraction.Invert()

 sign *= -1

end sub


sub Fraction.Multiply(f as Fraction)

 numerator *= f.numerator
 denominator *= f.denominator
 sign *= f.sign
 Reduce()

end sub


sub Fraction.Multiply(d as Double)

 Multiply(Fraction(d))

end sub


sub Fraction.Reduce()

 dim n as ULongInt
 dim d as ULongInt

 if numerator = 0 then
  denominator = 1
  sign = 1
 else
  n = numerator
  d = denominator
  do while n > 0 and d > 0
   if n > d then n -= d else d -= n
  loop
  if n > 0 then
   numerator = numerator \ n
   denominator = denominator \ n
  else
   numerator = numerator \ d
   denominator = denominator \ d
  end if
 end if

end sub