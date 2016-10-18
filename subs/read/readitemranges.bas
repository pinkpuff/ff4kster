sub ReadItemRanges()

 white_end = ByteAt(&h1CF24) - 1
 summon_start = ByteAt(&h1CF28)
 summon_end = ByteAt(&h1CF2C) - 1
 
 oob_start = ByteAt(&hB480)
 oob_end = ByteAt(&hB484) - 1

 twohanded_start = ByteAt(&hC22B)
 
 bow_start = ByteAt(&hC1BE)
 arrow_start = ByteAt(&hC286)
 arrow_end = ByteAt(&hC287)
 
 shield_start = ByteAt(&hC1C6)
 head_start = ByteAt(&hC1DC)
 body_start = ByteAt(&hC1D2)
 arms_start = ByteAt(&hC1D7)
 arms_end = ByteAt(&hC1D8)
 
 descriptions_start = ByteAt(&hA9BB)
 descriptions_end = ByteAt(&hA9BF)
 
 keyitem_start = ByteAt(&hCB30)
 keyitem_special1 = ByteAt(&hCB28)
 keyitem_special2 = ByteAt(&hCB2C)
 
 restricted_command1 = ByteAt(&h1A48F)
 restricted_command2 = ByteAt(&h1A493)
 restricted_command3 = ByteAt(&h1A497)
 command1_end = ByteAt(&h1A4F9)
 command2_start = ByteAt(&h1A50F)
 command2_end = ByteAt(&h1A513)
 command3_start = ByteAt(&h1A52B)
 command3_end = ByteAt(&h1A52F)

end sub
