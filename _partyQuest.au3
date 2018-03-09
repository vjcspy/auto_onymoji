#include-once

#include "_ini.au3"
#include "_helper.au3"

Const $PARTYQUEST_SECTION_CONFIG = "partyQuest"

Func PartyQuest()
;_StreamIniWrite($PARTYQUEST_SECTION_CONFIG,"backButtonXInBattle",200)
;$backButtonInBattleX = _StreamIniRead($PARTYQUEST_SECTION_CONFIG, "backButtonXInBattle",Null)
;_LOG($backButtonInBattleX)

PartyQuestCreateGUI()
EndFunc

Func PartyQuestCreateGUI()
Global $btBackInBattleId =  GUICtrlCreateButton("BT In Battle",50,50,150,30)
Global $btBackInWaitingId =  GUICtrlCreateButton("BT Back In Waiting",220,50,150,30)
Global $btEmoInWaitingId =  GUICtrlCreateButton("BT EMO In Waiting",50,90,150,30)
Global $btInExplorerId =  GUICtrlCreateButton("Button In Explorer",220,90,150,30)

EndFunc

Func PartyQuestDestroyGUI()
GUICtrlDelete($btBackInBattleId)
GUICtrlDelete($btBackInWaitingId)
GUICtrlDelete($btEmoInWaitingId)
GUICtrlDelete($btInExplorerId)

EndFunc



