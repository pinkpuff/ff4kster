type AIScriptEntry

 function_call as UByte
 parameter as UByte
 
 declare function TextDescription(include_parameter as Boolean = true) as String
 declare function FunctionToIndex() as UByte
 
 declare sub IndexToFunction(n as UByte, p as UByte = 0)
 
end type
