function PlacementSpace() as UInteger

 dim result as UInteger

 for i as Integer = 1 to total_maps
  if placement_groups(i).placements.Length() > 0 then result += placement_groups(i).placements.Length() * 4 + 1
 next
 
 return result

end function
