//%attributes = {"invisible":true,"preemptive":"capable"}
$data:={pages: [{paragraphs: [{text: "abc"}; {text: "def"}]}]}

$data.pages:=$data.pages.map(Formula:C1597(map_collapse_paragraphs))