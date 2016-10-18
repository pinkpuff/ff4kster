#include once "binarytree.bas"

type Collection

 contents as BinaryTree

 declare function AmountAt(index as UInteger) as UInteger
 declare function AmountList() as List
 declare function AmountOf(item as String) as UInteger
 declare function ItemAt(index as UInteger) as String
 declare function ItemList() as List
 declare function TotalItems() as UInteger

 declare sub AddItem(item as String, amount as UInteger = 1)
 declare sub DeleteItem(item as String)
 declare sub Destroy()
 declare sub MergeWith(c as Collection)
 declare sub SubtractItem(item as String, amount as UInteger = 1)

end type


function Collection.AmountAt(index as UInteger) as UInteger

 dim l as List = AmountList()
 
 return val(l.ItemAt(index))

end function


function Collection.AmountList() as List

 return contents.ItemList()

end function


function Collection.AmountOf(item as String) as UInteger

 return val(contents.Lookup(item))

end function


function Collection.ItemAt(index as UInteger) as String

 dim l as List = ItemList()
 
 return l.ItemAt(index)

end function


function Collection.ItemList() as List

 return contents.KeyList()

end function


function Collection.TotalItems() as UInteger

 dim l as List = ItemList()
 
 return l.Length()

end function


sub Collection.AddItem(item as String, amount as UInteger = 1)

 if amount > 0 then contents.Insert(item, str(AmountOf(item) + amount))

end sub


sub Collection.DeleteItem(item as String)

 contents.Remove(item)

end sub


sub Collection.Destroy()

 contents.Destroy()

end sub


sub Collection.MergeWith(c as Collection)

 dim item_list as List = c.ItemList()
 dim amount_list as List = c.AmountList()
 
 for i as Integer = 1 to item_list.Length()
  contents.Insert(item_list.ItemAt(i), str(val(amount_list.ItemAt(i)) + AmountOf(item_list.ItemAt(i))))
 next

end sub


sub Collection.SubtractItem(item as String, amount as UInteger = 1)

 dim old_amount as UInteger

 if amount > 0 then
  old_amount = AmountOf(item)
  if old_amount > amount then
   contents.Insert(item, str(old_amount - amount))
  else
   DeleteItem(item)
  end if
 end if

end sub
