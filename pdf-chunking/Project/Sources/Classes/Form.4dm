property limit : Integer
property AIClient : cs:C1710.AIKit.OpenAI
property model : Text
property parameters : cs:C1710.AIKit.OpenAIEmbeddingsParameters
property chunks : cs:C1710.ChunkSelection
property threshold : Real
property Message : Text

Class constructor
	
	This:C1470.limit:=10
	This:C1470.threshold:=5
	This:C1470.AIClient:=cs:C1710.AIKit.OpenAI.new()
	This:C1470.AIClient.baseURL:="http://127.0.0.1:8080/v1"
	This:C1470.model:="nomic-embed-text-v1.5.f16.gguf"
	This:C1470.parameters:=cs:C1710.AIKit.OpenAIEmbeddingsParameters.new()
	This:C1470.parameters.formula:=Formula:C1597(Form:C1466._didSearch.call(This:C1470; $1))
	This:C1470.chunks:=ds:C1482.Chunk.query("embedding != null")  //can't have This=null in query formula
	
Function showMessage($message : Text) : cs:C1710.Form
	
	This:C1470.Message:=$message
	
	return This:C1470
	
Function Search($query : Text) : cs:C1710.Form
	
	This:C1470.showMessage("")._startSearch($query)
	
	return This:C1470
	
Function _startSearch($query : Text) : cs:C1710.Form
	
	This:C1470.AIClient.embeddings.create($query; This:C1470.model; This:C1470.parameters)
	
	return This:C1470
	
Function _didSearch($embeddingsResult : cs:C1710.AIKit.OpenAIEmbeddingsResult)
	
/*
"This" is an instance of cs.AIKit.OpenAI
*/
	
	Form:C1466.showMessage("")
	
	If ($embeddingsResult.success)
		If ($embeddingsResult.embedding#Null:C1517)
			var $embedding : 4D:C1709.Vector
			$embedding:=$embeddingsResult.embedding.embedding
			var $threshold : Real
			$threshold:=Form:C1466.threshold/10
			var $formula : 4D:C1709.Function
			$formula:=Formula:C1597(This:C1470.embedding.cosineSimilarity($embedding)>$threshold)
			var $chunks; $filteredChunks; $sortedChunks : cs:C1710.ChunkSelection
			$chunks:=Form:C1466.chunks.query($formula)
			If ($chunks.length=0)
				Form:C1466.results:={col: []; pos: Null:C1517; item: Null:C1517; sel: Null:C1517}
				Form:C1466.showMessage("no match!")
				return 
			End if 
			$formula:=Formula:C1597(This:C1470.embedding.cosineSimilarity($embedding))
			$sortedChunks:=$chunks.orderByFormula($formula; dk descending:K85:32)
			$filteredChunks:=$sortedChunks.slice(0; Form:C1466.limit)
			Form:C1466.results:={col: $filteredChunks.getText(); pos: Null:C1517; item: Null:C1517; sel: Null:C1517}
			return 
		End if 
	Else 
		var $message : Text
		var $errors:=$embeddingsResult.errors
		$message:=$errors.extract("message").combine($errors.extract("body.error.message")).join("\r")
		Form:C1466.showMessage($message)
		return 
	End if 
	
	Form:C1466.showMessage("oops! something went wrong!")