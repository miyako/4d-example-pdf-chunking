Class extends Entity

Function getPageText() : Text
	
	return Substring:C12(This:C1470.page.text; This:C1470.start+1; This:C1470.end-This:C1470.start)
	
Function event afterSave($event : Object)
	
	If ($event.savedAttributes.includes("embedding"))
		
		//GOAL!
		
	Else 
		
		var $text; $model; $dataClassName; $attributeName : Text
		$text:=Substring:C12(This:C1470.page.text; This:C1470.start+1; This:C1470.end-This:C1470.start)
		
		If (This:C1470.start=0)
			//first chunk of page, get some text from previous page for context
			$text:=This:C1470.page.get_text_from_previous_page(25)+$text
		End if 
		
		$model:="nomic-embed-text-v1.5.f16.gguf"
		$dataClassName:="Chunk"  //This.getDataClass().getInfo().name
		$attributeName:="embedding"
		
		var $headers : Object
		$headers:={\
			dataClassName: $dataClassName; \
			attributeName: $attributeName; \
			primaryKey: This:C1470.getKey(dk key as string:K85:16)}
		
		var $options : cs:C1710.AIKit.OpenAIEmbeddingsParameters
		$options:=cs:C1710.AIKit.OpenAIEmbeddingsParameters.new()
		$options.formula:=Formula:C1597(worker_embedded)
		$options.extraHeaders:=$headers
		
		var $worker : 4D:C1709.Function
		$worker:=Formula:C1597(worker_embedding)
		
		CALL WORKER:C1389($worker.source; $worker; "http://127.0.0.1:8080/v1"; $text; $model; $options)
		
	End if 