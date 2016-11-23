; FFXIV Retainer Venture Re-Assigning Macro
;
; Modified from original made in 20150318
; 20161031 - Added Pause script and cleaned up
; 20161101 - Throws an error if input is left blank.
; 20161122 - changed output style from Send/SendRaw to PostMessage
; 
;
; Simple script to send your retainers back out on the same venture while you are away!
; The amount of time to pause (in milliseconds) between 0 and 2147483647 (24 days), which can be an expression.
; 1 sec = 1000, 1 min = 60000, 1 hour = 3600000, (33s * 100) = 3300000
;

global pausestatus = 0
global Mini = 0

MsgBox,0,Intro, This simply presses buttons for you`, make you they have already started a venture you want to repeat!`nYou can press Alt + Q to quit or the Pause/Break key to pause the program at any time.`n-Ava,3
Start:
InputBox, initime, Initial Time, The number of minutes left until the first round of ventures is completed`n(i.e. You just sent them out and they have 32 mins left until completion).
if ErrorLevel OR !initime
MsgBox, This soon??
else
{
	InputBox, numofventures, Number of Ventures, The number of times you want to sent all of them out (ventures / Number of Retainers).
	if ErrorLevel OR !numofventures 
		MsgBox,0,Error 1,Fine press cancel! you'll just have to do it all again.,1
	else
	{
		InputBox, sleepytime, Time, The time it takes in minutes it takes for each venture`nUsually 40/50/60 minutes depending on the items gathered., ,320,240,,,,,60
		if ErrorLevel OR !sleepytime 
			MsgBox,0,Error 2,Why is this cancel button even here?.,1
		else
		{
			InputBox, Retainers, Who Shall Go?, Enter which Retainer you want to send out. `ni.e. 1`,2 for the first two`, or 1`,2`,3`,4`,5`,6`,7`,8 for all eight., ,320,240,,,,,1`,2`,3`,4`,5`,6`,7`,8
			if ErrorLevel OR !Retainers 
				MsgBox,0,Error 1,Fine press cancel! you'll just have to do it all again.,1
			else
			{
				StringReplace, RetainersNS, Retainers, %A_SPACE%,,All		;Removes any spaces from string
				StringSplit, Retainers_sp, RetainersNS, `,					;Creates an array using comma delimiting
				StringReplace, RetainersNS2, RetainersNS, `, ,,All			;Removes any commas from string
				StringLen, RetainersLen, RetainersNS2						;returns the string length from RetainersNS2 into RetainersLen
				MsgBox,4,Parameters, Your selections:`nMacro wait time = %sleepytime%`nNumber of ventures to run = %numofventures%.`nSending out retainer %Retainers%`n`n Is this correct?,
				IfMsgBox Yes
				{
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
						sleep 1000
						SplashTextOff
						sleep 2000
						retainer := 4
						WinWait, ahk_class FFXIVGAME,,,,
						WinActivate, ahk_class FFXIVGAME,,,
						Sleep 2000
						PostMessage, 0x100, 0x1B,,, ahk_pid %pid1% 
							Sleep 25
						PostMessage, 0x101, 0x1B,,, ahk_pid %pid1% 
						Sleep 1000
						PostMessage, 0x100, 0x28,,, ahk_pid %pid1% 
							Sleep 25
						PostMessage, 0x101, 0x28,,, ahk_pid %pid1% 
						Sleep 1000
						PostMessage, 0x100, 0x1B,,, ahk_pid %pid1% 
							Sleep 25
						PostMessage, 0x101, 0x1B,,, ahk_pid %pid1% 
						Sleep 1000
						Loop, %Retainers_sp0%
						{
							Retainer_Indx := Retainers_sp%a_index%
							Retainer_Num := Retainer_Indx - 1
							PostMessage, 0x100, 0x58,,, ahk_pid %pid1% 
							Sleep 300
							PostMessage, 0x100, 0x60,,, ahk_pid %pid1% 
								Sleep 25
							PostMessage, 0x101, 0x60,,, ahk_pid %pid1% 
							Sleep 500
							PostMessage, 0x100, 0x60,,, ahk_pid %pid1% 
								Sleep 25
							PostMessage, 0x101, 0x60,,, ahk_pid %pid1% 
							sleep 3000
							Loop, %Retainer_Num%.
							{
								PostMessage, 0x100, 0x28,,, ahk_pid %pid1% 
								Sleep 25
								PostMessage, 0x101, 0x28,,, ahk_pid %pid1% 
								Sleep 200
							}
							PostMessage, 0x100, 0x60,,, ahk_pid %pid1% 
								Sleep 25
							PostMessage, 0x101, 0x60,,, ahk_pid %pid1% 
							sleep 2300
							PostMessage, 0x100, 0x60,,, ahk_pid %pid1% 
								Sleep 25
							PostMessage, 0x101, 0x60,,, ahk_pid %pid1% 
							sleep 1200
							Loop, 5
							{
								PostMessage, 0x100, 0x28,,, ahk_pid %pid1% 
								Sleep 25
								PostMessage, 0x101, 0x28,,, ahk_pid %pid1% 
								Sleep 250
							}
							PostMessage, 0x100, 0x60,,, ahk_pid %pid1% 
								Sleep 25
							PostMessage, 0x101, 0x60,,, ahk_pid %pid1% 
							Sleep 1000
							PostMessage, 0x100, 0x25,,, ahk_pid %pid1% 
								Sleep 25
							PostMessage, 0x101, 0x25,,, ahk_pid %pid1% 
							Sleep 1000
							PostMessage, 0x100, 0x60,,, ahk_pid %pid1% 
								Sleep 25
							PostMessage, 0x101, 0x60,,, ahk_pid %pid1% 
							Sleep 1000
							PostMessage, 0x100, 0x25,,, ahk_pid %pid1% 
								Sleep 25
							PostMessage, 0x101, 0x25,,, ahk_pid %pid1% 
							Sleep 1000
							PostMessage, 0x100, 0x60,,, ahk_pid %pid1% 
								Sleep 25
							PostMessage, 0x101, 0x60,,, ahk_pid %pid1% 
							Sleep 1000
							PostMessage, 0x100, 0x60,,, ahk_pid %pid1% 
								Sleep 25
							PostMessage, 0x101, 0x60,,, ahk_pid %pid1% 
							Sleep 1000
							PostMessage, 0x100, 0x1B,,, ahk_pid %pid1% 
								Sleep 25
							PostMessage, 0x101, 0x1B,,, ahk_pid %pid1% 
							Sleep 1000
							PostMessage, 0x100, 0x60,,, ahk_pid %pid1% 
								Sleep 25
							PostMessage, 0x101, 0x60,,, ahk_pid %pid1% 
							PostMessage, 0x101, 0x58,,, ahk_pid %pid1% 
							Sleep 2000
						}
						Sleep 2000
						;WinMinimize
						Sleep 100
						waittime := sleepytime * 60000
						Sleep %waittime%
						Sleep 60000
					}
				ExitApp
				}
				Else					
					Goto, Start
			}
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
	return
}

AppsKey::
{
	if(Mini = 0)
	{
		WinMinimize, FINAL FANTASY XIV
		Mini = 1
	}
	else
	{
		WinRestore, FINAL FANTASY XIV
		Mini = 0
	}
	return
}