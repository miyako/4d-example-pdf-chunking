//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($baseURL : Text; $text : Text; $model : Text; $options : cs:C1710.AIKit.OpenAIEmbeddingsParameters)

/*
this worker is triggered by 
chunk entity event afterSave 
*/

var $AIClient : cs:C1710.AIKit.OpenAI
$AIClient:=cs:C1710.AIKit.OpenAI.new()
$AIClient.baseURL:=$baseURL

$AIClient.embeddings.create($text; $model; $options)