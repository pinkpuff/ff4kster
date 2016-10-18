#include once "list.bas"

type Table

 contents as List

 declare function Column(x as UInteger) as List
 declare function Height() as UInteger
 declare function ItemAt(x as UInteger, y as UInteger) as String
 declare function PointerAt(x as UInteger, y as UInteger) as Any ptr
 declare function Row(y as UInteger) as List
 declare function SubTable(x1 as UInteger, y1 as UInteger, x2 as UInteger, y2 as UInteger) as Table
 declare function Width() as UInteger

 declare sub Assign overload (x as UInteger, y as UInteger, item as String)
 declare sub Assign overload (x as UInteger, y as UInteger, item as Any ptr)
 declare sub Destroy()
 declare sub Remove(x as UInteger, y as UInteger)

end type


function Table.Column(x as UInteger) as List

 dim result as List
 dim l as List ptr

 for i as UInteger = 1 to Height()
  l = contents.PointerAt(i)
  result.Append(l->ItemAt(x))
 next

 return result

end function


function Table.Height() as UInteger

 return contents.Length()

end function


function Table.ItemAt(x as UInteger, y as UInteger) as String

 dim l as List ptr

 l = contents.PointerAt(y)

 return l->ItemAt(x)

end function


function Table.PointerAt(x as UInteger, y as UInteger) as Any ptr

 dim l as List ptr

 l = contents.PointerAt(y)

 return StringToPointer(l->ItemAt(x))

end function


function Table.Row(y as UInteger) as List

 dim l as List ptr

 l = contents.PointerAt(y)

 return *l

end function


function Table.SubTable(x1 as UInteger, y1 as UInteger, x2 as UInteger, y2 as UInteger) as Table

 dim t as Table
 dim l as List ptr
 dim temp as List ptr

 for i as UInteger = y1 to y2
  l = contents.PointerAt(i)
  temp = callocate(len(List))
  *temp = l->Slice(x1, x2)
  t.contents.Append(temp)
 next

 return t

end function


function Table.Width() as UInteger

 dim result as UInteger
 dim l as List ptr

 if contents.Length() > 0 then
  l = contents.PointerAt(1)
  result = l->Length()
 else
  result = 0
 end if
 
 return result

end function


sub Table.Assign(x as UInteger, y as UInteger, item as String)

 dim l as List ptr

 if Height() = 0 then
  l = callocate(len(List))
  contents.Append(l)
 end if

 if y > Height() then
  for i as UInteger = Height() + 1 to y
   l = callocate(len(List))
   l->Assign(Width(), "")
   contents.Append(l)
  next
 end if

 if x > Width() then
  for i as UInteger = 1 to Height()
   l = contents.PointerAt(i)
   l->Assign(x, "")
  next
 end if

 l = contents.PointerAt(y)
 l->Assign(x, item)

end sub


sub Table.Assign(x as UInteger, y as UInteger, item as Any ptr)

 Assign(x, y, PointerToString(item))

end sub


sub Table.Destroy()

 dim l as List ptr

 for i as UInteger = 1 to Height()
  l = contents.PointerAt(i)
  l->Destroy()
 next

 contents.Destroy()

end sub


sub Table.Remove(x as UInteger, y as UInteger)

 dim l as List ptr

 l = contents.PointerAt(y)
 if l <> 0 then
  l->Assign(x, "")
 end if

end sub
