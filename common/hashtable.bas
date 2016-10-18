#include once "list.bas"

type HashTable

 private:

 items as List
 keys as List

 declare static function HashIndex(key as String) as UInteger
 declare static function LetterCode(letter as String) as UByte

 declare function ItemBucket(index as UInteger) as List ptr
 declare function KeyBucket(index as UInteger) as List ptr

 public:

 declare function KeyList() as List
 declare function Lookup(key as String) as String

 declare sub Assign(key as String, item as String)
 declare sub Remove(key as String)

end type


function HashTable.HashIndex(key as String) as UInteger

 dim result as UInteger

 for i as UInteger = 1 to len(key)
  result *= 2
  result += LetterCode(mid(key, i, 1))
 next

 return result

end function


function HashTable.LetterCode(letter as String) as UByte

 dim result as UByte

 select case asc(letter)
  case 32 to 126
   result = asc(letter) - 31
  case else
   result = 126
 end select

 return result

end function


function HashTable.ItemBucket(index as UInteger) as List ptr

 return cptr(List ptr, items.PointerAt(index))

end function


function HashTable.KeyBucket(index as UInteger) as List ptr

 return cptr(List ptr, keys.PointerAt(index))

end function


function HashTable.KeyList() as List

 dim result as List
 dim key_bucket as List ptr
 dim item_bucket as List ptr

 for i as UInteger = 1 to keys.Length()
  key_bucket = KeyBucket(i)
  if key_bucket <> 0 then
   for j as UInteger = 1 to key_bucket->Length()
    result.Append(key_bucket->ItemAt(j))
   next
  end if
 next

 return result

end function


function HashTable.Lookup(key as String) as String

 dim result as String
 dim table_index as UInteger
 dim key_bucket as List ptr
 dim item_bucket as List ptr
 
 table_index = HashIndex(key)
 key_bucket = KeyBucket(table_index)
 item_bucket = ItemBucket(table_index)

 for i as UInteger = 1 to key_bucket->Length()
  if key_bucket->ItemAt(i) = key then
   result = item_bucket->ItemAt(i)
   exit for
  end if
 next

 return result

end function


sub HashTable.Assign(key as String, item as String)

 dim table_index as UInteger
 dim key_bucket as List ptr
 dim item_bucket as List ptr
 dim found as Boolean

 table_index = HashIndex(key)
 key_bucket = KeyBucket(table_index)
 item_bucket = ItemBucket(table_index)

 for i as UInteger = 1 to key_bucket->Length()
  if key_bucket->ItemAt(i) = key then
   found = true
   item_bucket->Assign(i, item)
   exit for
  end if
 next

 if not found then
  if key_bucket->Length() = 0 then
   key_bucket = callocate(len(List))
   item_bucket = callocate(len(List))
   keys.Assign(table_index, key_bucket)
   items.Assign(table_index, item_bucket)
  end if
  key_bucket->Append(key)
  item_bucket->Append(item)
 end if

end sub


sub HashTable.Remove(key as String)

 dim table_index as UInteger
 dim key_bucket as List ptr
 dim item_bucket as List ptr
 
 table_index = HashIndex(key)
 key_bucket = KeyBucket(table_index)
 item_bucket = ItemBucket(table_index)

 for i as UInteger = 1 to key_bucket->Length()
  if key_bucket->ItemAt(i) = key then
   key_bucket->Remove(i)
   item_bucket->Remove(i)
   if key_bucket->Length() = 0 then
    keys.Assign(table_index, 0)
    items.Assign(table_index, 0)
   end if
   exit for
  end if
 next 

end sub