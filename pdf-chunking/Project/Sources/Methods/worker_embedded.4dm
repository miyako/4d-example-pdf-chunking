//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($embeddingsResult : cs:C1710.AIKit.OpenAIEmbeddingsResult)

/*
this callback method is triggered 
when chunk is converted into embeddings 
*/

If ($embeddingsResult.success)
	If ($embeddingsResult.embedding#Null:C1517)
		
		var $headers : Object
		$headers:=$embeddingsResult.request.headers
		
		var $attributeName : Text
		var $dataClassName : Text
		var $primaryKey : Integer
		$attributeName:=$headers.attributeName
		$dataClassName:=$headers.dataClassName
		$primaryKey:=Num:C11($headers.primaryKey)
		
		var $entity : 4D:C1709.Entity
		$entity:=ds:C1482[$dataClassName].get($primaryKey)
		If ($entity#Null:C1517)
			$entity[$attributeName]:=$embeddingsResult.embedding.embedding
			$entity.save()
		End if 
		
	End if 
End if 