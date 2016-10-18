#include once "binarytree.bas"

type Dictionary

 contents as BinaryTree

 declare function ItemList() as List
 declare function KeyList() as List
 declare function Lookup(key as String) as String

 declare sub Assign(key as String, item as String)
 declare sub Remove(key as String)

end type


function Dictionary.ItemList() as List

 return contents.ItemList()

end function


function Dictionary.KeyList() as List

 return contents.KeyList()

end function


function Dictionary.Lookup(key as String) as String

 return contents.Lookup(key)

end function


sub Dictionary.Assign(key as String, item as String)

 if item = "" then item = " "
 contents.Insert(key, item)

end sub


sub Dictionary.Remove(key as String)

 contents.Remove(key)

end sub