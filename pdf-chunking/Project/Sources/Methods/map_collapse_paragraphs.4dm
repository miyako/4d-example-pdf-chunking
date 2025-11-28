//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($item : Object)

$item.result:=$item.value.paragraphs.extract("text").join("")