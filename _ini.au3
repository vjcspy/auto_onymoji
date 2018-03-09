#include-once

#include <WinAPIFiles.au3>

Func _StreamIniDelete($sSection = "", $sKey = Default, $sStream = "DEFAULT")
    If $sSection = "" Then
        ;completely delete ini file stream through winapi (built in filedelete doesn't support it)
        Return _WinAPI_DeleteFile(_StreamIniPath($sStream, 1))
    Else
        Return IniDelete(_StreamIniPath($sStream, 1), $sSection, $sKey)
    EndIf
EndFunc

Func _StreamIniRead($sSection, $sKey, $sDefault, $sStream = "DEFAULT")
    Return IniRead(_StreamIniPath($sStream, 1), $sSection, $sKey, $sDefault)
EndFunc

Func _StreamIniReadSection($sSection, $sStream = "DEFAULT")
    Return IniReadSection(_StreamIniPath($sStream, 1), $sSection)
EndFunc

Func _StreamIniReadSectionNames($sStream = "DEFAULT")
    Return IniReadSectionNames(_StreamIniPath($sStream, 1))
EndFunc

Func _StreamIniRenameSection($sSection, $sNewSection, $iFlag = 0, $sStream = "DEFAULT")
    Return IniRenameSection(_StreamIniPath($sStream), $sSection, $sNewSection, $iFlag)
EndFunc

Func _StreamIniWrite($sSection, $sKey, $sValue, $sStream = "DEFAULT")
    Return IniWrite(_StreamIniPath($sStream), $sSection, $sKey, $sValue)
EndFunc

Func _StreamIniWriteSection($sSection, $vData, $iIndex = 1, $sStream = "DEFAULT")
    Return IniWriteSection(_StreamIniPath($sStream), $sSection, $vData, $iIndex)
EndFunc

Func _StreamIniPath($sStream = "DEFAULT", $iRead = 0)
    Local Static $sBase = ""
    Local $sPath = ""

    If StringLen($sStream) Then
        If $sBase = "" Then
            If DriveGetFileSystem(StringLeft(@ScriptDir, 2)) = "NTFS" Then
                ;current drive is NTFS (supports streams)
                $sBase = @ScriptFullPath
            Else
                ;current drive is not NTFS (no stream support)
                ;fallback to regular path
                $sBase = @TempDir & "\" & @ScriptName
            EndIf
        EndIf
        If $sBase = @ScriptFullPath Then
            $sPath = $sBase & ":" & $sStream
        Else
            ;create directory if necessary
            If Not $iRead And DirGetSize($sBase) = -1 Then DirCreate($sBase)
            $sPath = $sBase & "\" & $sStream & ".ini"
        EndIf
    EndIf

    Return $sPath
EndFunc
