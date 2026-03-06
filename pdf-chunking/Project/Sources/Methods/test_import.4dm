//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CONFIRM:C162("are you sure you want to import PDF?")
	
	If (OK=1)
		CALL WORKER:C1389(1; Current method name:C684; {})
	End if 
	
Else 
	
	var $pdfFiles : Collection  //<4D.File>
	$pdfFiles:=Folder:C1567("/RESOURCES/pdf").files().query("extension == :1"; ".pdf")
	
	var $pdfFile : 4D:C1709.File
	//$pdfFile:=$pdfFiles.last()
		
	For each ($pdfFile; $pdfFiles)
		test_parse_pdf($pdfFile)
	End for each 
	
End if 