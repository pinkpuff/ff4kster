sub ReadPoseNames()

 dim temp as String
 
 for i as Integer = 1 to total_poses
  pose_names.Append(FF4Text("Pose " + Pad(str(i), 2, true)))
 next
 
 open "config/poses.dat" for input as #1
  do until eof(1)
   line input #1, temp
   pose_names.Assign(val(left(temp, 2)), FF4Text(mid(temp, 4)))
  loop
 close #1

end sub

