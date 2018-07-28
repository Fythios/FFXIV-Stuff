; FFXIV Macro 2 Buttons
;
; Modified from original made in 20150318
; 20161031 - Added Pause script and cleaned up
; 20161101 - Throws an error if input is left blank.
; 20161110 - Added check after all parameters are entered to start input over
; 20161112 - Re-wrote program to used fucntion and added crafting food usage
;
; Simple script to press buttons in anything
; The amount of time to pause (in milliseconds) between 0 and 2147483647 (24 days), which can be an expression.
; 1 sec = 1000, 1 min = 60000, 1 hour = 3600000, (33s * 100) = 3300000
;

global PauseStatus = 0
global Macro1 = 0
global Macro1Sleep = 0
global Macro2 = 0
global Macro2Sleep = 0
global ItemsNum = 0
global ItemsLeft = 0
global Fooding = 0
global FoodLoop = 0
global FoodTime = 0
global UsingFood = 0
global CraftTime = 0
global TotalTime = 0
global NumOfFoodUses = 0
global TotalTimeCalc = 0
global FoodLoopCalc = 0
global NumOfFoodUsesCalc = 0

MsgBox,0,Intro, This simply presses buttons for you`, make sure you have the needed mats!`nYou can press Alt + Q to quit or the Pause/Break key to pause the program at any time.`n-Ava,3
MsgBox,0,Preparation, Please be on the crafting menu with the item you want to craft selected and the materials for it as well.,3

StartMacro:
ParametersInput()

MsgBox,4,Requires Food?, Does your craft require the use of food?,
IfMsgBox Yes
{
	FoodSetup()
	UsingFood = 1
}
IfMsgBox No
{
	UsingFood = 0
}

CraftTime := Macro1Sleep + Macro2Sleep + 8
TotalTimeCalc := ((CraftTime * ItemsNum) / 60 )
TotalTime := Round(TotalTimeCalc,2)
FoodLoopCalc := (FoodTime * 60) / CraftTime
FoodLoop := Floor(FoodLoopCalc)
NumOfFoodUsesCalc := ItemsNum / FoodLoop
NumOfFoodUses := Ceil(NumOfFoodUsesCalc)
ItemsLeft := ItemsNum

MsgBox,4,Parameters, Your selections:`n`nFirst macro Button = %Macro1% `nMacro one wait time = %Macro1Sleep%`n`nSecond Macro Button = %Macro2%`nMacro two wait time = %Macro2Sleep%`n`nNumber of items to craft = %ItemsNum%`n`nNumber of Crafts per Food Cycle = %FoodLoop%`nTotal time to complete the craft = %TotalTime% minutes `n`n Is this correct?,
	IfMsgBox No
	{	
		goto, StartMacro
	}
MsgBox,0,HowTo, To run this macro press Ctrl + Alt + M or press Alt + Q to quit at any time.,2
WinWait ,  ahk_class FFXIVGAME,,,,
WinActivate,  ahk_class FFXIVGAME,,,
^!m::
SplashTextOn, 200, 50, Start, The crafting Macro is starting!!
sleep 2000
SplashTextOff
sleep 1000
{
	CraftStart()
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
	InputBox, Macro1, Macro Button 1, The button number for the first in-game macro you are using on the hotbar (1-9).
	if ErrorLevel
	{
		MsgBox,0,Error 1,This soon??,1
		return
	}
	InputBox, Macro1Sleep, Macro 1 Wait, The time it takes in seconds to run your macro.
	if ErrorLevel OR !Macro1Sleep 
	{
		MsgBox,0,Error 1,Fine press cancel! you'll just have to do it all again.,1
		return
	}
	InputBox, Macro2, Macro Button 2, The button number for the second in-game macro you are using on the hotbar (1-9).
	if ErrorLevel
	{
		MsgBox,0,Error 2,Why is this cancel button even here?.,1
		return
	}
	InputBox, Macro2Sleep, Macro 2 Delay Time, The time it takes in seconds to run your macro.
	if ErrorLevel OR !Macro2Sleep 
	{
		MsgBox,0,Error 1,Bleh!.,1
		return
	}
	InputBox, ItemsNum, NumberOfItems, The total number of crafts you want to make.
	if ErrorLevel OR !ItemsNum 
	{
		MsgBox,0,Error 1,Fine press cancel! you'll just have to do it all again.,1
		return
	}
}

FoodSetup()
{
	InputBox, Fooding, Food Button, The button number on the hotbar (0 - =) that is pressed to use food., ,320,240,,,,,=
	if ErrorLevel OR !Fooding 
	{
		MsgBox,0,Error 1,Bleh!.,1
		return
	}
	InputBox, FoodTime, Duration of Food, The number of minutes the food last for (usually 30)., ,320,240,,,,,30
	if ErrorLevel OR !FoodTime 
	{
		MsgBox,0,Error 1,Fine press cancel! you'll just have to do it all again.,1
		return
	}
}

CraftStart()
{
	if UsingFood = 1
	{	
		Loop, %NumOfFoodUses%
		{
			UseFood()
			Loop, %FoodLoop%
			{
				if ItemsLeft = 0
				{
					ExitApp
				}
				else
				{
					Craft()
				}
			}
		}
	}
	else
	{
		Loop, %ItemsNum%
		{
			Craft()
		}
	}
}

Craft()
{
	SplashTextOn, 200, 50, Items To Craft, There are %ItemsLeft% left to make.
	WinActivate,  ahk_class FFXIVGAME,,,
	Send {Numpad0}
	Sleep 500
	Send {Numpad0}
	Sleep 850
	SplashTextOff
	Send {Numpad0}
	Sleep 1650
	WinActivate,  ahk_class FFXIVGAME,,,
	Send %Macro1%
	Macro1Sleeping := Macro1Sleep * 1000
	Sleep %Macro1Sleeping%
	WinActivate,  ahk_class FFXIVGAME,,,
	Send %Macro2%
	Macro2Sleeping := Macro2Sleep * 1000
	Sleep %Macro2Sleeping%
	Sleep 2000
	Send {Numpad0}
	ItemsLeft-=1
	Sleep 4000
}


UseFood()
{
	Sleep 2000
	Send {esc}
	Sleep 3000
	Send %Fooding%
	Sleep 4000
	Send {n}
	Sleep 500
	Send {Numpad0}
	Sleep 1000
}
