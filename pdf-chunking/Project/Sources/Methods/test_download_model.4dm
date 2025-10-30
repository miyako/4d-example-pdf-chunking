//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	var $file : 4D:C1709.File
	var $lang; $URL : Text
	$file:=File:C1566("/RESOURCES/models/nomic-embed-text-v1.5.f16.gguf")
	$URL:="https://huggingface.co/nomic-ai/nomic-embed-text-v1.5-GGUF/resolve/main/nomic-embed-text-v1.5.f16.gguf"
	CALL WORKER:C1389(Current method name:C684; Current method name:C684; {lang: $lang; file: $file; URL: $URL})
Else 
	
	var $model : cs:C1710.Model
	$model:=cs:C1710.Model.new($params.file; $params.URL)
	
End if 