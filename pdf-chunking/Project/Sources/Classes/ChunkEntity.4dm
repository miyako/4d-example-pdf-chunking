Class extends Entity

Function getPageText() : Text
	
	return Substring:C12(This:C1470.page.text; This:C1470.start+1; This:C1470.end-This:C1470.start)
	
Function event afterSave($event : Object)
	
	var $AIClient : cs:C1710.AIKit.OpenAI
	$AIClient:=cs:C1710.AIKit.OpenAI.new()
	$AIClient.baseURL:="http://127.0.0.1:8080/v1"
	$model:="nomic-embed-text-v1.5.f16.gguf"
	
	var $headers : Object
	$headers:={\
		dataClassName: This:C1470.getDataClass().getInfo().name; \
		attributeName: "embedding"; \
		primaryKey: This:C1470.getKey(dk key as string:K85:16)}
	
	var $options : cs:C1710.AIKit.OpenAIEmbeddingsParameters
	$options:=cs:C1710.AIKit.OpenAIEmbeddingsParameters.new()
	$options.formula:=Formula:C1597(worker_embedding)
	$options.extraHeaders:=$headers
	
	var $text : Text
	$text:=Substring:C12(This:C1470.page.text; This:C1470.start+1; This:C1470.end-This:C1470.start)
	
	If (This:C1470.start=0)
		//first chunk of page, get some text from previous page for context
		$text:=This:C1470.page.get_text_from_previous_page(25)+$text
	End if 
	
	$AIClient.embeddings.create($text; $model; $options)