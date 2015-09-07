#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <HotKeys.au3>
#include <Exporter.au3>
#include <Importer.au3>
#include <Parser.au3>

Global $BlockSize = InputBox("Input Block Size", "Input Block Size, must be greater than 5 and lower than 37")
If $BlockSize >= 6 and $BlockSize <= 36 Then
   ; All Fine
Else
   BlockSize()
EndIf
Global $ExportIcons[$BlockSize][$BlockSize]
Global $Grid[$BlockSize][$BlockSize]
Global $GridIcons[$BlockSize][$BlockSize]
Global $tButton[3]
Global $tButtonText[3] = ["Source Dir", "Refresh", "Load Selected"]
Global $bButton[3]
Global $bButtonText[3] = ["Save as New", "Overwrite", "Random Level"]
Global $iSelected[2] = [-1, -1]
Global $cSelected[2] = [-1, -1]
Global $boolSelectFirst = False
Global $boolSelectSecond = False
Global $boolFullSelection = False
Global $imgfolder = "img\"

$GUIWSIZE = 890
$GUIHSIZE = 806

$GUI = GUICreate("JBubble Bobble: Level Editor", $GUIWSIZE, $GUIHSIZE, 192, 124)
GUISetState(@SW_SHOW)

#Region ### START Koda GUI section ### Form=
$Main_Group_Level = GUICtrlCreateGroup("Level", 8, 8, 595, 601, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))

#Region Menu Items
$MenuItem1 = GUICtrlCreateMenu("File")
$MenuItem2 = GUICtrlCreateMenuItem("Load Level", $MenuItem1)
$MenuItem3 = GUICtrlCreateMenuItem("Select Source Dir", $MenuItem1)
$MenuItem4 = GUICtrlCreateMenuItem("Save As New", $MenuItem1)
$MenuItem5 = GUICtrlCreateMenuItem("Random Level", $MenuItem1)
$MenuItem6 = GUICtrlCreateMenuItem("Close Editor", $MenuItem1)
$MenuItem7 = GUICtrlCreateMenu("HotKeys")
$MenuItem8 = GUICtrlCreateMenuItem("Place Wall (F1)", $MenuItem7)
$MenuItem9 = GUICtrlCreateMenuItem("Place Player (F2)", $MenuItem7)
$MenuItem10 = GUICtrlCreateMenuItem("Place Platform (F3)", $MenuItem7)
$MenuItem11 = GUICtrlCreateMenuItem("Place Enemy (F4)", $MenuItem7)
$MenuItem12 = GUICtrlCreateMenuItem("Empty Space (DEL)", $MenuItem7)
$MenuItem13 = GUICtrlCreateMenuItem("Deselect All (F9)", $MenuItem7)
$MenuItem14 = GUICtrlCreateMenuItem("Fix my issues (F10)", $MenuItem7)
$MenuItem15 = GUICtrlCreateMenuItem("Reset Field (F11)", $MenuItem7)
#EndRegion


for $i = 0 to $BlockSize-1 Step 1
   for $c = 0 to $BlockSize-1 Step 1
	  $Grid[$i][$c] = GUICtrlCreatePic("img\null.bmp", ((-8.3*$BlockSize + 314.8) + ($i*16) ), ( (-8.2*$BlockSize + 319.2) + ($c*16)), 16, 16)
	  $GridIcons[$i][$c] = "null"
   Next
Next

