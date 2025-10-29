If (FORM Event:C1606.code=On Clicked:K2:4)
	
	var $query : Text
	$query:=OBJECT Get name:C1087(Object with focus:K67:3)="Query" ? Get edited text:C655 : Form:C1466.Query
	
	Form:C1466.Search($query)
	
End if 