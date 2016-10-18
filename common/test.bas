#include "fraction.bas"

dim f as Fraction
dim d as Double

f = Fraction(3, 4)
'print f.ToString()
f.Invert()
print f.ToString()
end
f.Flip()
print f.ToString()
f.Add(Fraction(2, 3))
print f.ToString()
f.Add(1.2)
print f.ToString()