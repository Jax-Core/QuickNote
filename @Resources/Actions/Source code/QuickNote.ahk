#SingleInstance Force
#NoTrayIcon

IniRead, OutputVar, Hotkeys.ini, Variables, Key
IniRead, RainmeterPath, Hotkeys.ini, Variables, RMPATH

Hotkey,%OutputVar%,Button

Name = ValliStart.ahk
DetectHiddenWindows On
SetTitleMatchMode RegEx
IfWinExist, i)%Name%.* ahk_class AutoHotkey
{
    ValliScriptPath = % RegExReplace(a_scriptdir,"QuickNote.*\\?$")"Vallistart\@Resources\Actions\Source code\Vallistart.ahk"
    ValliAhkPath = % RegExReplace(a_scriptdir,"QuickNote.*\\?$")"Vallistart\@Resources\Actions\"
    Run, %ValliAhkPath%AHKv1.exe `"%ValliScriptPath%`", %ValliAhkPath%
}
Return

Button:
    Run "%RainmeterPath% "!UpdateMeasure "mToggle" "QuickNote\Main" "
Return