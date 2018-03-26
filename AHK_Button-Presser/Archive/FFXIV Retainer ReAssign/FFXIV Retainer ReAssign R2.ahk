; FFXIV Retainer Venture Re-Assigning Macro
;
; Modified from original made in 20150318
; 20161031 - Added Pause script and cleaned up
; 20161101 - Throws an error if input is left blank.
; 
;
; Simple script to send your retainers back out on the same venture while you are away!
; The amount of time to pause (in milliseconds) between 0 and 2147483647 (24 days), which can be an expression.
; 1 sec = 1000, 1 min = 60000, 1 hour = 3600000, (33s * 100) = 3300000
;


global PauseStatus = 0
global InitTime = 0
global NumOfVentures = 0
global SleepyTime = 0
global Retainers
global Retainers_SP


MsgBox,0,Intro, This simply presses buttons for you`, make you they have already started a venture you want to repeat!`nYou can press Alt + Q to quit or the Pause/Break key to pause the program at any time.`n-Ava,3

ParametersInput()

StartMacro:
MsgBox,4,Parameters, Your selections:`nMacro wait time = %SleepyTime%`nNumber of ventures to run = %NumOfVentures%.`nSending out retainer %Retainers%`n`n Is this correct?,
IfMsgBox No
	{	
		ParametersInput()
		goto, StartMacro
	}
MsgBox,0,Notice!, To run this macro press Ctrl + Alt + V or press Alt + Q to quit at any time.,2		
^!v::
SplashTextOn, 200, 50, Start, The Venture Re-Assigning Macro is starting,`nwaiting %InitTime% minutes for completion.
sleep 2000
SplashTextOff
starttime := InitTime * 60000
Sleep %starttime%
Loop, %NumOfVentures%
{
	SplashTextOn, 200, 50, Start, The ReAssign Macro is starting!!
	sleep 2000
	SplashTextOff
	sleep 10000
	retainer := 4
	IfWinNotActive, FINAL FANTASY XIV
		WinActivate, FINAL FANTASY XIV
	WinWaitActive, FINAL FANTASY XIV
	Sleep 3000
	Send {esc}
	Sleep 1000
	Send {esc}
	Sleep 1000
	Loop, %Retainers_SP0%
	{
		Retainer_Indx := Retainers_SP%a_index%
		Retainer_Num := Retainer_Indx - 1
		Send {x down}
		Sleep 300
		Send {Numpad0}
		Sleep 500
		Send {Numpad0}
		sleep 1700
		Loop, %Retainer_Num%.
		{
			Send {Numpad2}
			Sleep 200
		}
		Send {Numpad0}
		sleep 2300
		Send {Numpad0}
		sleep 1200
		Loop, 5
		{
			Send {Numpad2}
			Sleep 250
		}
		Send {Numpad0}
		Sleep 1000
		Send {Numpad4}
		Sleep 1000
		Send {Numpad0}
		Sleep 1000
		Send {Numpad4}
		Sleep 1000
		Send {Numpad0}
		Sleep 1000
		Send {Numpad0}
		Sleep 1000
		Send {Esc}
		Sleep 1000
		Send {Numpad0}
		Send {x up}
		Sleep 2000
		}
	Sleep 2000
	;WinMinimize
	Sleep 100
	waittime := SleepyTime * 60000
	Sleep %waittime%
	Sleep 60000
}
ExitApp




;----------------HotKeys----------------

!q::ExitApp

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
}
;----------------HotKeysEND-------------



;----------------Functions Blocks----------------

ParametersInput()
{
	InputBox, InitTime, Initial Time, The number of minutes left until the first round of ventures is completed`n(i.e. You just sent them out and they have 32 mins left until completion).
	InputBox, NumOfVentures, Number of Ventures, The number of times you want to sent all of them out (ventures / Number of Retainers).
	InputBox, SleepyTime, Time, The time it takes in minutes it takes for each venture`nUsually 40/50/60 minutes depending on the items gathered.
	InputBox, Retainers, Who Shall Go?, Enter which Retainer you want to send out. `ni.e. 1`,2 for the first two`, or 1`,2`,3`,4`,5`,6`,7`,8 for all eight., ,320,240,,,,,1`,2`,3`,4`,5`,6`,7`,8
	StringReplace, RetainersNS, Retainers, %A_SPACE%,,All		;Removes any spaces from string
	StringSplit, Retainers_SP, RetainersNS, `,					;Creates an array using comma delimiting
;	StringReplace, RetainersNS2, RetainersNS, `, ,,All			;Removes any commas from string
;	StringLen, RetainersLen, RetainersNS2						;returns the string length from RetainersNS2 into RetainersLen
}



