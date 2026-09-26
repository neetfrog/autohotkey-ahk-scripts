#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

*CapsLock::return
`::Esc

#If GetKeyState("CapsLock", "p")
	`::`
	
	j::Left
	k::Down
	l::Right   
	i::Up
	
	Backspace::Delete
	
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

;;;;;;;;;

!4::Send !{F4}

;;;;;;;;;

#WheelDown::Send {Volume_Down}
#WheelUp::Send {Volume_Up}
#MButton::Send {Volume_Mute}

;;;;;;;;;

; escape minimize
$Escape::
	KeyWait, Escape, T.5
	If %ErrorLevel%
		WinMinimize, A
	else
		Send {Escape}
	KeyWait Escape
Return

;;;;;;;;;

#h::
DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)

#y::
DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 0)

;;;;;;;;;

#IfWinActive ahk_exe Lightroom.exe

PgDn::Send {NumpadSub}
PgUp::Send {NumpadAdd}