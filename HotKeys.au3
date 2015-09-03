HotKeySet("{F1}", "DeSelectAll")
HotKeySet("{DEL}", "Delete")
HotKeySet("a", "a")
HotKeySet("s", "s")
HotKeySet("d", "d")
HotKeySet("f", "f")

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

