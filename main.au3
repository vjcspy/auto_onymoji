#include <GUIConstantsEx.au3>
#include <ColorConstants.au3>
#include "_core.au3"
#include "_helper.au3"
#include "_record_mouse_click.au3"
#include "_ini.au3"

Const $TASKS = "|PartyQuest|Test";
Const $PARTYQUEST_SECTION_CONFIG = "partyQuest"
Global $isTesting = True

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

#Region ### General Button - Reuse ###
Global $btBackInWaitingId,$btEmoInWaitingId,$btQuitOKId
Func GeneralUICreate()
   IF $btBackInBattleId <> "" Then GUICtrlDelete($btBackInBattleId) EndIf
   IF $btInExplorerId <> "" Then GUICtrlDelete($btInExplorerId) EndIf
   IF $btInviteId <> "" Then GUICtrlDelete($btInviteId) EndIf

   ;
   $btBackInBattleId =  GUICtrlCreateButton("BT In Battle",50,50,150,30)
   GUICtrlSetOnEvent($btBackInBattleId, "checkDataInMouse")

   ;
   $btInExplorerId =  GUICtrlCreateButton("Button In Explorer",220,90,150,30)
   GUICtrlSetOnEvent($btInExplorerId, "checkDataInMouse")

   ;
   $btInviteId =  GUICtrlCreateButton("BT Invite",50,130,150,30)
   GUICtrlSetOnEvent($btInviteId, "checkDataInMouse")

EndFunc

#EndRegion

#Region ### PartyMap ###
Func checkStatePartyMap()

; luc danh nhau thi nut back D5C4A2 va co vi tri tuong doi 2.8085 9.6960
Local $realPositionOfBackButonInBattle = getRealCoordinateBaseOnPercent($btBackInBattleX,$btBackInBattleY)
Local $btBackInBatteleColor = PixelGetColor($realPositionOfBackButonInBattle[0], $realPositionOfBackButonInBattle[1],$windowHWNDs)

; Man hinh cho nut back 0xEEF6FE va co vi tri 3.0638 12.87988
Local $realPosOfBackButtonInWait = getRealCoordinateBaseOnPercent($btBackInWaitingX,$btBackInWaitingY)
Local $btBackInWaitColor = PixelGetColor($realPosOfBackButtonInWait[0], $realPosOfBackButtonInWait[1],$windowHWNDs)

; Button out OK
Local $realPosOfOKBackButtonInWait = getRealCoordinateBaseOnPercent(57.70212,58.176555)

; cua minh Cai nay thi phai tu check thoi, tuy thuoc vao avartar cua 2 nguoi
Local $realPosOfEmoButtonInWait = getRealCoordinateBaseOnPercent($btEmoInWaitingX,$btEmoInWaitingY)
Local $btEmoInWaitColor = PixelGetColor($realPosOfEmoButtonInWait[0], $realPosOfEmoButtonInWait[1],$windowHWNDs)

; nut o ngoai tham hiem
Local $realPosOfButtonInExplo = getRealCoordinateBaseOnPercent($btInExplorerX,$btInExplorerY)
Local $btInExploColor = PixelGetColor($realPosOfButtonInExplo[0], $realPosOfButtonInExplo[1],$windowHWNDs)

; Pt color 56B15F
Local $realPosButtonParty = getRealCoordinateBaseOnPercent($btInviteX,$btInviteY)
Local $btPartyColor = PixelGetColor($realPosButtonParty[0], $realPosButtonParty[1],$windowHWNDs)

; spamClick
Local $realPosOfSpamClick = getRealCoordinateBaseOnPercent(22.85106,7.95947)

If $btPartyColor == $btInviteCl Then ; when invite
   _LOG("PARTY INVITE")
   IF $isTesting == FALSE THEN
	  MouseClick($MOUSE_CLICK_LEFT, $realPosButtonParty[0], $realPosButtonParty[1], 2)
   EndIf
