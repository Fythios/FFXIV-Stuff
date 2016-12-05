; FFXIV Macro 2 Buttons
;
; Modified from original made in 20150318
; 20161031 - Added Pause script and cleaned up
; 20161101 - Throws an error if input is left blank.
; 20161110 - Added check after all parameters are entered to start input over
; 20161112 - Re-wrote program to used fucntion and added crafting food usage
; 20161122 - changed output style from Send/SendRaw to PostMessage
; 20161127 - added key functions to make it easier to follow
;
; Simple script to press buttons in anything
; The amount of time to pause (in milliseconds) between 0 and 2147483647 (24 days), which can be an expression.
; 1 sec = 1000, 1 min = 60000, 1 hour = 3600000, (33s * 100) = 3300000
;

IfNotExist, Image.jpg
	FileInstall, images/CraftingLog.jpg, CraftingLog


global PauseStatus = 0
global vvMacro1 = 0
global vvMacro1key = 0
global vvMacro1Sleep = 0
global vMacro2 = 0
global vMacro2key = 0
global vMacro2Sleep = 0
global vItemsNum = 0
global ItemsLeft = 0
global vFooding = 0
global vFoodingkey = 0
global FoodLoop = 0
global FoodTime = 0
global UsingFood = 0
global CraftTime = 0
global TotalTime = 0
global NumOfFoodUses = 0
global TotalTimeCalc = 0
global FoodLoopCalc = 0
global NumOfFoodUsesCalc = 0
global temp = 0
global tempkey = 0
global pid1 = 0

WinGet, id, list, ahk_class FFXIVGAME
Loop, %id%
{
   this_id := id%A_Index%
   WinGet, this_pid, PID, ahk_id %this_id%
   pid%A_Index% := this_pid
}



;MsgBox, %this_pid%

;MsgBox,0,Intro, This simply presses buttons for you`, make sure you have the needed mats!`nYou can press Alt + Q to quit or the Pause/Break key to pause the program at any time.`n-Ava,5
;MsgBox,0,Preparation, Please be on the crafting menu with the item you want to craft selected and the materials for it as well.`nPress Ctrl+H for help on how to use and setup this program,5

Gui, Add, Picture, x0 y0 w450 h300, CraftingLog

Gui, Add, Text, cRed, First Macro Button.
Gui, Add, DropDownList, vMacro1, 1|2|3|4|5|6|7|8|9|0|-|=

Gui, Add, Text,, First Macro wait time:
Gui, Add, Edit, R1 vMacro1Sleep
GuiControl, MoveDraw, vMacro1Sleep, x10 y20 w200 h100

Gui, Add, Text, cRed, Second Macro Button.
Gui, Add, DropDownList, vMacro2, 1|2|3|4|5|6|7|8|9|0|-|=


Gui, Add, Text,, Second Macro wait time:
Gui, Add, Edit, R1 vMacro2Sleep

Gui, Add, Text,, Number of crafts:
Gui, Add, Edit, R1 vItemsNum

Gui, Add, Checkbox, vFooding, Does this craft require Food?
Gui, Add, Checkbox, vCollectable, Is this a Collectable?

Gui, Add, Button, Default, &OK

Gui, Show, ,


;ParametersInput()


;MsgBox,0,HowTo, To run this macro press Ctrl + Alt + M .`nPress the Menu Key (next to right ctrl) to minimize the game client`nYou can press Alt + Q to quit the program at any time.,3
;WinWait ,  ahk_class FFXIVGAME,,,,
;WinActivate,  ahk_class FFXIVGAME,,,
return


/* 
//Used to figure out what keys are being pressed in game with their hex value
AppsKey::
{

Loop, 1
	{
		temp := temp + 1
		SetFormat, IntegerFast, hex	
		temp += 0  ; Sets Var (which previously contained 11) to be 0xb.
		temp .= ""  ; Necessary due to the "fast" mode.
		SetFormat, IntegerFast, d
		PostMessage, 0x100, temp,,, ahk_pid %pid1% 
			Sleep 50
		PostMessage, 0x101, temp,,, ahk_pid %pid1%
		Sleep 100
		MsgBox,0,HexUp,%temp%,0.4
	}
	return
}

^AppsKey::
{

Loop, 1
	{
		temp := temp - 1
		SetFormat, IntegerFast, hex	
		temp += 0  ; Sets Var (which previously contained 11) to be 0xb.
		temp .= ""  ; Necessary due to the "fast" mode.
		SetFormat, IntegerFast, d
		PostMessage, 0x100, temp,,, ahk_pid %pid1% 
			Sleep 50
		PostMessage, 0x101, temp,,, ahk_pid %pid1%
		Sleep 100
		MsgBox,0,HexDn,%temp%,0.4
	}
	return
}
*/

;----------------HotKeys----------------
!q::ExitApp

AppsKey::
{
	WinMinimize, FINAL FANTASY XIV
	return
}

