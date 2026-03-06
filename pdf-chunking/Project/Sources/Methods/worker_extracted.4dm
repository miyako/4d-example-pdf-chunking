//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($worker : 4D:C1709.SystemWorker; $params : Object)

/*
this callback method is triggered 
when text is extracted from PDF 
*/

If ($worker.responseError#"")
	
Else 
	
	//restore context
	var $data : Object
	$data:=$params.context
	
	var $documentId : Integer
	$documentId:=Num:C11($data.primaryKey)
	
	//get data
	var $extracted : Object
	$extracted:=JSON Parse:C1218($worker.response; Is object:K8:27)
	
/*
text-splitter batch mode expects JSON
{
   pages:[text,text,text...]
}
*/
	
	$extracted.pages:=$extracted.pages.map(Formula:C1597(map_collapse_paragraphs))
	
	//create pages
	//If ($extracted.type="pdf")
	var $page : cs:C1710.PageEntity
	var $i : Integer
	$i:=1
	var $text : Text
	For each ($text; $extracted.pages)
		$page:=ds:C1482.Page.new()
		$page.documentId:=$documentId
		$page.text:=$text
		$page.number:=$i
		$i+=1
		$page.save()
	End for each 
	
	var $worker_chunking : 4D:C1709.Function
	$worker_chunking:=Formula:C1597(worker_chunking)
	var $task : Object
	$task:={file: JSON Stringify:C1217($extracted); \
		data: $data; \
		capacity: "96..512"; \
		overlap: 48; \
		tiktoken: True:C214; \
		compact: True:C214; \
		batch: True:C214}
	
	CALL WORKER:C1389($worker_chunking.source; $worker_chunking; $task)
	
	//End if 
End if 