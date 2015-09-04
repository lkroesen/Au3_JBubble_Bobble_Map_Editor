HotKeySet("{F9}", "DeSelectAll")
HotKeySet("{F11}", "ResetField")
;HotKeySet("{F3}", "SaveFile")
HotKeySet("{DEL}", "Delete")
HotKeySet("{F1}", "a")
HotKeySet("{F2}", "s")
HotKeySet("{F3}", "d")
HotKeySet("{F4}", "f")

; Deselects everything
Func DeSelectAll()
   if $boolSelectSecond == False Then
	  GUICtrlSetImage($Grid[$iSelected[0]][$cSelected[0]], $imgfolder & NameComplement($GridIcons[$iSelected[0]][$cSelected[0]]) & ".bmp")
	  $GridIcons[$iSelected[0]][$cSelected[0]] = NameComplement($GridIcons[$iSelected[0]][$cSelected[0]])
	  $iSelected[0] = -1
	  $cSelected[0] = -1
	  $boolSelectFirst = false
   Else
	  ; Larger equal i
	  if ($iSelected[1] - $iSelected[0]) >= ($cSelected[1] - $cSelected[0]) Then
		 for $c = $cSelected[0] to $cSelected[1] step 1
			For $i = $iSelected[0] to $iSelected[1] step 1
			   GUICtrlSetImage($Grid[$i][$c], $imgfolder & NameComplement($GridIcons[$i][$c]) & ".bmp")
			   $GridIcons[$i][$c] = NameComplement($GridIcons[$i][$c])
			Next
		 Next

	  ; Larger c
	  ElseIf ($iSelected[1] - $iSelected[0]) < ($cSelected[1] - $cSelected[0]) Then
		 for $i = $iSelected[0] to $iSelected[1] step 1
			For $c = $cSelected[0] to $cSelected[1] step 1
			   GUICtrlSetImage($Grid[$i][$c], $imgfolder & NameComplement($GridIcons[$i][$c]) & ".bmp")
			   $GridIcons[$i][$c] = NameComplement($GridIcons[$i][$c])
			Next
		 Next
	  EndIf

	  $boolFullSelection = false
	  $boolSelectFirst = false
	  $boolSelectSecond = false
	  $iSelected[0] = -1
	  $cSelected[0] = -1
	  $iSelected[1] = -1
	  $cSelected[1] = -1
   EndIf
EndFunc

; Wall
Func a()
   if $boolSelectFirst == True Then
	  ChangeInto("X")
   EndIf
EndFunc

; Player
Func s()
   if $boolSelectFirst == True Then
	  ChangeInto("P")
   EndIf
EndFunc

; Platform
Func d()
   if $boolSelectFirst == True Then
	  ChangeInto("_")
   EndIf
EndFunc

; Enemy
Func f()
   if $boolSelectFirst == True Then
	  ChangeInto("E")
   EndIf
EndFunc

; Empty Space
Func Delete()
   if $boolSelectFirst == True Then
	  ChangeInto("null")
   EndIf
EndFunc

Func ResetField()
   $iMsgBoxAnswer = MsgBox(52,"WARNING","You're about to delete the whole field, press Yes to continue")
   Select
	  Case $iMsgBoxAnswer = 6
        ; Yes
	  Case $iMsgBoxAnswer = 7
        return
   EndSelect

   $count = 0
   for $i = 0 to 35 Step 1
	  for $c = 0 to 35 step 1
		 if  $GridIcons[$i][$c] == "null" Then
			$count+=1
			GUICtrlSetData($debug, "Changes Skipped: " & $count)
		 Else
			GUICtrlSetImage($Grid[$i][$c], $imgfolder & "null.bmp")
			$GridIcons[$i][$c] = "null"
		 EndIf
	  Next
   Next
EndFunc