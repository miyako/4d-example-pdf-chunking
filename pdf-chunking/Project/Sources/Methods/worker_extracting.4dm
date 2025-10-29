//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($task : Object)

/*
this worker is triggered by 
document entity event afterSave 
*/

var $worker : 4D:C1709.Function
$worker:=Formula:C1597(worker_extracted)

var $extract : cs:C1710.extract.extract
$extract:=cs:C1710.extract.extract.new($task.data.extension)
$extract.getText($task; $worker)