//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($worker : 4D:C1709.SystemWorker; $params : Object)

/*
this callback method is triggered 
when text is split into chunks 
*/

If ($worker.responseError#"")
	
Else 
	
	//restore context
	var $data : Object
	$data:=$params.context
	var $dataClassName : Text
	$dataClassName:=$data.dataClassName
	var $pageId : Integer
	$pageId:=Num:C11($data.primaryKey)
	
	//get data
	var $chunked : Collection
	$chunked:=JSON Parse:C1218($worker.response; Is collection:K8:32)
	
	var $undropped : 4D:C1709.EntitySelection
	$undropped:=ds:C1482.Chunk.query("pageId == :1"; $pageId).drop()
	
	//create chunks
	
	var $chunk : cs:C1710.ChunkEntity
	For each ($data; $chunked)
		$chunk:=ds:C1482.Chunk.new()
		$chunk.pageId:=$pageId
		$chunk.start:=$data.start
		$chunk.end:=$data.end
		$chunk.save()
	End for each 
	
End if 