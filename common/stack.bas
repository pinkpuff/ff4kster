#include once "list.bas"

type Stack

 contents as List

 declare function IsEmpty() as Boolean
 declare function Pop() as String
 declare function Top() as String

 declare sub Push(item as String)

end type


function Stack.IsEmpty() as Boolean

 return contents.IsEmpty()

end function


function Stack.Pop() as String

 dim result as String

 result = contents.Head()
 contents.Remove(1)

 return result

end function


function Stack.Top() as String

 return contents.Head()

end function


sub Stack.Push(item as String)

 contents.Prepend(item)

end sub