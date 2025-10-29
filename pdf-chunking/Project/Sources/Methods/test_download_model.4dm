//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	CALL WORKER:C1389("test"; Current method name:C684; {})
Else 
	
	var $file : 4D:C1709.File
	$file:=File:C1566("/RESOURCES/models/nomic-embed-text-v1.5.f16.gguf")
	
	var $URL : Text
	$URL:="https://github.com/miyako/4d-example-pdf-chunking/releases/download/nomic-embed-text-v1.5.f16.gguf/nomic-embed-text-v1.5.f16.gguf"
	
	var $model : cs:C1710.Model
	$model:=cs:C1710.Model.new($file; $URL)
	
End if 