#include once "list.bas"

type Queue

 contents as List

 declare function Front() as String
 declare function IsEmpty() as Boolean
 declare function Pop() as String
 declare function Size() as UInteger

 declare sub Push(item as String)

end type


function Queue.Front() as String

 return contents.Head()

end function


function Queue.IsEmpty() as Boolean

 return contents.IsEmpty()

end function


function Queue.Pop() as String

 dim result as String

 result = contents.Head()
 contents.Remove(1)

 return result

end function


function Queue.Size() as UInteger

 return contents.Length()

end function


sub Queue.Push(item as String)

 contents.Append(item)

end sub