$Level_Selection_Group = GUICtrlCreateGroup("Level Selection", 611, 8, 273, 775, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
$FileList = GUICtrlCreateList("", 620, 32, 257, 684)
for $i = 0 to 2 Step 1
   $tButton[$i] = GUICtrlCreateButton( $tButtonText[$i], 620 + ($i * 90), 720, 75, 25)
   $bButton[$i] = GUICtrlCreateButton( $bButtonText[$i], 620 + ($i * 90), 752, 75, 25)
Next

$ResourcesGroup = GUICtrlCreateGroup("Resources", 8, 621, 595, 161, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
$PictureWall = GUICtrlCreatePic($imgfolder & "X.bmp", 24, 632, 36, 36)
$WallLabel = GUICtrlCreateLabel("Wall", 24, 675, 35, 17, $SS_CENTER)

$PicturePlayer = GUICtrlCreatePic($imgfolder & "P.bmp", 80, 632, 36, 36)
$PlayerLabel = GUICtrlCreateLabel("Bubblun", 78, 675, 42, 17, $SS_CENTER)

$PictureNull = GUICtrlCreatePic($imgfolder & "null.bmp", 136, 632, 36, 36)
$NullLabel = GUICtrlCreateLabel("Empty", 134, 675, 42, 17, $SS_CENTER)

$PicturePlatform = GUICtrlCreatePic($imgfolder & "_.bmp", 24, 695, 36, 36)
$PlatformLabel = GUICtrlCreateLabel("Platform", 22, 735, 42, 17, $SS_CENTER)

$PictureEnemy = GUICtrlCreatePic($imgfolder & "E.bmp", 80, 695, 36, 36)
$EnemyLabel = GUICtrlCreateLabel("Enemy", 78, 735, 42, 17, $SS_CENTER)

$Debug = GUICtrlCreateInput("", 16, 752, 585, 21)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

ImportMain()

While 1
	$nMsg = GUIGetMsg()

   if $boolFullSelection == False Then
	TileSelector($nMsg)
   EndIf

	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		 Case $tButtonText
			DeSelectAll()
		 Case $PictureWall
			a()
		 case $PicturePlayer
			s()
		 case $PicturePlatform
			d()
		 case $PictureEnemy
			f()
		 case $PictureNull
			Delete()
		 case $tButton[1]
			Refresh()
		 case $tButton[0]
			ImportMain()
		 case $tButton[2]
			ParseMain($folder & "\" & GUICtrlRead($FileList))
		 case $bButton[0]
			SaveFile()
		 case $bButton[1]
			OverWriteFile()
		 case $bButton[2]
			RandomLevel()
		 case $MenuItem13
			DeSelectAll()
		 case $MenuItem14
			MagicFixButton()
		 case $MenuItem15
			ResetField()
		 case $MenuItem12
			Delete()
		 case $MenuItem8
			a()
		 case $MenuItem9
			s()
		 case $MenuItem10
			d()
		 case $MenuItem11
			f()
		 case $MenuItem2
			$num = InputBox("Level Number", "Input the number of the level e.g. 42 (.txt is added automatically)")
			If $num <= $numFiles and $num > 0 Then
			   ParseMain($folder & "\" & $num & ".txt")
			Else
			   Msgbox(0, "OUT OF BOUNDS", $num & ".txt is not in the list.")
			EndIf
		 case $MenuItem3
			ImportMain()
		 Case $MenuItem4
			SaveFile()
		 Case $MenuItem5
			RandomLevel()
		 Case $MenuItem6
			exit
	EndSwitch
 WEnd

Func Refresh()
   GUICtrlDelete($FileList)
   $FileList = GUICtrlCreateList("", 620, 32, 257, 684)
   FileShower()
EndFunc

; Makes it possible when 2 points are clicked to select the whole area.
Func ChangeInto($into)
   if $boolSelectSecond == False and $boolSelectFirst == True Then

	  if $GridIcons[$iSelected[0]][$cSelected[0]] == $into Then
		 ; Do Nothing
	  Else
		 GUICtrlSetImage($Grid[$iSelected[0]][$cSelected[0]], $imgfolder & $into & ".bmp")
		 $GridIcons[$iSelected[0]][$cSelected[0]] = $into
	  EndIf
	  $iSelected[0] = -1
	  $cSelected[0] = -1
	  $boolSelectFirst = false
   Else
	  ; Larger equal i
	  if ($iSelected[1] - $iSelected[0]) >= ($cSelected[1] - $cSelected[0]) Then
		 for $c = $cSelected[0] to $cSelected[1] step 1
			For $i = $iSelected[0] to $iSelected[1] step 1
			   if $GridIcons[$i][$c] == $into Then
				  ; Do Nothing
			   Else
				  GUICtrlSetImage($Grid[$i][$c], $imgfolder & $into & ".bmp")
				  $GridIcons[$i][$c] = $into
			   EndIf
			Next
		 Next

	  ; Larger c
	  ElseIf ($iSelected[1] - $iSelected[0]) < ($cSelected[1] - $cSelected[0]) Then
		 for $i = $iSelected[0] to $iSelected[1] step 1
			For $c = $cSelected[0] to $cSelected[1] step 1
			   if $GridIcons[$i][$c] == $into Then
				  ; Do Nothing
			   Else
				  GUICtrlSetImage($Grid[$i][$c], $imgfolder & $into & ".bmp")
				  $GridIcons[$i][$c] = $into
			   EndIf
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

; Handles the tile selection on the screen
Func TileSelector($msg)
   for $i = 0 to $BlockSize-1 Step 1
	  for $c = 0 to $BlockSize-1 Step 1
		 if $msg == $Grid[$i][$c] Then
			if $iSelected[0] == $i AND $cSelected[0] == $c Then
			   $iSelected[0] = -1
			   $cSelected[0] = -1
			   GUICtrlSetImage($Grid[$i][$c], $imgfolder & NameComplement($GridIcons[$i][$c]) & ".bmp")
			   $GridIcons[$i][$c] = NameComplement($GridIcons[$i][$c])
			   $boolSelectFirst = false

			   GUICtrlSetData($debug, $GridIcons[$i][$c])

			elseif $boolSelectFirst == False Then
			   GUICtrlSetImage($Grid[$i][$c], $imgfolder & NameComplement($GridIcons[$i][$c]) & ".bmp")
			   $GridIcons[$i][$c] = NameComplement($GridIcons[$i][$c])
			   $iSelected[0] = $i
			   $cSelected[0] = $c
			   $boolSelectFirst = true

			   GUICtrlSetData($debug, $GridIcons[$i][$c])

			ElseIf $boolSelectFirst == true Then
			   $iSelected[1] = $i
			   $cSelected[1] = $c
			   $boolSelectSecond = true
			   SelectInBetween()
			EndIf

		 EndIf
	  Next
   Next
EndFunc

; Returns inverse of the name
Func NameComplement($name)
   if $name == "null" Then
	  return "nullS"
   elseif $name == "nullS" Then
	  return "null"
   elseif $name == "_" Then
	  return "_S"
   elseif $name == "_S" Then
	  return "_"
   elseif $name == "E" Then
	  return "ES"
   elseif $name == "ES" Then
	  return "E"
   elseif $name == "P" Then
	  return "PS"
   elseif $name == "PS" Then
	  return "P"
   elseif $name == "X" Then
	  return "XS"
   elseif $name == "XS" Then
	  return "X"
   EndIf
EndFunc

; Makes it possible when 2 points are clicked to select the whole area.
Func SelectInBetween()
   ; Select a whole area, so the loop $i starts at First ends at Second, same for $c
   ; Deslect original one, for easier selection

   ; First image
   GUICtrlSetImage($Grid[$iSelected[0]][$cSelected[0]], $imgfolder & NameComplement($GridIcons[$iSelected[0]][$cSelected[0]]) & ".bmp")
   $GridIcons[$iSelected[0]][$cSelected[0]] = NameComplement($GridIcons[$iSelected[0]][$cSelected[0]])


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

   $boolFullSelection = True
EndFunc

