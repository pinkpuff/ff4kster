#include once "list.bas"
#include once "treenode.bas"

type BinaryTree

 private:

 root as TreeNode ptr

 declare function FindNode(key as String) as TreeNode ptr
 declare function Predecessor(n as TreeNode ptr) as TreeNode ptr
 declare function Successor(n as TreeNode ptr) as TreeNode ptr

 declare sub DeleteNode(n as TreeNode ptr)

 public:

 declare function ItemList(start as TreeNode ptr = 0) as List
 declare function KeyList(start as TreeNode ptr = 0) as List
 declare function Lookup(key as String) as String

 declare sub Destroy()
 declare sub Insert(key as String, item as String = "")
 declare sub MergeWith(b as BinaryTree)
 declare sub Remove(key as String)

end type


function BinaryTree.FindNode(key as String) as TreeNode ptr

 dim result as TreeNode ptr

 result = root
 do until result = 0
  if result->key = key then
   exit do
  elseif key < result->key then
   result = result->left_node
  else
   result = result->right_node
  end if
 loop

 return result

end function


function BinaryTree.Predecessor(n as TreeNode ptr) as TreeNode ptr

 dim result as TreeNode ptr

 if n->left_node > 0 then
  result = n->left_node
  do until result->right_node = 0
   result = result->right_node
  loop
 end if

 return result

end function


function BinaryTree.Successor(n as TreeNode ptr) as TreeNode ptr

 dim result as TreeNode ptr

 if n->right_node > 0 then
  result = n->right_node
  do until result->left_node = 0
   result = result->left_node
  loop
 end if

 return result

end function


sub BinaryTree.DeleteNode(n as TreeNode ptr)

 dim p as TreeNode ptr
 dim s as TreeNode ptr
 dim replacement as TreeNode ptr

 if n <> 0 then

  p = Predecessor(n)
  s = Successor(n)

  if n->left_node = 0 and n->right_node = 0 then
   if n = root then 
    root = 0
   else
    if n = n->parent->left_node then
     n->parent->left_node = 0
    else
     n->parent->right_node = 0
    end if
   end if
   deallocate(n)
  elseif n->left_node = 0 then
   if n = root then 
    n->right_node->parent = 0
    root = n->right_node
   else
    n->right_node->parent = n->parent
    if n = n->parent->left_node then
     n->parent->left_node = n->right_node
    else
     n->parent->right_node = n->right_node
    end if
   end if
   deallocate(n)
  elseif n->right_node = 0 then
   if n = root then
    n->left_node->parent = 0
    root = n->left_node
   else
    n->left_node->parent = n->parent
    if n = n->parent->left_node then
     n->parent->left_node = n->left_node
    else
     n->parent->right_node = n->left_node
    end if
   end if
   deallocate(n)
  else
   if asc(mid(lcase(n->key), 1, 1)) > 109 then
    replacement = p
   else
    replacement = s
   end if
   n->key = replacement->key
   n->contents = replacement->contents
   DeleteNode(replacement)
  end if

 end if

end sub


function BinaryTree.ItemList(start as TreeNode ptr = 0) as List

 dim result as List

 if root <> 0 then
  if start = 0 then start = root
  if start->left_node <> 0 then result = List.Merge(result, ItemList(start->left_node))
  result.Append(start->contents)
  if start->right_node <> 0 then result = List.Merge(result, ItemList(start->right_node))
 end if
 
 return result

end function


function BinaryTree.KeyList(start as TreeNode ptr = 0) as List

 dim result as List

 if root <> 0 then
  if start = 0 then start = root
  if start->left_node <> 0 then result = List.Merge(result, KeyList(start->left_node))
  result.Append(start->key)
  if start->right_node <> 0 then result = List.Merge(result, KeyList(start->right_node))
 end if
 
 return result

end function


function BinaryTree.Lookup(key as String) as String

 dim result as String
 dim n as TreeNode ptr

 n = FindNode(key)
 if n <> 0 then result = n->contents

 return result

end function


sub BinaryTree.Destroy()

 dim key_list as List = KeyList()
 
 for i as Integer = 1 to key_list.Length()
  Remove(key_list.ItemAt(i))
 next

end sub


sub BinaryTree.Insert(key as String, item as String = "")

 dim new_node as TreeNode ptr
 dim n as TreeNode ptr

 if item = "" then item = key

 if root = 0 then
  new_node = callocate(len(TreeNode))
  new_node->key = key
  new_node->contents = item
  root = new_node
 else
  n = root
  do
   if key = n->key then
    n->contents = item
    exit do
   elseif key < n->key then
    if n->left_node = 0 then
     new_node = callocate(len(TreeNode))
     new_node->key = key
     new_node->contents = item
     new_node->parent = n
     n->left_node = new_node
     exit do
    else
     n = n->left_node
    end if
   else
    if n->right_node = 0 then
     new_node = callocate(len(TreeNode))
     new_node->key = key
     new_node->contents = item
     new_node->parent = n
     n->right_node = new_node
     exit do
    else
     n = n->right_node
    end if
   end if
  loop
 end if 

end sub


sub BinaryTree.MergeWith(b as BinaryTree)

 dim item_list as List = b.ItemList()
 dim key_list as List = b.KeyList()
 
 for i as Integer = 1 to item_list.Length()
  Insert(key_list.ItemAt(i), item_list.ItemAt(i))
 next

end sub


sub BinaryTree.Remove(key as String)

 DeleteNode(FindNode(key))

end sub


