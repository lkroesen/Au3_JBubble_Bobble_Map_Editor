#include <File.au3>
#include <Array.au3>
#include <Crypt.au3>

Global $folder
Global $files
Global $numFiles

Func ImportMain()
   $folder = FileSelectFolder("Select the level folder", @ScriptDir)

   If @error == 1 Then
	  exit
   EndIf

   Refresh()
EndFunc

Func FileShower()
   $files = _FileListToArray($folder)

   if @error == 4 Then
	  $numFiles = 0
	  return
   Else
	  For $i = 1 to $files[0] Step 1
		 GUICtrlSetData($FileList, $files[$i])
	  Next
   EndIf
   $numFiles = $files[0]
EndFunc