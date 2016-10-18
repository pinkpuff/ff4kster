#include once "binarytree.bas"

type Set

 private:

 contents as BinaryTree

 public:

 declare static function Difference(s1 as Set, s2 as Set) as Set
 declare static function IntersectionOf(s1 as Set, s2 as Set) as Set
 declare static function Subset(small as Set, large as Set) as Boolean
 declare static function UnionOf(s1 as Set, s2 as Set) as Set

 declare function Contains(item as String) as Boolean
 declare function Enumeration() as List
 declare function IsEmpty() as Boolean
 declare function Size() as UInteger

 declare sub AddItem(item as String)
 declare sub Remove(item as String)

end type


function Set.Difference(s1 as Set, s2 as Set) as Set

 dim result as Set
 dim e as List

 result = s1
 e = s2.Enumeration()
 for i as UInteger = 1 to e.Length()
  result.Remove(e.ItemAt(i))
 next

 return result

end function


function Set.IntersectionOf(s1 as Set, s2 as Set) as Set

 dim result as Set
 dim e as List

 e = s2.Enumeration()
 for i as UInteger = 1 to e.Length()
  if s1.Contains(e.ItemAt(i)) then result.AddItem(e.ItemAt(i))
 next

 return result

end function


function Set.Subset(small as Set, large as Set) as Boolean

 dim result as Boolean
 dim e as List

 result = true
 e = small.Enumeration()
 for i as UInteger = 1 to e.Length()
  if not large.Contains(e.ItemAt(i)) then
   result = false
   exit for
  end if
 next

 return result

end function


function Set.UnionOf(s1 as Set, s2 as Set) as Set

 dim result as Set
 dim e as List

 result = s1
 e = s2.Enumeration()
 for i as UInteger = 1 to e.Length()
  result.AddItem(e.ItemAt(i))
 next

 return result

end function


function Set.Contains(item as String) as Boolean

 return contents.Lookup(item) = "T"

end function


function Set.Enumeration() as List

 return contents.KeyList()

end function


function Set.IsEmpty() as Boolean

 return Size() = 0

end function


function Set.Size() as UInteger

 dim e as List

 e = Enumeration()

 return e.Length()

end function


sub Set.AddItem(item as String)

 contents.Insert(item, "T")

end sub


sub Set.Remove(item as String)

 contents.Remove(item)

end sub