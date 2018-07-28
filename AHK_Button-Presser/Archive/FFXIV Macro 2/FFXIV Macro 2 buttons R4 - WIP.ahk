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
global Macro1 = 0
global Macro1key = 0
global Macro1Sleep = 0
global Macro2 = 0
global Macro2key = 0
global Macro2Sleep = 0
global ItemsNum = 0
global ItemsLeft = 0
global Fooding = 0
global Foodingkey = 0
global FoodLoop = 0
global FoodTime = 0
global UsingFood = 0
global CraftTime = 0
global TotalTime = 0
global NumOfFoodUses = 0
global TotalTimeCalc = 0
global FoodLoopCalc = 0
global NumOfFoodUsesCalc = 0
global Collectable = 0
global FoodSub = 0
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

{
Gui, New
;Gui Main:Default
Gui -MaximizeBox
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
Gui, Add, Checkbox, vUsingFood,   Does this craft require Food?
Gui, Add, DropDownList, vFooding, 1|2|3|4|5|6|7|8|9|0|-|=
Gui, Add, Text,, Food time in minutes:
Gui, Add, Edit, R1 vFoodTime
;Gui, Add, Checkbox, vCollectable, Is this a Collectable?
Gui, Add, Button, Default, &Run
Gui, Add, Button, , &Help
Gui, Show
return
}

GuiClose:
ExitApp




;----------------Buttons----------------
ButtonRun:
{
Gui, Submit

ChtoHex(Macro1)
Macro1key := tempkey
if Macro1 = =
	Macro1key := 0xBB
if Macro1 = -
	Macro1key := 0xBD

ChtoHex(Macro2)
Macro2key := tempkey
if Macro2 = =
	Macro2key := 0xBB
if Macro2 = -
	Macro2key := 0xBD

ChtoHex(Fooding)
Foodingkey := tempkey
if Fooding = =
	Foodingkey := 0xBB
if Fooding = -
	Foodingkey := 0xBD

CraftTime := Macro1Sleep + Macro2Sleep + 8
TotalTimeCalc := ((CraftTime * ItemsNum) / 60 )
TotalTime := Round(TotalTimeCalc,2)
FoodLoopCalc := (FoodTime * 60) / CraftTime
FoodLoop := Floor(FoodLoopCalc)
NumOfFoodUsesCalc := ItemsNum / FoodLoop
NumOfFoodUses := Ceil(NumOfFoodUsesCalc)
ItemsLeft := ItemsNum
;MsgBox, %UsingFood%
;MsgBox,4,Parameters, Your selections:`n`nFirst macro Button = %Macro1% `nMacro one wait time = %Macro1Sleep%`n`nSecond Macro Button = %Macro2%`nMacro two wait time = %Macro2Sleep%`n`nNumber of items to craft = %ItemsNum%`n`nNumber of Crafts per Food Cycle = %FoodLoop%`nTotal time to complete the craft = %TotalTime% minutes `n`n Is this correct?,
;	IfMsgBox No
;{	
;	MsgBox, Bye then!
;	ExitApp
;}
SplashTextOn, 180,60, Start, The crafting Macro is starting`nPlease be on the window as shown earlier!!
sleep 3000
SplashTextOff
sleep 5000
{
	CraftStart()
}
ExitApp
}

ButtonHelp:
{
	Gui, Help:Add, Picture, x0 y0 w480 h480, TestImg
	Gui, Help:Show
	return
}
;----------------ButtonsEND-------------


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
;----------------HotKeysEND-------------


;----------------Functions Blocks----------------

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
	SplashTextOn, 180,60, Items To Craft, There are %ItemsLeft% left to make.
	;WinActivate,  ahk_class FFXIVGAME,,,
	Sleep 800
	SplashTextOff
	Sleep 300
	Numpad0Key()
	Sleep 600
	Numpad0Key()
	Sleep 1000
	Numpad0Key() 
	Sleep 1750
	;WinActivate,  ahk_class FFXIVGAME,,,
	PostMessage, 0x100, Macro1key,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, Macro1key,,, ahk_pid %pid1% 
	Macro1Sleeping := Macro1Sleep * 1000
	Sleep %Macro1Sleeping%
	;WinActivate,  ahk_class FFXIVGAME,,,
	PostMessage, 0x100, Macro2key,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, Macro2key,,, ahk_pid %pid1% 
	Macro2Sleeping := Macro2Sleep * 1000
	Sleep %Macro2Sleeping%	
	ItemsLeft-=1
	Sleep 4000
}


UseFood()
{
	Sleep 2000
	EscKey()
	Sleep 3000
	PostMessage, 0x100, Foodingkey,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, Foodingkey,,, ahk_pid %pid1% 
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
		Sleep 75
	PostMessage, 0x101, 0x60,,, ahk_pid %pid1%
}

Numpad8Key()
{
	PostMessage, 0x100, 0x68,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, 0x68,,, ahk_pid %pid1%
}

Numpad2Key()
{
	PostMessage, 0x100, 0x62,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, 0x62,,, ahk_pid %pid1%
}

Numpad6Key()
{
	PostMessage, 0x100, 0x66,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, 0x66,,, ahk_pid %pid1%
}

Numpad4Key()
{
	PostMessage, 0x100, 0x64,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, 0x64,,, ahk_pid %pid1%
}

EscKey()
{
	PostMessage, 0x100, 0x1B,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, 0x1B,,, ahk_pid %pid1%
}

NKey()
{
	PostMessage, 0x100, 0x4E ,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, 0x4E ,,, ahk_pid %pid1% 
}



/* DEBUG STUFF
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
			Sleep 75
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
			Sleep 75
		PostMessage, 0x101, temp,,, ahk_pid %pid1%
		Sleep 100
		MsgBox,0,HexDn,%temp%,0.4
	}
	return
}
*/
