//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	CALL WORKER:C1389("test"; Current method name:C684; {})
Else 
	
	var $form : Object
	$form:=cs:C1710.Form.new()
	
	var $window : Integer
	$window:=Open form window:C675("test")
	DIALOG:C40("test"; $form; *)
	
End if 