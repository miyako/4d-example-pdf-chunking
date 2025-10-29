Class extends Entity

Function event afterSave($event : Object)
	
	If ($event.savedAttributes.includes("data"))\
		 && (This:C1470.data#Null:C1517) && (This:C1470.data.size#0)
		
		//$context is passed to the callback function in $2.context
		var $context : Object
		$context:={\
			name: This:C1470.name; \
			extension: This:C1470.extension; \
			dataClassName: $event.dataClassName; \
			primaryKey: This:C1470.getKey(dk key as string:K85:16)}
		
		var $worker : 4D:C1709.Function
		$worker:=Formula:C1597(worker_extracting)
		var $task : Object
		$task:={file: This:C1470.data; json: True:C214; data: $context}
		
		CALL WORKER:C1389($worker.source; $worker; $task)
		
	Else 
		var $undropped : 4D:C1709.EntitySelection
		$undropped:=This:C1470.pages.drop()
	End if 