#include <file.au3>
#include <Array.au3>

Global $aTextArray

Func ParseMain($fileloc)
   Local $sLines = FileRead($fileloc)
   Global $aTextArray = StringSplit($sLines, "")
   FixParse()
   ShowParse()
EndFunc

Func FixParse()
   For $i = 1 to $aTextArray[0] Step 1
	  if $aTextArray[$i] == " " Then
		 $aTextArray[$i] = "null"
	  EndIf
   Next
EndFunc

Func ShowParse()
   $count = 1
   for $c = 0 to $BlockSize-1 Step 1
	  for $i = 0 to $BlockSize-1 Step 1
		 if $GridIcons[$i][$c] == $aTextArray[$count] Then
			; Optimization Hype
		 Else
			GUICtrlSetImage($Grid[$i][$c], $imgfolder & $aTextArray[$count] & ".bmp")
			$GridIcons[$i][$c] = $aTextArray[$count]
		 EndIf
		 $count += 1
	  Next
	  $count += 2
   Next
EndFunc