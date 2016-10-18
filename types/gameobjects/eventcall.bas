type CallComponent

 true_conditions as List
 false_conditions as List
 event_reference as UByte 

end type

type EventCall

 components as List
 parameters as List
 
 declare function Encode() as String
 
 declare sub Decode(s as String)

end type
