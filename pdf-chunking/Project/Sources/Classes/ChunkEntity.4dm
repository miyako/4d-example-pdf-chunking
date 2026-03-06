Class extends Entity

Function getPageText() : Text
	
	return Substring:C12(This:C1470.page.text; This:C1470.start+1; This:C1470.end-This:C1470.start)
	
Function event afterSave($event : Object)
	
	If ($event.savedAttributes.includes("embedding"))
		
		//GOAL!
		
	Else 
		
		daemon_embeddings
		
		If (False:C215)
			
			//var $text; $model; $dataClassName; $attributeName : Text
			//$text:=Substring(This.page.text; This.start+1; This.end-This.start)
			
			//If (This.start=0)
			////first chunk of page, get some text from previous page for context
			//$text:=This.page.get_text_from_previous_page(25)+$text
			//End if 
			
			//$model:="default"
			//$dataClassName:="Chunk"  //This.getDataClass().getInfo().name
			//$attributeName:="embedding"
			
			//var $headers : Object
			//$headers:={\
				dataClassName: $dataClassName; \
				attributeName: $attributeName; \
				primaryKey: This.getKey(dk key as string)}
			
			//var $options : cs.AIKit.OpenAIEmbeddingsParameters
			//$options:=cs.AIKit.OpenAIEmbeddingsParameters.new()
			//$options.formula:=Formula(worker_embedded)
			//$options.extraHeaders:=$headers
			
			//var $worker : 4D.Function
			//$worker:=Formula(worker_embedding)
			
			//var $max_process_for_aikit : Integer
			//$max_process_for_aikit:=20
			//var $workerName : Text
			//$workerName:=[$worker.source; String(Random%$max_process_for_aikit; "000")].join("#")
			
			//CALL WORKER($workerName; $worker; "http://127.0.0.1:8080/v1"; $text; $model; $options)
			
		End if 
		
	End if 