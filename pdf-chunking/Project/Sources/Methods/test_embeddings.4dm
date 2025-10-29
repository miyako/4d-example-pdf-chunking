//%attributes = {"invisible":true}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	CALL WORKER:C1389(Current method name:C684; Current method name:C684; {})
Else 
	
	var $chunks : cs:C1710.ChunkSelection
	$chunks:=ds:C1482.Chunk.query("embedding == null")
	var $chunk : cs:C1710.ChunkEntity
	
	For each ($chunk; $chunks)
		$chunk.pageId:=$chunk.pageId
		$chunk.save()
	End for each 
	
End if 