ElseIf $btInExploColor == $btInExplorerCl Then ;when explorer
    _LOG("IN EXPLORER")
ElseIf $btBackInWaitColor == $btBackInWaitingCl Then ;when waiting
   IF $btEmoInWaitColor == $btEmoInWaitingCl Then
	  _LOG("WAITING")
   Else
	  _LOG("OUTED")
	  IF $isTesting == FALSE THEN
		 MouseClick($MOUSE_CLICK_LEFT, $realPosOfBackButtonInWait[0], $realPosOfBackButtonInWait[1], 2)
	  EndIf

	Sleep(500)
	IF $isTesting == FALSE THEN
	  MouseClick($MOUSE_CLICK_LEFT, $realPosOfOKBackButtonInWait[0], $realPosOfOKBackButtonInWait[1], 2)
	EndIf
   EndIf
ElseIf $btBackInBatteleColor == $btBackInBattleCl Then ;when battle
    _LOG("IN BATELE")
Else
	_LOG("SPAM")
   IF $isTesting == FALSE THEN
	  MouseClick($MOUSE_CLICK_LEFT, $realPosOfSpamClick[0], $realPosOfSpamClick[1], 2)
   EndIf
EndIf

EndFunc

Global $btBackInBattleId,$btInExplorerId,$btInviteId, $btRewardId
Func PartyQuestCreateGUI()
   IF $btBackInWaitingId <> "" Then GUICtrlDelete($btBackInWaitingId) EndIf
   IF $btEmoInWaitingId <> "" Then GUICtrlDelete($btEmoInWaitingId) EndIf
   IF $btQuitOKId <> "" Then GUICtrlDelete($btQuitOKId) EndIf

;
$btBackInWaitingId =  GUICtrlCreateButton("BT Back In Waiting",220,50,150,30)
GUICtrlSetOnEvent($btBackInWaitingId, "checkDataInMouse")

;
$btEmoInWaitingId =  GUICtrlCreateButton("BT EMO In Waiting",50,90,150,30)
GUICtrlSetOnEvent($btEmoInWaitingId, "checkDataInMouse")

;
$btQuitOKId =  GUICtrlCreateButton("$btQuitOKId",220,130,150,30)
GUICtrlSetOnEvent($btQuitOKId, "checkDataInMouse")

$btRewardId =  GUICtrlCreateButton("$btRewardId",50,170,150,30)
GUICtrlSetOnEvent($btRewardId, "checkDataInMouse")

EndFunc
#EndRegion

#Region INI_DATA
Func initINIData()
; GENERAL
Global $btBackInBattleX = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btBackInBattleX",0)
Global $btBackInBattleY = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btBackInBattleY",0)
Global $btBackInBattleCl = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btBackInBattleCl",0)
   If $btBackInBattleX == 0 Or $btBackInBattleY == 0 Then
	  GUICtrlSetBkColor($btBackInBattleId,$COLOR_RED)
   Else
	  GUICtrlSetBkColor($btBackInBattleId, $COLOR_GREEN)
   EndIf

Global $btInExplorerX = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btInExplorerX",0)
Global $btInExplorerY = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btInExplorerY",0)
Global $btInExplorerCl = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btInExplorerCl",0)
   If $btInExplorerX == 0 Or $btInExplorerY == 0 Then
	  GUICtrlSetBkColor($btInExplorerId,$COLOR_RED)
   Else
	  GUICtrlSetBkColor($btInExplorerId, $COLOR_GREEN)
   EndIf

Global $btInviteX = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btInviteX",0)
Global $btInviteY = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btInviteY",0)
Global $btInviteCl = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btInviteCl",0)
   If $btInviteX == 0 Or $btInviteY == 0 Then
	  GUICtrlSetBkColor($btInviteId,$COLOR_RED)
   Else
	  GUICtrlSetBkColor($btInviteId, $COLOR_GREEN)
   EndIf

