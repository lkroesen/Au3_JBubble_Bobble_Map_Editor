Global $ExportIcons[36][36]

Func SaveFile()
   ChangeNullToSpace()
   for $c = 0 to 35 Step 1
	  $strBuild = ""
	  for $i = 0 to 35 Step 1
		 $strBuild &= $ExportIcons[$i][$c]
	  Next
	  FileWriteline($folder & "\" & $numFiles+1 & ".txt", $strBuild)
   Next
   Refresh()
EndFunc

Func OverWriteFile()
   ChangeNullToSpace()
   FileDelete($folder & "\" & GUICtrlRead($FileList))
   for $c = 0 to 35 Step 1
	  $strBuild = ""
	  for $i = 0 to 35 Step 1
		 $strBuild &= $ExportIcons[$i][$c]
	  Next
	  FileWriteline($folder & "\" & GUICtrlRead($FileList), $strBuild)
   Next
   Refresh()
EndFunc

; Creates a COMPLETELY random level
Func RandomLevel()
   for $c = 0 to 35 Step 1
	  for $i = 0 to 35 Step 1
		 if $i == 8 AND $c == 32 Then
			GUICtrlSetImage($Grid[$i][$c], $imgfolder & "P.bmp")
			$GridIcons[$i][$c] = "P"
		 Else
			$char = RandomChar()
			GUICtrlSetImage($Grid[$i][$c], $imgfolder & $char & ".bmp")
			$GridIcons[$i][$c] = $char
		 EndIf
	  Next
   Next
EndFunc

Func RandomChar()
   $n = Random(0, 99, 1)
   if $n >= 0 and $n <= 20 Then
	  return "X"
   elseif $n > 20 and $n <= 80 Then
	  return "null"
   elseif $n > 80 and $n <= 97 Then
	  return "_"
   elseif $n > 97 Then
	  return "E"
   EndIf
EndFunc

Func ChangeNulltoSpace()
   for $y = 0 to 35 Step 1
	  for $x = 0 to 35 Step 1
			if $GridIcons[$x][$y] == "null" Then
			   $ExportIcons[$x][$y] = " "
			Else
			   $ExportIcons[$x][$y] = $GridIcons[$x][$y]
			EndIf
	  Next
   Next
EndFunc