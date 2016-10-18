sub EditTools()

 dim select_tool as BlueMenu
 dim information_menu as ToolInformationMenu
 
 for i as Integer = 1 to total_tools
  select_tool.AddOption(tools(i).name)
 next
 
 information_menu = ToolInformationMenu(11, 0)

 do until select_tool.cancelled
 
  do
   information_menu.SetTo(select_tool.selected)
   information_menu.Display()
  loop until select_tool.UserInput()
  
  if not select_tool.cancelled then
   information_menu.UserSelect()
   tools(select_tool.selected).name = information_menu.name
   item_names.Assign(select_tool.selected + total_weapons + total_armors + total_medicines + 2, information_menu.name)
   select_tool.ChangeOption(select_tool.selected, tools(select_tool.selected).name)
   tools(select_tool.selected).price_code = information_menu.price
   tools(select_tool.selected).description = information_menu.description
  end if
 
 loop

end sub
