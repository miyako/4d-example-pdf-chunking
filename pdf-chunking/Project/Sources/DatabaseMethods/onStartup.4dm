var $LlamaEdge : cs:C1710.LlamaEdge.LlamaEdge

If (False:C215)
	$LlamaEdge:=cs:C1710.LlamaEdge.LlamaEdge.new()  //default
Else 
	var $homeFolder : 4D:C1709.Folder
	$homeFolder:=Folder:C1567(fk home folder:K87:24).folder(".LlamaEdge")
	var $model : cs:C1710.LlamaEdge.LlamaEdgeModel
	var $file : 4D:C1709.File
	var $URL; $path; $model_name; $model_alias : Text
	var $prompt_template : Text
	var $ctx_size : Integer
	
	var $models : Collection
	$models:=[]
	
/*
if file doesn't exist, it is downloaded from URL 
paths are relative to $home which is mapped to . in wasm
*/
	
	//#1 is chat model
	
	$file:=$homeFolder.file("llama/Llama-3.2-3B-Instruct-Q4_K_M.gguf")
	$URL:="https://huggingface.co/second-state/Llama-3.2-3B-Instruct-GGUF/resolve/main/Llama-3.2-3B-Instruct-Q4_K_M.gguf"
	$path:="./.LlamaEdge/llama/"+$file.fullName
	$prompt_template:="llama-3-chat"
	$ctx_size:=4096
	$model_name:="llama"
	$model_alias:="default"
	
	$model:=cs:C1710.LlamaEdge.LlamaEdgeModel.new($file; $URL; $path; $prompt_template; $ctx_size; $model_name; $model_alias)
	$models.push($model)
	
	//#2 is embedding model
	
	If (False:C215)
		$file:=$homeFolder.file("nomic-ai/nomic-embed-text-v2-moe.Q5_K_M.gguf")
		$URL:="https://huggingface.co/nomic-ai/nomic-embed-text-v2-moe-GGUF/resolve/main/nomic-embed-text-v2-moe.Q5_K_M.gguf"
		$path:="./.LlamaEdge/nomic-ai/"+$file.fullName
		$prompt_template:="embedding"
		$ctx_size:=512
	Else 
		$file:=$homeFolder.file("nomic-ai/nomic-embed-text-v1.Q8_0.gguf")
		$URL:="https://huggingface.co/nomic-ai/nomic-embed-text-v1-GGUF/resolve/main/nomic-embed-text-v1.Q8_0.gguf"
		$path:="./.LlamaEdge/nomic-ai/"+$file.fullName
		$prompt_template:="embedding"
		$ctx_size:=8192
	End if 
	
	$model_name:="nomic"
	$model_alias:="embedding"
	
	$model:=cs:C1710.LlamaEdge.LlamaEdgeModel.new($file; $URL; $path; $prompt_template; $ctx_size; $model_name; $model_alias)
	$models.push($model)
	
	var $port : Integer
	$port:=8080
	
	var $event : cs:C1710.event.event
	$event:=cs:C1710.event.event.new()
/*
Function onError($params : Object; $error : cs.event.error)
Function onSuccess($params : Object; $models : cs.event.models)
*/
	$event.onError:=Formula:C1597(ALERT:C41($2.message))
	$event.onSuccess:=Formula:C1597(ALERT:C41($2.models.extract("name").join(",")+" loaded!"))
	//$event.onData:=Formula(MESSAGE(String((This.range.end/This.range.length)*100; "###.00%")))  //onData@4D.HTTPRequest
	//$event.onResponse:=Formula(ERASE WINDOW)  //onResponse@4D.HTTPRequest
	
	$LlamaEdge:=cs:C1710.LlamaEdge.LlamaEdge.new($port; $models; {home: $homeFolder}; $event)
	
End if 