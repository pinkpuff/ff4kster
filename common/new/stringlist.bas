#include once "boolean.bas"
#include once "functions/pointerstringconversion.bas"

type List

 'private:
 
 contents as String
 items as UInteger
 indexes as UInteger ptr
 
 public:
 
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
 declare sub Remove(index as UInteger)

end type


'function List.Head() as String

 'return ItemAt(1)

'end function


'function List.IsEmpty() as Boolean

 'return (items = 0)

'end function


function List.ItemAt(index as UInteger) as String

 dim result as String = ""
 
 if index <= items then result = mid(contents, indexes[index - 1], indexes[index] - indexes[index - 1])
 
 return result

end function


'function List.Length() as UInteger

 'return items
 
'end function


'function List.PointerAt(index as UInteger) as Any ptr

 'return StringToPointer(contents[index - 1])

'end function


'function List.Slice(start as UInteger = 1, finish as UInteger = 0) as List

 'dim result as List
 
 'if start <= items then
  'if finish = 0 then finish = items
  'if start > finish then swap start, finish
  'for i as Integer = start to finish
   'result.Append(ItemAt(i))
  'next
 'end if
 
 'return result

'end function


'function List.Tail() as List

 'return Slice(2)

'end function


'function List.Width() as UInteger

 'dim result as UInteger
 'dim item as String
 
 'for i as Integer = 1 to Length()
  'item = ItemAt(i)
  'if len(item) > result then result = len(item)
 'next
 
 'return result

'end function


sub List.Append(item as String)

 if items > 0 then
  items += 1
  contents += item
  indexes = reallocate(indexes, (items + 1) * SizeOf(UInteger))
  indexes[items] = len(contents) + 1
 else
  indexes = callocate(2, SizeOf(UInteger))
  indexes[0] = 1
  contents = item
  indexes[1] = len(contents) + 1
  items = 1
 end if

end sub


'sub List.Append(item as Any ptr)

 'Append(PointerToString(item))
 
'end sub


sub List.Assign(index as UInteger, item as String)

 if index > items then
  for i as Integer = items + 1 to index - 1
   Append("")
  next
  Append(item)
 else
  '
 end if

end sub


'sub List.Assign(index as UInteger, item as Any ptr)

 'Assign(index, PointerToString(item))

'end sub


sub List.Destroy()

 deallocate(indexes)
 contents = ""
 items = 0
 
end sub


sub List.Exchange(index1 as UInteger, index2 as UInteger)

 dim temp1 as String
 dim temp2 as String
 
 temp1 = ItemAt(index1)
 temp2 = ItemAt(index2)
 
 Assign(index1, temp2)
 Assign(index2, temp1)

end sub


sub List.Remove(index as UInteger)

 if items > 0 then
  contents = left(contents, indexes[index - 1] - 1) + mid(contents, indexes[index])
  items -= 1
  indexes = reallocate(indexes, (items + 1) * SizeOf(UInteger))
  for i as Integer = index to items + 1
   indexes[i] = indexes[i + 1]
  next
 end if
 
end sub
