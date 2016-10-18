#include once "boolean.bas"
#include once "functions/pointerstringconversion.bas"

type List

 private:

 contents as String

 public:

 declare static function Merge(l1 as List, l2 as List) as List

 declare function Head() as String
 declare function IsEmpty() as Boolean
 declare function ItemAt(index as UInteger) as String
 declare function Length() as UInteger
 declare function PointerAt(index as UInteger) as Any ptr
 declare function Slice(start as UInteger, finish as UInteger = 0) as List
 declare function Tail() as List
 declare function Width() as UInteger

 declare sub Append overload (item as String)
 declare sub Append overload (item as Any ptr)
 declare sub Assign overload (index as UInteger, item as String)
 declare sub Assign overload (index as UInteger, item as Any ptr)
 declare sub Destroy()
 declare sub Exchange(index1 as UInteger, index2 as UInteger)
 declare sub Insert overload (index as UInteger, item as String)
 declare sub Insert overload (index as UInteger, item as Any ptr)
 declare sub Join(l as List)
 declare sub Prepend overload (item as String)
 declare sub Prepend overload (item as Any ptr)
 declare sub Remove(index as UInteger)

end type


function List.Merge(l1 as List, l2 as List) as List

 dim result as List

 result.contents = l1.contents + l2.contents

 return result

end function


function List.Head() as String

 return ItemAt(1)

end function


function List.IsEmpty() as Boolean

 return Length() = 0

end function


function List.ItemAt(index as UInteger) as String

 return *cptr(String ptr, StringToPointer(mid(contents, (index - 1) * 4 + 1, 4)))

end function


function List.Length() as UInteger

 return len(contents) \ 4

end function


function List.PointerAt(index as UInteger) as Any ptr

 return StringToPointer(mid(contents, (index - 1) * 4 + 1, 4))

end function


function List.Slice(start as UInteger, finish as UInteger = 0) as List

 dim l as List

 if start < 1 then start = 1
 if finish > Length() or finish = 0 then finish = Length()
 for i as UInteger = start to finish
  l.Append(ItemAt(i))
 next

 return l

end function


function List.Tail() as List

 return Slice(2, Length())

end function


function List.Width() as UInteger

 dim result as UInteger = 0
 dim temp as UInteger
 
 for i as Integer = 1 to Length()
  temp = len(ItemAt(i))
  if temp > result then result = temp
 next
 
 return result

end function


sub List.Append(item as String)

 Assign(Length() + 1, item)

end sub


sub List.Append(item as Any ptr)

 Assign(Length() + 1, item)

end sub


sub List.Assign(index as UInteger, item as String)

 'dim p as String ptr

 'p = callocate(sizeof(String))
 '*p = item
 'if index > Length() then
  'contents += string((index - Length() - 1) * 4, 0) + PointerToString(p)
 'else
  'dim d as String ptr
  'd = PointerAt(index)
  'deallocate(d)
  'contents = left(contents, (index - 1) * 4) + PointerToString(p) + mid(contents, index * 4 + 1)
 'end if

 dim p as String ptr

 if index > Length() then
  p = callocate(sizeof(String))
  *p = item
  contents += string((index - Length() - 1) * 4, 0) + PointerToString(p)
 else
  p = PointerAt(index)
  *p = item
  contents = left(contents, (index - 1) * 4) + PointerToString(p) + mid(contents, index * 4 + 1)
 end if

end sub


sub List.Assign(index as UInteger, item as Any ptr)

 if index > Length() then
  contents += string((index - Length() - 1) * 4, 0) + PointerToString(item)
 else
  contents = left(contents, (index - 1) * 4) + PointerToString(item) + mid(contents, index * 4 + 1)
 end if

end sub


sub List.Destroy()

 do until IsEmpty()
  Remove(1)
 loop

end sub


sub List.Exchange(index1 as UInteger, index2 as UInteger)

 dim new_contents as String

 if index1 <= Length() and index2 <= Length() and index1 <> index2 then
  if index1 > index2 then swap index1, index2
  new_contents = left(contents, (index1 - 1) * 4)
  new_contents += mid(contents, (index2 - 1) * 4 + 1, 4)
  new_contents += mid(contents, index1 * 4 + 1, (index2 - index1 - 1) * 4)
  new_contents += mid(contents, (index1 - 1) * 4 + 1, 4)
  new_contents += mid(contents, index2 * 4 + 1)
  contents = new_contents
 end if

end sub


sub List.Insert(index as UInteger, item as String)

 if index > Length() then 

  Assign(index, item)

 else

  dim p as String ptr

  p = callocate(sizeof(String))
  *p = item
  contents = left(contents, (index - 1) * 4) + PointerToString(p) + mid(contents, (index - 1) * 4 + 1)

 end if

end sub


sub List.Insert(index as UInteger, item as Any ptr)

 if index > Length() then 
  Assign(index, item)
 else
  contents = left(contents, (index - 1) * 4) + PointerToString(item) + mid(contents, (index - 1) * 4 + 1)
 end if

end sub


sub List.Join(l as List)

 contents += l.contents

end sub


sub List.Prepend(item as String)

 Insert(1, item)

end sub


sub List.Prepend(item as Any ptr)

 Insert(1, item)

end sub


sub List.Remove(index as UInteger)

 if index <= Length() then

  dim p as String ptr

  p = StringToPointer(mid(contents, (index - 1) * 4 + 1, 4))
  deallocate(p)

  contents = left(contents, (index - 1) * 4) + mid(contents, index * 4 + 1)

 end if

end sub
