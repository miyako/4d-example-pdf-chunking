//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($task : Object)

/*
this worker is triggered by 
page entity event afterSave 
*/

var $worker : 4D:C1709.Function
$worker:=Formula:C1597(worker_chunked)

var $text_splitter : cs:C1710.text_splitter.text_splitter
$text_splitter:=cs:C1710.text_splitter.text_splitter.new()
$text_splitter.chunk($task; $worker)