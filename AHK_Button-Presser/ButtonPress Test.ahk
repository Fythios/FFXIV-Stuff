; Button Test using PostMessage
;
; Simple script to press buttons in anything using PostMessage
; The amount of time to pause (in milliseconds) between 0 and 2147483647 (24 days), which can be an expression.
; 1 sec = 1000, 1 min = 60000, 1 hour = 3600000, (33s * 100) = 3300000
;

global PauseStatus = 0
global tempkey = 0
global pid1 = 0
global Button = 0
global testbutton = 0

WinGet, id, list, ahk_class FFXIVGAME
Loop, %id%
{
   this_id := id%A_Index%
   WinGet, this_pid, PID, ahk_id %this_id%
   pid%A_Index% := this_pid
}


MsgBox,0,PID,ahk_pid %pid1%

MsgBox,0,Intro, This simply presses a button for you`n-Ava,5
InputBox, Button, Button 1, Press a Key to Test
MsgBox,0,HowTo, To run this macro press Ctrl + Alt + M .`n

;WinWait ,  ahk_class FFXIVGAME,,,,
;WinActivate,  ahk_class FFXIVGAME,,,


;----------------HotKeys----------------
!q::ExitApp

AppsKey::
{
	WinMinimize, FINAL FANTASY XIV
	return
}

Pause::
{
	if (PauseStatus = 0)
	{
		Pause,toggle,1
		MsgBox,0,Pasuing,Pausing script.,1
		PauseStatus = 1
	}
	else
	{
		Pause,toggle,1
		MsgBox,0,Unpasuing,Unpausing script.,1
		PauseStatus = 0
	}
	return
}
;----------------HotKeysEND-------------

^!m::
{
	;MsgBox,0,Button,%Button%
	ChtoHex(Button)
	testbutton := tempkey
	if Button = =
		testbutton := 0xBB
	if Button = -
		testbutton := 0xBD
	;MsgBox,0,testbutton,%testbutton%
	PostMessage, 0x100, testbutton,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, testbutton,,, ahk_pid %pid1% 
	Sleep 1000
}


ChtoHex(text)
{
    Loop, Parse, text
    {
      char:= A_LoopField
       char_number := asc(char)
      char_hex := char_number      
            
      ; Convert a decimal integer to hexadecimal:
      SetFormat, IntegerFast, hex
      char_hex += 0  ; Sets char_number to its hex value.
      char_hex .= ""  ; Necessary due to the "fast" mode.
      SetFormat, IntegerFast, d

      tempkey := char_hex
	} 
return
}


Numpad0Key()
{
	PostMessage, 0x100, 0x60,,, ahk_pid %pid1% 
		Sleep 50
	PostMessage, 0x101, 0x60,,, ahk_pid %pid1%
}

Numpad8Key()
{
	PostMessage, 0x100, 0x68,,, ahk_pid %pid1% 
		Sleep 50
	PostMessage, 0x101, 0x68,,, ahk_pid %pid1%
}

Numpad2Key()
{
	PostMessage, 0x100, 0x62,,, ahk_pid %pid1% 
		Sleep 50
	PostMessage, 0x101, 0x62,,, ahk_pid %pid1%
}

Numpad6Key()
{
	PostMessage, 0x100, 0x66,,, ahk_pid %pid1% 
		Sleep 50
	PostMessage, 0x101, 0x66,,, ahk_pid %pid1%
}

Numpad4Key()
{
	PostMessage, 0x100, 0x64,,, ahk_pid %pid1% 
		Sleep 50
	PostMessage, 0x101, 0x64,,, ahk_pid %pid1%
}

EscKey()
{
	PostMessage, 0x100, 0x1B,,, ahk_pid %pid1% 
		Sleep 50
	PostMessage, 0x101, 0x1B,,, ahk_pid %pid1%
}

NKey()
{
	PostMessage, 0x100, 0x4E ,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, 0x4E ,,, ahk_pid %pid1% 
}