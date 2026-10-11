#NoEnv
#Warn
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2

; ============================================================
; INITIALIZATION
; AutoHotkey v1.1
; ============================================================


; ============================================================
; CAPSLOCK LAYER
; CapsLock acts as a modifier, not a toggle.
; ============================================================

*CapsLock::Return



#If GetKeyState("CapsLock", "P")

    ; Arrow keys
    j::Left
    k::Down
    l::Right
    i::Up

    ; Editing
    Backspace::Delete
    u::^Left
    o::^Right
    h::Home
    `;::End

    ; Function keys
    1::F1
    2::F2
    3::F3
    4::F4
    5::F5
    6::F6
    7::F7
    8::F8
    9::F9
    0::F10
    -::F11
    =::F12

#If


; ============================================================
; GLOBAL SHORTCUTS
; ============================================================

; Win + Alt + F4 equivalent: Alt + F4
!4::SendInput, !{F4}


; ============================================================
; VOLUME CONTROL
; Win + mouse wheel / middle button
; ============================================================

#WheelDown::SendInput, {Volume_Down}
#WheelUp::SendInput, {Volume_Up}
#MButton::SendInput, {Volume_Mute}


; ============================================================
; ESCAPE
; Tap  = Escape
; Hold = Minimize active window
; ============================================================

$Escape::
    KeyWait, Escape, T0.5

    if (ErrorLevel)
    {
        WinMinimize, A
        KeyWait, Escape
    }
    else
    {
        SendInput, {Escape}
    }
Return


; ============================================================
; POWER CONTROLS
; Win + H = Hibernate
; Win + Y = Sleep
; ============================================================

#h::
    DllCall("PowrProf\SetSuspendState", "Int", 1, "Int", 0, "Int", 0)
Return

#y::
    DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 1, "Int", 0)
Return


; ============================================================
; ADOBE LIGHTROOM CLASSIC
; Page Down = Previous adjustment
; Page Up   = Next adjustment
; ============================================================

#IfWinActive ahk_exe Lightroom.exe

    PgDn::SendInput, {NumpadSub}
    PgUp::SendInput, {NumpadAdd}

#IfWinActive
