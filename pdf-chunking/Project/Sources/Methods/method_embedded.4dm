//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($embeddingsResult : cs:C1710.AIKit.OpenAIEmbeddingsResult)

/*
this callback method is triggered 
when chunk is converted into embeddings 
*/

If ($embeddingsResult.success)
	If ($embeddingsResult.embeddings#Null:C1517)
		var $headers : Object
		$headers:=$embeddingsResult.request.headers
		var $attributeName : Text
		var $dataClassName : Text
		var $primaryKey : Variant
		$attributeName:=$headers.attributeName
		$dataClassName:=$headers.dataClassName
		var $primaryKeys : Collection
		$primaryKeys:=JSON Parse:C1218($headers.primaryKeys)
		var $embedding : Object
		var $i:=0
		For each ($primaryKey; $primaryKeys)
			$embedding:=$embeddingsResult.embeddings.at($i)
			If ($embedding#Null:C1517)
				var $entity : 4D:C1709.Entity
				$entity:=ds:C1482[$dataClassName].get($primaryKey)
				If ($entity#Null:C1517)
					$entity[$attributeName]:=$embedding.embedding
					$entity.save()
				End if 
			End if 
		End for each 
	End if 
End if 