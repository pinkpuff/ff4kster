type ListNode

 contents as String
 previous_node as ListNode ptr
 next_node as ListNode ptr
 
 declare destructor()

end type

destructor ListNode()

 contents = ""

end destructor


type List

 head as ListNode ptr
 items as UInteger
 
 declare constructor()
 declare destructor()
 
 declare function ItemAt(index as UInteger) as String
 declare function Length() as UInteger
 
 declare sub Append(item as String)
 declare sub Remove(index as UInteger)

end type


constructor List()

 head = 0

end constructor


destructor List()

 do until items = 0
  Remove(1)
 loop

end destructor


function List.ItemAt(index as UInteger) as String

 dim result as String
 dim n as ListNode ptr
 
 if index > 0 then
  n = head
  for i as Integer = 1 to index - 1
   n = n->next_node
  next
  if n <> 0 then result = n->contents
 end if
 
 return result

end function


function List.Length() as UInteger

 return items

end function


sub List.Append(item as String)

 dim n as ListNode ptr
 
 if head = 0 then
  n = callocate(SizeOf(ListNode))
  n->contents = item
  head = n
 else
  n = head
  do until n->next_node = 0
   n = n->next_node
  loop
  n->next_node = callocate(SizeOf(ListNode))
  n->next_node->contents = item
  n->next_node->previous_node = n
 end if
 items += 1

end sub


sub List.Remove(index as UInteger)

 dim n as ListNode ptr
 
 if index <= Length() then
  n = head
  for i as Integer = 1 to index - 1
   n = n->next_node
  next
  if n = head then
   n = head->next_node
   head->destructor()
   deallocate(head)
   head = n
  else
   n->previous_node->next_node = n->next_node
   n->destructor()
   deallocate(n)
  end if
  items -= 1
 end if

end sub