; PARTY MAP
Global $btBackInWaitingX = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btBackInWaitingX",0)
Global $btBackInWaitingY = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btBackInWaitingY",0)
Global $btBackInWaitingCl = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btBackInWaitingCl",0)
If $btBackInWaitingX == 0 Or $btBackInWaitingY == 0 Then
   GUICtrlSetBkColor($btBackInWaitingId,$COLOR_RED)
Else
   GUICtrlSetBkColor($btBackInWaitingId, $COLOR_GREEN)
EndIf

Global $btEmoInWaitingX = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btEmoInWaitingX",0)
Global $btEmoInWaitingY = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btEmoInWaitingY",0)
Global $btEmoInWaitingCl = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btEmoInWaitingCl",0)
If $btEmoInWaitingX == 0 Or $btEmoInWaitingY == 0 Then
   GUICtrlSetBkColor($btEmoInWaitingId,$COLOR_RED)
Else
   GUICtrlSetBkColor($btEmoInWaitingId, $COLOR_GREEN)
EndIf

Global $btQuitOkX = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btQuitOkX",0)
Global $btQuitOkY = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btQuitOkY",0)
Global $btQuitOkCl = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btQuitOkCl",0)
If $btQuitOkX == 0 Or $btQuitOkY == 0 Then
   GUICtrlSetBkColor($btQuitOKId,$COLOR_RED)
Else
   GUICtrlSetBkColor($btQuitOKId, $COLOR_GREEN)
EndIf

Global $btRewardX = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btRewardX",0)
Global $btRewardY = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btRewardY",0)
Global $btRewardCl = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "$btRewardCl",0)
If $btRewardX == 0 Or $btRewardY == 0 Then
   GUICtrlSetBkColor($btRewardId,$COLOR_RED)
Else
   GUICtrlSetBkColor($btRewardId, $COLOR_GREEN)
EndIf

EndFunc

Func checkDataInMouse()
$mPos = GetPos()
$mPosRelative = getPositionRelateWindow($mPos[0],$mPos[1])
$realCoor = getRealCoordinateBaseOnPercent($mPosRelative[0],$mPosRelative[1])
$iColor = PixelGetColor($realCoor[0],$realCoor[1],$windowHWNDs)
_LOG("mouseColor: " & $iColor)

; test retrieve color
Local $_testPos = getRealCoordinateBaseOnPercent($mPosRelative[0],$mPosRelative[1])
Local $_testCl = PixelGetColor($_testPos[0], $_testPos[1],$windowHWNDs)
_LOG("retrieveColor: " & $_testCl)

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
	  Case @GUI_CtrlId == $btInviteId
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btInviteX",$mPosRelative[0])
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btInviteY",$mPosRelative[1])
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btInviteCl",$iColor + "")
	  Case @GUI_CtrlId == $btQuitOKId
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btQuitOkX",$mPosRelative[0])
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btQuitOkY",$mPosRelative[1])
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btQuitOkCl",$iColor + "")
	  Case @GUI_CtrlId == $btRewardId
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btRewardX",$mPosRelative[0])
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btRewardY",$mPosRelative[1])
		 _StreamIniWrite($PARTYQUEST_SECTION_CONFIG, "$btRewardCl",$iColor + "")
EndSelect

; reload data
initINIData()
EndFunc

#EndRegion

#Region TASK

GeneralUICreate()
PartyQuestCreateGUI()

initINIData()
 While 1
   Select
	  Case $task == "Test"
		 test()
	  Case $task == "PartyQuest"
		 _LOG("START_PartyQuest")
		 While 1
		 If $task <> "PartyQuest" Then ExitLoop
		 checkStatePartyMap()
		 Sleep(2000)
		 WEnd
	  Case Else
		 ;_LOG("DO NOTHING")
	  EndSelect

   Sleep(1000)
WEnd
#EndRegion
