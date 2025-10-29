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
	var $dataClassName : Text
	$dataClassName:=$data.dataClassName
	var $documentId : Integer
	$documentId:=Num:C11($data.primaryKey)
	
	//get data
	var $extracted : Object
	$extracted:=JSON Parse:C1218($worker.response; Is object:K8:27)
	
	var $undropped : 4D:C1709.EntitySelection
	$undropped:=ds:C1482.Page.query("documentId == :1"; $documentId).drop()
	
	//create pages
	If ($extracted.type="pdf")
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
	End if 
End if 