^!m::
{
	SplashTextOn, 180,60, Start, The crafting Macro is starting!!
	sleep 2000
	SplashTextOff
	sleep 1000
	{
		CraftStart()
	}
	ExitApp
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

;Help / How to use and setup directions
^h::
{
	Gui, Add, Picture, x0 y0 w480 h480, TestImg
	Gui, Add, Button, Default, &OK
	Gui, Add, DropDownList, vColorChoice, Black|White|Red|Green|Blue
	Gui, Show, ,
}


;----------------HotKeysEND-------------



;----------------Functions Blocks----------------

ParametersInput()
{
	InputBox, vvMacro1, Macro Button 1, The button number for the first in-game macro you are using on the hotbar (1-9).
	if ErrorLevel
	{
		MsgBox,0,Error 1,This soon??,1
		return
	}
	ChtoHex(vvMacro1)
	vvMacro1key := tempkey
	if vvMacro1 = =
		vvMacro1key := 0xBB
	if vvMacro1 = -
		vvMacro1key := 0xBD
	InputBox, vvMacro1Sleep, Macro 1 Wait, The time it takes in seconds to run your macro.
	if ErrorLevel OR !vvMacro1Sleep 
	{
		MsgBox,0,Error 1,Fine press cancel! you'll just have to do it all again.,1
		ParametersInput()
		return
	}
	InputBox, vMacro2, Macro Button 2, The button number for the second in-game macro you are using on the hotbar (1-9).
	if ErrorLevel
	{
		MsgBox,0,Error 2,Why is this cancel button even here?.,1
		ParametersInput()
		return
	}
	ChtoHex(vMacro2)
	vMacro2key := tempkey
	if vMacro2 = =
		vMacro2key := 0xBB
	if vMacro2 = -
		vMacro2key := 0xBD
	InputBox, vMacro2Sleep, Macro 2 Delay Time, The time it takes in seconds to run your macro.
	if ErrorLevel OR !vMacro2Sleep 
	{
		MsgBox,0,Error 1,Bleh!.,1
		ParametersInput()
		return
	}
	InputBox, vItemsNum, NumberOfItems, The total number of crafts you want to make.
	if ErrorLevel OR !vItemsNum 
	{
		MsgBox,0,Error 1,Fine press cancel! you'll just have to do it all again.,1
		ParametersInput()
	}
	MsgBox,4,Requires Food?, Does your craft require the use of food?,
	IfMsgBox Yes
	{
		FoodSetup()
		UsingFood = 1
	}
	IfMsgBox No
	{
		FoodTime = 0
		UsingFood = 0
	}
	CraftTime := vvMacro1Sleep + vMacro2Sleep + 8
	TotalTimeCalc := ((CraftTime * vItemsNum) / 60 )
	TotalTime := Round(TotalTimeCalc,2)
	FoodLoopCalc := (FoodTime * 60) / CraftTime
	FoodLoop := Floor(FoodLoopCalc)
	NumOfFoodUsesCalc := vItemsNum / FoodLoop
	NumOfFoodUses := Ceil(NumOfFoodUsesCalc)
	ItemsLeft := vItemsNum
	
	MsgBox,4,Parameters, Your selections:`n`nFirst macro Button = %vvMacro1% `nMacro one wait time = %vMacro1Sleep%`n`nSecond Macro Button = %vMacro2%`nMacro two wait time = %vMacro2Sleep%`n`nNumber of items to craft = %vItemsNum%`n`nNumber of Crafts per Food Cycle = %FoodLoop%`nTotal time to complete the craft = %TotalTime% minutes `n`n Is this correct?,
		IfMsgBox No
	{	
		ParametersInput()
		return
	}
return
}

FoodSetup()
{
	InputBox, vFooding, Food Button, The button number on the hotbar (0 - =) that is pressed to use food., ,320,240,,,,,=
	if ErrorLevel 
	{
		MsgBox,0,Error 1,Bleh!.,1
		return
	}
	ChtoHex(vFooding)
	vFoodingkey := tempkey
	if vFooding = =
		vFoodingkey := 0xBB
	if vFooding = -
		vFoodingkey := 0xBD
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
		Loop, %vItemsNum%
		{
			Craft()
		}
	}
}

Craft()
{
	SplashTextOn, 180,60, Items To Craft, There are %ItemsLeft% left to make.
	;WinActivate,  ahk_class FFXIVGAME,,,
	Sleep 400
	SplashTextOff
	Sleep 200
	Numpad0Key()
	Sleep 500
	Numpad0Key()
	Sleep 850
	Numpad0Key() 
	Sleep 1650
	;WinActivate,  ahk_class FFXIVGAME,,,
	PostMessage, 0x100, vMacro1key,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, vMacro1key,,, ahk_pid %pid1% 
	vMacro1Sleeping := vMacro1Sleep * 1000
	Sleep %vMacro1Sleeping%
	;WinActivate,  ahk_class FFXIVGAME,,,
	PostMessage, 0x100, vMacro2key,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, vMacro2key,,, ahk_pid %pid1% 
	vMacro2Sleeping := vMacro2Sleep * 1000
	Sleep %vMacro2Sleeping%	
	ItemsLeft-=1
	Sleep 4000
}


UseFood()
{
	Sleep 2000
	EscKey()
	Sleep 3000
	PostMessage, 0x100, vFoodingkey,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, vFoodingkey,,, ahk_pid %pid1% 
	Sleep 4000
	NKey()
	Sleep 500
	Numpad0Key()
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