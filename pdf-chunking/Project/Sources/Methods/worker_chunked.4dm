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
	
	var $documentId : Integer
	$documentId:=Num:C11($data.primaryKey)
	
	//get data
	var $chunked : Collection
	$chunked:=JSON Parse:C1218($worker.response; Is collection:K8:32)
	
	//create chunks
	var $page : cs:C1710.PageEntity
	var $number : Integer
	var $chunk : cs:C1710.ChunkEntity
	var $pages : cs:C1710.PageSelection
	$pages:=ds:C1482.Page.query("documentId == :1"; $documentId)
	For each ($data; $chunked)
		$number:=$data.page+1
		$page:=$pages.query("number == :1"; $number).first()
		$chunk:=ds:C1482.Chunk.new()
		$chunk.pageId:=$page.Id
		$chunk.start:=$data.start
		$chunk.end:=$data.end
		$chunk.save()
	End for each 
	
End if 