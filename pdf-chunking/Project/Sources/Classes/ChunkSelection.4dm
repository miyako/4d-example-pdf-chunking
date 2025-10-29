Class extends EntitySelection

Function getText() : Collection
	
	var $text : Collection
	$text:=[]
	
	var $chunk : cs:C1710.ChunkEntity
	For each ($chunk; This:C1470)
		$text.push({text: $chunk.getPageText(); page: $chunk.page.number})
	End for each 
	
	return $text