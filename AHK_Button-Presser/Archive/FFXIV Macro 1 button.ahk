; FFXIV Macro 1 Button
;
; Modified from original made in 20150318
; 20161031 - Added Pause script and cleaned up.
; 20161101 - Throws an error if input is left blank.
; 20161110 - Added check after all parameters are entered to start input over
;
;
; Simple script to press buttons in anything
; The amount of time to pause (in milliseconds) between 0 and 2147483647 (24 days), which can be an expression.
; 1 sec = 1000, 1 min = 60000, 1 hour = 3600000, (33s * 100) = 3300000
;

pausestatus = 0

MsgBox,0,Intro,This simply presses buttons for you`, make sure you have the needed mats!`nYou can press Alt + Q to quit or the Pause/Break key to pause the program at any time.`n-Ava.,3
MsgBox,0,Preparation,Please be on the crafting menu with the item you want to craft selected and the materials for it as well.,3
Start:
InputBox, Macro1, MacroButton1, The button number for the in-game macro you are using on the hotbar (1-9).
if ErrorLevel OR !Macro1
    MsgBox,0,Error 0,you messed up or something!,1
else 
	{
		InputBox, sleepytime, Time, The time it takes in seconds to run your macro.
		if ErrorLevel OR !sleepytime
			MsgBox,0,Error 1,Fine press cancel! you'll just have to do it all again.,1
		else
		{
			InputBox, itemsnum, NumberOfItems, The number of times you want to run it (aka number of items you are making).
			if ErrorLevel OR !itemsnum 
				MsgBox,0,Error 2,Why is this cancel button even here?.,1
			else
			{
				MsgBox,4,Parameters, Your selections:`n`nMacro Button = %Macro1% `nMacro wait time = %sleepytime%`n`nNumber of items to craft = %itemsnum%`n`n Is this correct?,
				IfMsgBox Yes
				{
					MsgBox,0,HowTo, To run this macro press Ctrl + Alt + M or press Alt + Q to quit at any time.,2
					IfWinNotActive, FINAL FANTASY XIV
						WinActivate, FINAL FANTASY XIV
					WinWaitActive, FINAL FANTASY XIV
					^!m::
					SplashTextOn, 200, 50, Start, The crafting Macro is starting!!
					sleep 2000
					SplashTextOff
					sleep 1000
					itemsleft := itemsnum
					Loop, %itemsnum%
					{
						SplashTextOn, 200, 50, Items To Craft, There are %itemsleft% left to make.
						IfWinNotActive, FINAL FANTASY XIV, , WinActivate, FINAL FANTASY XIV,
						Send {Numpad0}
						Sleep 850
						SplashTextOff
						Send {Numpad0}
						Sleep 1650
						Send %Macro1%
						waittime := sleepytime * 1000
						Sleep %waittime%
						itemsleft-=1
						Sleep 3000
					}
				ExitApp
				}
				else
					Goto, Start	
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