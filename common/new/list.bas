#include once "boolean.bas"
#include once "functions/pointerstringconversion.bas"

type List

 private:
 
 contents as String ptr
 items as UInteger
 
 public:
 
 declare static function Merge(list1 as List, list2 as List) as List
 
 declare function Head() as String
 declare function IsEmpty() as Boolean
 declare function ItemAt(index as UInteger) as String
 declare function Length() as UInteger
 declare function PointerAt(index as UInteger) as Any ptr
 declare function Slice(start as UInteger = 1, finish as UInteger = 0) as List
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


function List.Merge(list1 as List, list2 as List) as List

 dim result as List
 
 result = list1
 result.Join(list2)
 
 return result

end function


function List.Head() as String

 return ItemAt(1)

end function


function List.IsEmpty() as Boolean

 return (items = 0)
 
end function


function List.ItemAt(index as UInteger) as String

 dim result as String = ""
 
 if index > 0 and index <= items then result = contents[index - 1]
 
 return result

end function


function List.Length() as UInteger

 return items

end function


function List.PointerAt(index as UInteger) as Any ptr

 return StringToPointer(ItemAt(index))

end function


function List.Slice(start as UInteger = 1, finish as UInteger = 0) as List

 dim result as List
 
 if items > 0 then
  if finish = 0 then finish = items
  if start > finish then swap start, finish
  if start <= items then
   if finish > items then finish = items
   for i as Integer = start to finish
    result.Append(ItemAt(i))
   next
  end if
 end if
 
 return result

end function


function List.Tail() as List

 return Slice(2)

end function


function List.Width() as UInteger

 dim result as UInteger
 dim temp as String
 
 for i as Integer = 1 to items
  temp = ItemAt(i)
  if len(temp) > result then result = len(temp)
 next
 
 return result

end function


sub List.Append(item as String)

 if items > 0 then
  items += 1
  contents = reallocate(contents, items * SizeOf(String))
  clear contents[items - 1], 0, SizeOf(String)
  contents[items - 1] = item
 else
  contents = callocate(SizeOf(String))
  contents[0] = item
  items = 1
 end if

end sub


sub List.Append(item as Any ptr)

 Append(PointerToString(item))

end sub


sub List.Assign(index as UInteger, item as String)

 if index > 0 then
  if index > items then
   for i as Integer = items + 1 to index - 1
    Append("")
   next
   Append(item)
  else
   contents[index - 1] = item
  end if
 end if

end sub


sub List.Assign(index as UInteger, item as Any ptr)

 Assign(index, PointerToString(item))

end sub


sub List.Destroy()

 if items > 0 then
  for i as Integer = 1 to items - 1
   contents[i] = ""
  next
  deallocate(contents)
  contents = 0
  items = 0
 end if
 
end sub


sub List.Exchange(index1 as UInteger, index2 as UInteger)

 swap contents[index1 - 1], contents[index2 - 1]

end sub


sub List.Insert(index as UInteger, item as String)

 Append(ItemAt(items))
 for i as Integer = items - 1 to index + 1 step - 1
  Assign(i, ItemAt(i - 1))
 next
 Assign(index, item)

end sub


sub List.Insert(index as UInteger, item as Any ptr)

 Insert(index, PointerToString(item))

end sub


sub List.Join(l as List)

 for i as Integer = 1 to l.Length()
  Append(l.ItemAt(i))
 next

end sub


sub List.Prepend(item as String)

 Insert(1, item)

end sub


sub List.Prepend(item as Any ptr)

 Insert(1, item)
 
end sub


sub List.Remove(index as UInteger)

 if items > 0 and index <= items then
  items -= 1
  contents[index - 1] = ""
  for i as Integer = index - 1 to items - 1
   contents[i] = contents[i + 1]
  next
  contents = reallocate(contents, items * SizeOf(String))
 end if
 
end sub
