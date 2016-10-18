#include once "list.bas"

type Heap

 private:

 contents as List
 priorities as List

 declare function LeftChildOf(index as UInteger) as UInteger
 declare function ParentOf(index as UInteger) as UInteger
 declare function RightChildOf(index as UInteger) as UInteger
 declare function SmallerChildOf(index as UInteger) as UInteger

 public:

 declare function IsEmpty() as Boolean
 declare function Pop() as String

 declare sub Insert(item as String, priority as Integer)

end type


function Heap.LeftChildOf(index as UInteger) as UInteger

 dim result as UInteger
 
 result = 2 * index
 if result > contents.Length() then result = 0

 return result

end function


function Heap.ParentOf(index as UInteger) as UInteger

 return index \ 2

end function


function Heap.RightChildOf(index as UInteger) as UInteger

 dim result as UInteger

 result = 2 * index + 1
 if result > contents.Length() then result = 0

 return result

end function


function Heap.SmallerChildOf(index as UInteger) as UInteger

 dim result as UInteger
 dim min as Integer

 min = val(priorities.ItemAt(index))
 if LeftChildOf(index) > 0 then
  if val(priorities.ItemAt(LeftChildOf(index))) < min then
   min = val(priorities.ItemAt(LeftChildOf(index)))
   result = LeftChildOf(index)
  end if
  if RightChildOf(index) > 0 then
   if val(priorities.ItemAt(RightChildOf(index))) < min then
    result = RightChildOf(index)
   end if
  end if
 end if

 return result

end function


function Heap.IsEmpty() as Boolean

 return contents.IsEmpty()

end function


function Heap.Pop() as String

 dim result as String
 dim current as UInteger
 dim child as UInteger

 result = contents.Head()
 contents.Remove(1)
 priorities.Remove(1)

 if contents.Length() > 0 then

  contents.Prepend(contents.ItemAt(contents.Length()))
  priorities.Prepend(priorities.ItemAt(priorities.Length()))
  contents.Remove(contents.Length())
  priorities.Remove(priorities.Length())

  current = 1
  child = SmallerChildOf(current)

  do while child > 0
   contents.Exchange(current, child)
   priorities.Exchange(current, child)
   current = child
   child = SmallerChildOf(current)
  loop

 end if

 return result

end function


sub Heap.Insert(item as String, priority as Integer)

 dim current as UInteger

 contents.Append(item)
 priorities.Append(str(priority))

 current = contents.Length()

 do while current > 1
  if priority < val(priorities.ItemAt(ParentOf(current))) then
   contents.Exchange(current, ParentOf(current))
   priorities.Exchange(current, ParentOf(current))
   current = ParentOf(current)
  else
   exit do
  end if
 loop

end sub


