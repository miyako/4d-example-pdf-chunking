//%attributes = {"invisible":true,"preemptive":"capable"}
CONFIRM:C162("are you sure you want to delete everything?")

If (OK=1)
	
	TRUNCATE TABLE:C1051([Document:1])
	TRUNCATE TABLE:C1051([Page:2])
	TRUNCATE TABLE:C1051([Chunk:3])
	
	SET DATABASE PARAMETER:C642([Document:1]; Table sequence number:K37:31; 0)
	SET DATABASE PARAMETER:C642([Page:2]; Table sequence number:K37:31; 0)
	SET DATABASE PARAMETER:C642([Chunk:3]; Table sequence number:K37:31; 0)
	
End if 