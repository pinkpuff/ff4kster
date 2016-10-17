function LoadROM() as String

 dim result as String
 dim temp as String
 dim file_selector as Menu
 dim total_dirs as Integer
 dim out_attrib as Integer

 do

  file_selector = Menu(1, 4)
  file_selector.max_rows = 20
  cls
  print "Select file:"
  print
  print curdir
  file_selector.AddOption("[..]")
  total_dirs = 1
  temp = Dir("*", &h10, out_attrib)
  if temp <> "" and (out_attrib and &h10) then 
   file_selector.AddOption("[" + temp + "]")
   total_dirs += 1
  end if
  do
   temp = Dir(out_attrib)
   if temp <> "" and (out_attrib and &h10) then 
    file_selector.AddOption("[" + temp + "]")
    total_dirs += 1
   end if
  loop until temp = ""
  temp = Dir("*")
  if temp <> "" then file_selector.AddOption(temp)  
  do
   temp = Dir()
   if temp <> "" then file_selector.AddOption(temp)  
  loop until temp = ""
  
  file_selector.UserSelect()
  
  if not file_selector.cancelled then
   select case file_selector.selected
    case 1 'Previous dir
     chdir("..")
    case is <= total_dirs
     chdir(mid(file_selector.options.ItemAt(file_selector.selected), 2, len(file_selector.options.ItemAt(file_selector.selected)) - 2))
    case else
     result = file_selector.options.ItemAt(file_selector.selected)
   end select
  end if
 
 loop until file_selector.cancelled or result <> ""
 
 return result

end function
