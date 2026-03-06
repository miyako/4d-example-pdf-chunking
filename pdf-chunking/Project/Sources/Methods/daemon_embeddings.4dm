//%attributes = {"preemptive":"capable"}
#DECLARE($baseURL : Text; $text : Text; $model : Text; $options : cs:C1710.AIKit.OpenAIEmbeddingsParameters)

var $worker : 4D:C1709.Function
$worker:=Formula:C1597(daemon_embeddings)

var $DELAY_TICKCOUNT : Integer
$DELAY_TICKCOUNT:=60*60*5
var $MAX_AIKIT_CLIENTS : Integer
$MAX_AIKIT_CLIENTS:=16

Case of 
	: (Count parameters:C259=0)
		
		var $processes : Collection
		$processes:=Process activity:C1495.processes
		var $daemon : Object
		$daemon:=$processes.query("name == :1 and type == :2"; $worker.source; Worker process:K36:32).first()
		
		Case of 
			: ($daemon=Null:C1517) || ($daemon.state=Aborted:K13:1) || ($daemon.state=Does not exist:K13:3)
				CALL WORKER:C1389($worker.source; $worker; "http://127.0.0.1:8080/v1")
			: ($daemon.state=Paused:K13:6) || ($daemon.state=Delayed:K13:2)
				RESUME PROCESS:C320($daemon.number)
			: ($daemon.state=Executing:K13:4)
				//do nothing
		End case 
		
	: (Count parameters:C259=1)
		
		$model:=""
		$dataClassName:="Chunk"  //$chunk.getDataClass().getInfo().name
		$attributeName:="embedding"
		var $dataClassName; $attributeName : Text
		var $headers : Object
		$headers:={\
			dataClassName: $dataClassName; \
			attributeName: $attributeName}
		var $AIClient : cs:C1710.AIKit.OpenAI
		$AIClient:=cs:C1710.AIKit.OpenAI.new()
		$AIClient.baseURL:=$baseURL
		$options:=cs:C1710.AIKit.OpenAIEmbeddingsParameters.new()
		var $chunks; $batches : cs:C1710.ChunkSelection
		$chunks:=ds:C1482.Chunk.query("embedding == null")
		var $start; $end : Integer
		$start:=0
		$end:=32
		$batches:=$chunks.slice($start; $end)
		var $input; $primaryKeys : Collection
		var $chunk : cs:C1710.ChunkEntity
		While ($batches.length#0)
			$input:=[]
			$primaryKeys:=[]
			For each ($chunk; $batches)
				$primaryKeys.push($chunk.getKey())
				$text:=Substring:C12($chunk.page.text; $chunk.start+1; $chunk.end-$chunk.start)
				If ($chunk.start=0)
					//first chunk of page, get some text from previous page for context
					$text:=$chunk.page.get_text_from_previous_page(25)+$text
				End if 
				$input.push($text)
			End for each 
			$headers.primaryKeys:=JSON Stringify:C1217($primaryKeys)
			$options.extraHeaders:=$headers
			var $embeddingsResult : cs:C1710.AIKit.OpenAIEmbeddingsResult
			$embeddingsResult:=$AIClient.embeddings.create($input; $model; $options)
			method_embedded($embeddingsResult)
			$start+=0
			$end+=32
			$batches:=$chunks.slice($start; $end)
		End while 
		
		While (ds:C1482.Chunk.query("embedding == null").length=0)
			DELAY PROCESS:C323(Current process:C322; $DELAY_TICKCOUNT)
		End while 
		
		CALL WORKER:C1389($worker.source; $worker; $baseURL)
		
End case 