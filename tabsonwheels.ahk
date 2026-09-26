; ---------------------------------------------------- ;
;                    TabsOnWheels                      ;
; ---------------------------------------------------- ;
; Switch browser (or other program's) tabs with your mouse wheel when hovering over the tab bar (and optionally address bar).
; Press Middle/Wheel Mouse Click to switch tabs from anywhere in the program.
; If the target window is inactive when starting to scroll, it will be activated.
;
; Install https://www.autohotkey.com/ (Windows only) to run.
; To auto-start, copy the script or a shortcut to your
; Start Menu\Programs\Startup directory
; (%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup)
;
; BUGS:
; Makes tabSwitchAnywhereKey trigger on release, not on click.  That's bad for fast games. xD
; Sometimes the tab switch activates randomly
; It's also triggered when using mouse wheel in a web page's select menus, for some reason


; Area to enable tab wheel scroll.  ~45 for tab bar, ~80 to include address bar
tabAreaHeight := 80
; Key or button to enable tab scrolling anywhere in  the program.  RButton for right mouse button, MButton for Middle/Wheel button.
tabSwitchAnywhereKey := "MButton"

; List of WindowClass: "Descriptions".  Change a program's "Description" to False to disable it.
enabledPrograms := {Chrome_WidgetWin_1: "Chrome, Chromium", MozillaWindowClass: "Firefox", IEFrame: "Internet Explorer", ApplicationFrameWindow: "Edge", "Notepad++": "Notepad++", TMainForm: "HeidiSQL - heidisql.exe", "SunAwtFrame_NotWorking": "IntelliJ Idea - idea64.exe", AcrobatSDIWindow: "Adobe Acrobat DC Pro", Solitaire: False}

VERSION := 3

#NoEnv	; Disable using enviroment variables without calling EnvGet(), for performance.
#Warn	; Detect common errors.
#SingleInstance force	
#UseHook Off	; Using the keyboard hook is usually preferred for hotkeys - but here we only need the mouse hook.
#InstallMouseHook
#MaxHotkeysPerInterval 1000	; Avoids warning messages for high speed wheel users.

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.


Menu, Tray, Tip, TabsOnWheels %VERSION%
Menu, Tray, Icon, imageres.dll, 306

; Register tabSwitchAnywhereKey to make it a prefix and prevent its normal behaviour
Hotkey, %tabSwitchAnywhereKey% & WheelUp, TabsOnWheels
Hotkey, %tabSwitchAnywhereKey% & WheelDown, TabsOnWheels

; Enable tabSwitchAnywhereKey when clicked by itself
Hotkey, %tabSwitchAnywhereKey%, SendThisHotkey

WheelUp::
WheelDown::
;RButton & WheelUp::
;RButton & WheelDown::
Gosub TabsOnWheels
Return


SendThisHotkey:
	Send {%A_ThisHotkey%}
	Return

TabsOnWheels:
	;; Compare mouse position on the screen with the window beneath
	;; to check if we are in the tab area
	CoordMode, Mouse, Screen
	MouseGetPos, mouseXPos, mouseYPos, winId
	WinGetPos, winXPos, winYPos, winWidth, winHeight, ahk_id %winId%

	WinGetClass, winClass, ahk_id %winId% ; Get Window class

	; Check if we got an enabled class, and if pointer is over tab bar or tabSwitchAnywhereKey is pressed
	If (enabledPrograms.hasKey(winClass) AND (GetKeyState(tabSwitchAnywhereKey, "P") OR (mouseYPos > winYPos and mouseYPos < winYPos + tabAreaHeight)))
	{
		IfWinNotActive ahk_id %winId%
			WinActivate ahk_id %winId%	; Focus target window
		If A_ThisHotkey in WheelUp,%tabSwitchAnywhereKey% & WheelUp
			Send ^+{Tab}
		Else
			Send ^{Tab}
	}
	Else
	{
		Send {%A_ThisHotkey%}
	}
	Return