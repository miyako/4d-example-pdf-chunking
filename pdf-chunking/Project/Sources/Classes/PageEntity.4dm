Class extends Entity

Function get_text_from_previous_page($percent : Real) : Text
	
	var $previousPage : cs:C1710.PageEntity
	$previousPage:=This:C1470.getDataClass().query("number == :1"; This:C1470.number-1).first()
	
	If ($previousPage#Null:C1517)
		var $text : Text
		$text:=$previousPage.text
		If ($percent<=100) && ($percent>0)
			var $length; $start : Integer
			$length:=Length:C16($text)
			$start:=$length-($length*($percent/100))
			If ($start=0)
				return $text
			End if 
			return Substring:C12($text; $start)
		End if 
		return $text
	End if 
	
Function event afterSave($event : Object)
	
	If ($event.savedAttributes.includes("text"))\
		 && (This:C1470.text#Null:C1517) && (Length:C16(This:C1470.text)#0)
		
		//$context is passed to the callback function in $2.context
		var $context : Object
		$context:={\
			dataClassName: $event.dataClassName; \
			primaryKey: This:C1470.getKey(dk key as string:K85:16)}
		
		var $worker : 4D:C1709.Function
		$worker:=Formula:C1597(worker_chunking)
		var $task : Object
		$task:={file: This:C1470.text; data: $context; capacity: "150..750"; overlap: 75; tiktoken: True:C214; compact: True:C214}
		
		CALL WORKER:C1389($worker.source; $worker; $task)
		
	Else 
		var $undropped : 4D:C1709.EntitySelection
		$undropped:=This:C1470.chunks.drop()
	End if 