#include <GUIConstantsEx.au3>
#include <ColorConstants.au3>
#include "_core.au3"
#include "_helper.au3"
#include "_record_mouse_click.au3"
#include "_ini.au3"

Const $TASKS = "|PartyQuest|Test";
Const $PARTYQUEST_SECTION_CONFIG = "partyQuest"

#Region ### START Koda GUI section ### Form=
Opt("GUIOnEventMode", 1)

$Form1 = GUICreate("Onmyoji Auto", 500,600)
$btStart = GUICtrlCreateButton("START", 8, 560, 130, 30)
$btExit = GUICtrlCreateButton("EXIT PROGRNAM", 360, 560, 130, 30)
$btStop = GUICtrlCreateButton("STOP", 150, 560, 130, 30)
GUICtrlSetBkColor($btStart, $COLOR_GREEN)
GUICtrlSetBkColor($btStop, $COLOR_RED)

Global $task = ""
Global $taskCtrlId = GUICtrlCreateCombo("", 10, 10, 185, 20)
GUICtrlSetData($taskCtrlId, $TASKS, "")

GUISetState(@SW_SHOW)
ResetTask()
#EndRegion ### END Koda GUI section ###

#Region ### HANDLE GUI ###

GUICtrlSetOnEvent($btStart, "ChangeTask")
GUICtrlSetOnEvent($btStop, "ResetTask")
GUICtrlSetOnEvent($btExit, "Close") ; Changed
GUISetOnEvent($GUI_EVENT_CLOSE, "Close")

GUISetState()

Global $aData[6] = [1, 2, 3, "4", "5", "6"] ; This array stores the text we want to send.
Global $iCount1 = 0

Func test()
   While 1
		 _LOG("START_TEST")
		 If $task <> "Test" Then ExitLoop
		 Sleep(5000)
		 _LOG($aData[$iCount1])
		 $iCount1 = Mod($iCount1 + 1, 6)
		 _LOG("END_TEST")
		 Sleep(500)
   WEnd
EndFunc


Func ChangeTask()
   $task = GUICtrlRead($taskCtrlId)
   If $task == "" Then Return
   ;GUICtrlSetBkColor($btStart, $COLOR_RED)
   GUICtrlSetState ($btStart,$GUI_DISABLE)
   GUICtrlSetState ($btStop,$GUI_ENABLE)
   _LOG("New Task: " & $task)
 EndFunc

Func ResetTask()
$task = ""
GUICtrlSetData($taskCtrlId, $TASKS, "")
;GUICtrlSetBkColor($btStart, $COLOR_GREEN)
GUICtrlSetState ($btStop,$GUI_DISABLE)
GUICtrlSetState ($btStart,$GUI_ENABLE)
_LOG("RESET TASK")
EndFunc

Func Close()
    Exit
 EndFunc ;==>CancelPressed

HotKeySet("{ESC}","Close") ;Press ESC key to quit

#EndRegion

 While 1
   Select
	  Case $task == "Test"
		 test()
	  Case $task == "PartyQuest"
		 PartyMap()
	  Case Else
		 ;_LOG("DO NOTHING")
	  EndSelect

   Sleep(1000)
WEnd


#Region ### PartyMap ###

Func PartyMap()
;_StreamIniWrite($PARTYQUEST_SECTION_CONFIG,"backButtonXInBattle",200)
;$backButtonInBattleX = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "backButtonXInBattle",Null)
;_LOG($backButtonInBattleX)

PartyQuestCreateGUI()


While 1
   Sleep(1000)
WEnd

EndFunc

Func PartyQuestCreateGUI()
Global $btBackInBattleId =  GUICtrlCreateButton("BT In Battle",50,50,150,30)
GUICtrlSetOnEvent($btBackInBattleId, "checkDataInMouse")

$btBackInBattleX = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btBackInBattleX",0)
$btBackInBattleY = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btBackInBattleY",0)
$btBackInBattleCl = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btBackInBattleCl",0)

If $btBackInBattleX == 0 Or $btBackInBattleY == 0 Then
   GUICtrlSetBkColor($btBackInBattleId,$COLOR_RED)
Else
   GUICtrlSetBkColor($btBackInBattleId, $COLOR_GREEN)
EndIf
;
Global $btBackInWaitingId =  GUICtrlCreateButton("BT Back In Waiting",220,50,150,30)
GUICtrlSetOnEvent($btBackInWaitingId, "checkDataInMouse")

$btBackInWaitingX = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btBackInWaitingX",0)
$btBackInWaitingY = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btBackInWaitingY",0)
$btBackInWaitingCl = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btBackInWaitingCl",0)

If $btBackInWaitingX == 0 Or $btBackInWaitingY == 0 Then
   GUICtrlSetBkColor($btBackInWaitingId,$COLOR_RED)
Else
   GUICtrlSetBkColor($btBackInWaitingId, $COLOR_GREEN)
EndIf
;
Global $btEmoInWaitingId =  GUICtrlCreateButton("BT EMO In Waiting",50,90,150,30)
GUICtrlSetOnEvent($btEmoInWaitingId, "checkDataInMouse")

$btEmoInWaitingX = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btEmoInWaitingX",0)
$btEmoInWaitingY = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btEmoInWaitingY",0)
$btEmoInWaitingCl = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btEmoInWaitingCl",0)

If $btEmoInWaitingX == 0 Or $btEmoInWaitingY == 0 Then
   GUICtrlSetBkColor($btEmoInWaitingId,$COLOR_RED)
Else
   GUICtrlSetBkColor($btEmoInWaitingId, $COLOR_GREEN)
EndIf
;
Global $btInExplorerId =  GUICtrlCreateButton("Button In Explorer",220,90,150,30)
GUICtrlSetOnEvent($btEmoInWaitingId, "checkDataInMouse")

$btInExplorerX = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btInExplorerX",0)
$btInExplorerY = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btInExplorerY",0)
$btInExplorerCl = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btInExplorerCl",0)

If $btInExplorerX == 0 Or $btInExplorerY == 0 Then
   GUICtrlSetBkColor($btInExplorerId,$COLOR_RED)
Else
   GUICtrlSetBkColor($btInExplorerId, $COLOR_GREEN)
EndIf
;

EndFunc

Func checkDataInMouse()
$mPos = GetPos()
$mPosRelative = getPositionRelateWindow($mPos[0],$mPos[1])
$realPos = getRealPosByRelativePos($mPosRelative[0],$mPosRelative[1])
$iColor = PixelGetColor(getRealPosByRelativePos($realPos[0],$realPos[1],$windowHWNDs)
Select
	  Case @GUI_CtrlId == $btBackInBattleId
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btBackInBattleX",$mPosRelative[0])
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btBackInBattleY",$mPosRelative[1])
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btBackInBattleCl",$iColor + "")
	  Case @GUI_CtrlId == $btBackInWaitingId
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btBackInWaitingX",$mPosRelative[0])
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btBackInWaitingY",$mPosRelative[1])
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btBackInWaitingCl",$iColor + "")
	  Case @GUI_CtrlId == $btEmoInWaitingId
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btEmoInWaitingX",$mPosRelative[0])
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btEmoInWaitingY",$mPosRelative[1])
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btEmoInWaitingCl",$iColor + "")
	  Case @GUI_CtrlId == $btInExplorerId
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btInExplorerX",$mPosRelative[0])
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btInExplorerY",$mPosRelative[1])
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btInExplorerCl",$iColor + "")
EndSelect

EndFunc

#EndRegion