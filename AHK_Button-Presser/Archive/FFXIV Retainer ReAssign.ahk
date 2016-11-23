; FFXIV Retainer Venture Re-Assigning Macro
;
; Modified from original made in 20150318
; 20161031 - Added Pause script and cleaned up
; 20161101 - Throws an error if input is left blank or zero.
; 20161107 - Fixed some text messages
;
; Simple script to send your retainers back out on the same venture while you are away!
; The amount of time to pause (in milliseconds) between 0 and 2147483647 (24 days), which can be an expression.
; 1 sec = 1000, 1 min = 60000, 1 hour = 3600000, (33s * 100) = 3300000
;

pausestatus = 0
RetainerArray := Object()

MsgBox,0,Intro, This simply presses buttons for you`, make you they have already started a venture you want to repeat!`nYou can press Alt + Q to quit or the Pause/Break key to pause the program at any time.`n-Ava,3
InputBox, initime, Initial Time, The number of minutes left until the first round of ventures is completed`n(i.e. You just sent them out and they have 32 minutes left until completion) (Must be greater than 0).
if ErrorLevel OR !initime
MsgBox, This soon??
else
{
	InputBox, numofventures, Number of Ventures, The number of times you want to sent all of them out (ventures / Number of Retainers).
	if ErrorLevel OR !numofventures 
		MsgBox,0,Error 1,Fine press cancel! you'll just have to do it all again.,1
	else
	{
		InputBox, sleepytime, Time, The time it takes in minutes it takes for each venture`nUsually 40/50/60 minutes depending on the items gathered.
		if ErrorLevel OR !sleepytime 
			MsgBox,0,Error 2,Why is this cancel button even here?.,1
		else
		{
			InputBox, numofretainer, Number of Retainers, The number of Retainers you have 1-8.
			if ErrorLevel OR !numofretainer 
				MsgBox,0,ID10T Error,And you were almost done setting up parameters.,1
			else
			{
				MsgBox,0,Parameters, Your selections:`nMacro wait time = %sleepytime%`nNumber of ventures to run = %numofventures%.,2
				MsgBox,0,Notice!, To run this macro press Ctrl + Alt + V or press Alt + Q to quit at any time.,2
				^!v::
				SplashTextOn, 200, 50, Start, The Venture Re-Assigning Macro is starting,`nwaiting %initime% minutes for completion.
				sleep 2000
				SplashTextOff
				starttime := initime * 60000
				Sleep %starttime%
				Loop, %numofventures%
				{
					SplashTextOn, 200, 50, Start, The ReAssign Macro is starting!!
					sleep 2000
					SplashTextOff
					sleep 10000
					retainer := 0
					;IfWinNotActive, FINAL FANTASY XIV
					;	WinActivate, FINAL FANTASY XIV
					;WinWaitActive, FINAL FANTASY XIV
					Sleep 3000
					Send {esc}
					Sleep 1000
					Send {esc}
					Sleep 1000
					Loop, %numofretainer%
					{
						Send {x down}
						Sleep 300
						Send {Numpad0}
						Sleep 500
						Send {Numpad0}
						sleep 1700
						Loop, %retainer%
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
						retainer+=1
					}
					Sleep 2000
					;WinMinimize
					Sleep 100
					waittime := sleepytime * 60000
					Sleep %waittime%
				}	Sleep 60000
			}
			return
		}
	}
}
ExitApp

!q::ExitApp

Pause::
{
	if (pausestatus = 0)
	{
		Pause,toggle,1
		MsgBox,0,Pasuing,Pausing script.,1
		pausestatus = 1
	}
	else
	{
		Pause,toggle,1
		MsgBox,0,Unpasuing,Unpausing script.,1
		pausestatus = 0
	}
}
