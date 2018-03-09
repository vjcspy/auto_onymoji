#include-once
#Include <Misc.au3>

Global $hUserDll = DllOpen("user32.dll")

Func GetPos()

    While 1
        ;Local $msg = TrayGetMsg()
        ;If $msg Then
            ; do something meaningful
            ; ConsoleWrite("TrayGetMsg()=" & $msg & @LF)
        ;Else
            ToolTip("Click here")
            If _IsPressed("01", $hUserDll) Then ExitLoop
        ;EndIf
    WEnd
    ToolTip("")

    Return MouseGetPos()
EndFunc