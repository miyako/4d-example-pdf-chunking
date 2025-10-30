Class extends Entity

Function get_text_from_previous_page($percent : Real) : Text
	
	var $previousPage : cs:C1710.PageEntity
	$previousPage:=This:C1470.getDataClass().query("number == :1"; This:C1470.number-1).first()
	
	If ($previousPage#Null:C1517)
		var $text : Text
		$text:=$previousPage.text
		If ($percent<=100) && ($percent>0)
			var $length; $start : Integer
			$length:=Length:C16($text)
			$start:=$length-($length*($percent/100))
			If ($start=0)
				return $text
			End if 
			return Substring:C12($text; $start)
		End if 
		return $text
	End if 
	