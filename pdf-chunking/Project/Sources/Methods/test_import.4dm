//%attributes = {"invisible":true,"preemptive":"capable"}
CONFIRM:C162("are you sure you want to import PDF?")

If (OK=1)
	
	var $pdfFiles : Collection  //<4D.File>
	$pdfFiles:=Folder:C1567("/RESOURCES/pdf").files().query("extension == :1"; ".pdf")
	
	var $pdfFile : 4D:C1709.File
	$pdfFile:=$pdfFiles.last()
	
	For each ($pdfFile; $pdfFiles)
		test_parse_pdf($pdfFile)
	End for each 
	
End if 