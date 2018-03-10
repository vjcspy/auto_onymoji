#include-once

#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include <WinAPI.au3>
#include <Windowsconstants.au3> ; Khai báo các hằng $WM_ ... bằng cách include thư viện
#include "_helper.au3"

; CONFIGURATION
Const $WINDOW_TITILE = "NoxPlayer"

#Region ### GET HANDLE ###

; Get HWNDS
WinActive($WINDOW_TITILE)
Global $windowHWNDs = WinGetHandle($WINDOW_TITILE)
Global $hwnd = $windowHWNDs

;MsgBox($MB_SYSTEMMODAL, "FOUND WINDOW", $windowHWNDs)

; get Win Position
Global $aPos = WinGetPos($windowHWNDs)
If $aPos == 0 Then _ThrowError("NOT FOUND WINDOW") EndIf

;MsgBox($MB_SYSTEMMODAL, "", "X-Pos: " & $aPos[0] & @CRLF & _"Y-Pos: " & $aPos[1] & @CRLF & _"Width: " & $aPos[2] & @CRLF & _"Height: " & $aPos[3])

Func getWindowX()
   Return $aPos[0]
EndFunc

Func getWindowY()
   Return $aPos[1]
EndFunc


Func getWindowWidth()
   Return $aPos[2]
EndFunc

Func getWindowHeight()
   Return $aPos[3]
EndFunc

#EndRegion

#Region ### CLICK  ###
; Lib

Const $MK_LBUTTON = 0x1

Const $MK_MBUTTON = 0x10

Const $MK_RBUTTON = 0x2  ; Khai báo các giá trị hằng


Func pclick($x=0,$y=0,$numberOfClick = 1,$button='Left Double Click')

$lParam = ($y * 65536) + ($x)

    Switch $button

        Case $button='Left Click'

            _WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,$lParam)

            _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,$lParam)

        Case $button='Left Double Click'

            _WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,$lParam)

            _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,$lParam)

            _WinAPI_PostMessage($hwnd, $WM_LBUTTONDBLCLK, $MK_LBUTTON,$lParam)

            _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,$lParam)

        Case $button='Middle Click'

            _WinAPI_PostMessage($hwnd, $WM_MBUTTONDOWN, $MK_MBUTTON,$lParam)

            _WinAPI_PostMessage($hwnd, $WM_MBUTTONUP, 0,$lParam)

        Case $button='Middle Double Click'

            _WinAPI_PostMessage($hwnd, $WM_MBUTTONDOWN, $MK_MBUTTON,$lParam)

            _WinAPI_PostMessage($hwnd, $WM_MBUTTONUP, 0,$lParam)

            _WinAPI_PostMessage($hwnd, $WM_MBUTTONDBLCLK, $MK_MBUTTON,$lParam)

            _WinAPI_PostMessage($hwnd, $WM_MBUTTONUP, 0,$lParam)

        Case $button='Right Click'

            _WinAPI_PostMessage($hwnd, $WM_RBUTTONDOWN, $MK_RBUTTON,$lParam)

            _WinAPI_PostMessage($hwnd, $WM_RBUTTONUP, 0,$lParam)

        Case $button='Right Double Click'

            _WinAPI_PostMessage($hwnd, $WM_RBUTTONDOWN, $MK_RBUTTON,$lParam)

            _WinAPI_PostMessage($hwnd, $WM_RBUTTONUP, 0,$lParam)

            _WinAPI_PostMessage($hwnd, $WM_RBUTTONDBLCLK, $MK_RBUTTON,$lParam)

            _WinAPI_PostMessage($hwnd, $WM_RBUTTONUP, 0,$lParam)

        Case $button='Mouse Move'

            _WinAPI_PostMessage($hwnd, $WM_MOUSEMOVE, 0,$lParam)

            _WinAPI_PostMessage($hwnd, $WM_MOUSEMOVE, 0,$lParam)

    EndSwitch

EndFunc

#EndRegion

#Region ### COMMUNICATE WITH WINDOW ###
; Click base on realative percent of x,y
Func clickBaseOnRelativePosition($x,$y,$numberClick = 1)
   pclick(getRealPosByRelativePos($x,$y)[0], getRealPosByRelativePos($x,$y)[1], $numberClick)
EndFunc

Func getPositionRelateWindow($x,$y)
   Local $a[2]
   If ($x- getWindowX()) <= getWindowWidth() Then
	  $a[0] = Round(($x- getWindowX()) * 100 / getWindowWidth(),5)
   Else
	  _ThrowError("Point out of window",1) ; Exit when msgbox closed
   EndIf

  If ($y- getWindowY()) <= getWindowHeight() Then
	  $a[1] = Round(($y- getWindowY()) * 100 / getWindowHeight(),5)
   Else
	  _ThrowError("Point out of window",1) ; Exit when msgbox closed
   EndIf
_LOG("Relative position:" & $a[0] & " " & $a[1])
Return $a
EndFunc

Func getRealPosByRelativePos($x,$y)
Local $a[2]
$a[0] = Round(getWindowX() + $x * getWindowWidth()/100 ,5)
$a[1] = Round(getWindowY() + $y * getWindowHeight()/100 ,5)

;_LOG("Real position:", $a[0] & " " & $a[1])
Return $a
EndFunc

Func getRealCoordinateBaseOnPercent($x,$y)
   Return getRealPosByRelativePos($x,$y)
EndFunc

Func clickOn($x,$y,$numberClick = 1)
  pclick($w, $h, $numberClick)
EndFunc


#EndRegion
