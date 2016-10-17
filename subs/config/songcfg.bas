sub ReadSongNames()

 dim temp as String
 
 for i as Integer = 1 to total_songs
  song_names.Append(FF4Text("Song " + Pad(str(i), 2, true, "0")))
 next
 
 open "config/songs.dat" for input as #1
  do until eof(1)
   line input #1, temp
   song_names.Assign(val(left(temp, 2)), FF4Text(mid(temp, 4)))
  loop
 close #1

end sub
