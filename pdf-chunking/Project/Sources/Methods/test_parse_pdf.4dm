//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($pdfFile : 4D:C1709.File)

var $pdfData:=4D:C1709.Blob
$pdfData:=$pdfFile.getContent()

var $document : cs:C1710.DocumentEntity
$document:=ds:C1482.Document.new()
$document.data:=$pdfData
$document.name:=$pdfFile.name
$document.extension:=$pdfFile.extension
$document.save()