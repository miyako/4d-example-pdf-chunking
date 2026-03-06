//%attributes = {"invisible":true}

/*
you should probably regulate the frequency of your calls to the server;
a typical inference engine can only generate 1 embeddding at a time.
llama.cpp can handle several parallel request, 
privided that context size is a multiple of batch size,
where batch size is a the max number of tokens.
*/

var $chunks : cs:C1710.ChunkSelection
$chunks:=ds:C1482.Chunk.query("embedding == null")

var $chunk : cs:C1710.ChunkEntity
For each ($chunk; $chunks)
	$chunk.save()
End for each 