#include-once

#include <MsgBoxConstants.au3>

#Region ### Throw Error  ###

;===============================================================================
; Description:      Display an error message and optionally exit or set
;                   error codes and return values. Enables single-line
;                   error handling for basic needs.
; Parameter(s):     $txt        = message to display
;                   [$exit]     = 1 to exit after error thrown, 0 to return
;                   [$ret]      = return value
;                   [$err]      = error code to return to parent function if $exit = 0
;                   [$ext]      = extended error code to return to parent function if $exit = 0
;                   [$time]     = time to auto-close message box, in seconds (0 = never)
; Requirement(s):   None
; Return Value(s):
; Note(s):          Icon is STOP for EXIT/FATAL errors and EXCLAMATION for NO_EXIT/WARNING errors.
;                   For single-line error-reporting. If reporting an error in a function,
;                   can call this with a Returned value as:
;                       If $fail Then Return _ThrowError("failed",0,$return_value)
;===============================================================================
Func _ThrowError($txt, $exit = 0, $ret = "", $err = 0, $ext = 0, $time = 0)
    If $exit = 0 Then
        MsgBox(48, @ScriptName, $txt, $time) ; Exclamation, return with error code
        Return SetError($err, $ext, $ret)
    Else
        MsgBox(16, @ScriptName, $txt, $time) ; Stop, quit after error
        Exit ($err)
    EndIf
EndFunc

#EndRegion

Func _LOG($mess)
ConsoleWrite($mess & @CRLF)
EndFunc



























