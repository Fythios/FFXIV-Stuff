;FFXIV Macro Buttons R4
;
; Modified from original made in 20150318
; 20161031 - Added Pause script and cleaned up
; 20161101 - Throws an error if input is left blank.
; 20161110 - Added check after all parameters are entered to start input over
; 20161112 - Re-wrote program to used fucntion and added crafting food usage
; 20161122 - changed output style from Send/SendRaw to PostMessage
; 20161127 - added key functions to make it easier to follow
; 20180122 - Modified to use a simple GUI 
; 20180123 - Modified from Macro 2 Button GUI to multiple buttons with more GUI options
; 20180127 - Adding use of HQ Mats
;
;
; Simple script to press buttons in anything
; The amount of time to pause (in milliseconds) between 0 and 2147483647 (24 days), which can be an expression.
; 1 sec = 1000, 1 min = 60000, 1 hour = 3600000, (33s * 100) = 3300000
;
;Written by Edh/Ava

FileInstall, images/Crafting.jpg, FFXIV_Macro_Buttons_BG
;FileInstall, Presets.ini, FFXIV_Macro_Buttons_R4_Presets.ini


;--------Globals--------
global pid1 = 0
global PauseStatus = 0
global Preset = 0
global ButtonSelected = 0
global Collectable = 0
global Mat_1 = 0
global Mat_2 = 0
global Mat_3 = 0
global Mat_4 = 0
global Mat_5 = 0
global Mat_6 = 0
global keyd = 0
;global Mat_5 = 0
;--------Calculations--------
global ItemsLeft = 0
global FoodLoop = 0
global CraftTime = 0
global TotalTime = 0
global NumOfFoodUses = 0
global TotalTimeCalc = 0
global FoodLoopCalc = 0
global NumOfFoodUsesCalc = 0
global keycheck = 0
global tempkey = 0
global FoodCheck = 0
;--------Variables--------
global MacroCount = 0
global Macro1 = 0
global Macro1Sleep = 0
global Macro2 = 0
global Macro2Sleep = 0
global Macro3 = 0
global Macro3Sleep = 0
global ItemsNum = 0
global UsingFood = 0
global Fooding = 0
global FoodTime = 30

;--------Globals END--------

WinGet, id, list, ahk_class FFXIVGAME
Loop, %id%
{
   this_id := id%A_Index%
   WinGet, this_pid, PID, ahk_id %this_id%
   pid%A_Index% := this_pid
}
;MsgBox, %this_pid%

;Gui, Main:Default
;Gui -MaximizeBox
Gui, Add, Picture, x0 y0 w450 h300, FFXIV_Macro_Buttons_BG
gui, font, s10, Verdana
Gui, Add, Text, y+10, Number of Macro Buttons.
Gui, Add, Radio, Checked vMacroCount, 1
Gui, Add, Radio, xp+32, 2
Gui, Add, Radio, xp+32, 3
Gui, Add, Text, xp+140 yp-20, Does this craft require Food?
Gui, Add, Checkbox, vUsingFood
Gui, Add, Tab3, x0 w420 h200, Macro 1||Macro 2|Macro 3|Food|HQ Mats
;-----------Macro1-----------
Gui, Add, Text, cGreen, First Macro Button.
Gui, Add, Radio, Checked vMacro1, 1
Gui, Add, Radio, xp+32, 2
Gui, Add, Radio, xp+32, 3
Gui, Add, Radio, xp+32, 4
Gui, Add, Radio, xp+32, 5
Gui, Add, Radio, xp+32, 6
Gui, Add, Radio, xp+32, 7
Gui, Add, Radio, xp+32, 8
Gui, Add, Radio, xp+32, 9
Gui, Add, Radio, xp+32, 0
Gui, Add, Radio, xp+38, -
Gui, Add, Radio, xp+28, =
Gui, Add, Text, cGreen yp+18 xp-354, First Macro wait time (in seconds):
Gui, Add, Edit, Number R1 vMacro1Sleep
Gui, Tab
;-----------Macro2-----------
Gui, Tab, 2
Gui, Add, Text, cPurple, Second Macro Button.
Gui, Add, Radio, Checked vMacro2, 1
Gui, Add, Radio, xp+32, 2
Gui, Add, Radio, xp+32, 3
Gui, Add, Radio, xp+32, 4
Gui, Add, Radio, xp+32, 5
Gui, Add, Radio, xp+32, 6
Gui, Add, Radio, xp+32, 7
Gui, Add, Radio, xp+32, 8
Gui, Add, Radio, xp+32, 9
Gui, Add, Radio, xp+32, 0
Gui, Add, Radio, xp+38, -
Gui, Add, Radio, xp+28, =
Gui, Add, Text, cPurple yp+18 xp-354, Second Macro wait time (in seconds):
Gui, Add, Edit, Number R1 vMacro2Sleep
Gui, Tab
;-----------Macro3-----------
Gui, Tab, 3
Gui, Add, Text, cBlue, Third Macro Button.
Gui, Add, Radio, Checked vMacro3, 1
Gui, Add, Radio, xp+32, 2
Gui, Add, Radio, xp+32, 3
Gui, Add, Radio, xp+32, 4
Gui, Add, Radio, xp+32, 5
Gui, Add, Radio, xp+32, 6
Gui, Add, Radio, xp+32, 7
Gui, Add, Radio, xp+32, 8
Gui, Add, Radio, xp+32, 9
Gui, Add, Radio, xp+32, 0
Gui, Add, Radio, xp+38, -
Gui, Add, Radio, xp+28, =
Gui, Add, Text, cBlue yp+18 xp-354, Thrid Macro wait time (in seconds):
Gui, Add, Edit, Number R1 vMacro3Sleep
Gui, Tab
;----------------------------
Gui, Tab, 4
Gui, Add, Text, , Button pressed to use food:
Gui, Add, Radio, vFooding, 1
Gui, Add, Radio, xp+32, 2
Gui, Add, Radio, xp+32, 3
Gui, Add, Radio, xp+32, 4
Gui, Add, Radio, xp+32, 5
Gui, Add, Radio, xp+32, 6
Gui, Add, Radio, xp+32, 7
Gui, Add, Radio, xp+32, 8
Gui, Add, Radio, xp+32, 9
Gui, Add, Radio, xp+32, 0
Gui, Add, Radio, xp+38, -
Gui, Add, Radio, Checked xp+28, =
Gui, Tab 
Gui, Tab, 5
Gui, Add, Text, , Mat 1 HQ Qty:
Gui, Add, DropDownList, vMat_1, 0||1|2|3|4|5
Gui, Add, Text, xp+180 yp-23, Mat 2 HQ Qty:
Gui, Add, DropDownList, vMat_2, 0||1|2|3|4|5
Gui, Add, Text, xp-180 yp+30, Mat 3 HQ Qty:
Gui, Add, DropDownList, vMat_3, 0||1|2|3|4|5
Gui, Add, Text, xp+180 yp-26, Mat 4 HQ Qty:
Gui, Add, DropDownList, vMat_4, 0||1|2|3|4|5
Gui, Add, Text, xp-180 yp+30, Mat 5 HQ Qty:
Gui, Add, DropDownList, vMat_5, 0||1|2|3|4|5
Gui, Add, Text, xp+180 yp-22, Mat 6 HQ Qty:
Gui, Add, DropDownList, vMat_6, 0||1|2|3|4|5
Gui, Tab 
Gui, Add, Text, x0, Number of crafts:
Gui, Add, Edit, Number R1 vItemsNum
Gui, Add, Text, yp-20 xp+200, Is this craft a Collectable?
Gui, Add, Checkbox, vCollectable
gui, font, s12, Verdana
Gui, Add, Button, x0 yp+40 Default, &Run
gui, font, s10, Verdana
;Gui, Add, Text, xp+64 yp-18,Presets:
;Gui, Add, Radio, Checked vPreset, 1
;Gui, Add, Radio, xp+32, 2
;Gui, Add, Radio, xp+32, 3
;Gui, Add, Radio, xp+32, 4
;Gui, Add, Radio, xp+32, 5
;Gui, Add, Button, gSavePreset xp+50, &Save
;Gui, Add, Button, gLoadPreset xp+56, &Load
Gui, Add, Button, xp+80, &Help
Gui, Add, Button, xp+80, &KeyTest
Gui, Add, Text, xp+80 yp-20, Key Test:
Gui, Add, Edit, R1 vkeyd
Gui, Show
return


GuiClose:
ExitApp


;-------------SubRoutines-------------
ButtonRun:
{
	Gui, Submit
;	MsgBox, MacroCount = %MacroCount%
	MsgBox,Parameters, Your selections:`n`nMacro Count = %MacroCount%`n`nFirst macro Button = %Macro1% `nMacro one wait time = %Macro1Sleep%`n`nSecond Macro Button = %Macro2%`nMacro two wait time = %Macro2Sleep%`n`nThird macro Button = %Macro3% `nMacro three wait time = %Macro3Sleep%`n`nNumber of items to craft = %ItemsNum%`n`nRequires Food? = %Fooding%`n`nCollectable? = %Collectable%
	;MsgBox,Parameters, Your selections:`n`nFirst macro Button = %Macro1% `nMacro one wait time = %Macro1Sleep%`n`nSecond Macro Button = %Macro2%`nMacro two wait time = %Macro2Sleep%`n`nThird macro Button = %Macro3% `nMacro three wait time = %Macro3Sleep%`n`nNumber of items to craft = %ItemsNum%`n`nNumber of Crafts per Food Cycle = %FoodLoop%`nTotal time to complete the craft = %TotalTime% minutes `n`n Is this correct?,

	if (MacroCount = 1 && !Macro1Sleep)
	{
		MsgBox, Your wait time for Macro 1 is invalid or 0.
		Gui, Show
		return
	}
	if (MacroCount = 2 && (!Macro1Sleep || !Macro2Sleep))
	{
		if (!Macro1Sleep)
		{
			MsgBox, Your wait time for Macro 1 is invalid or 0.
		}
		if (!Macro2Sleep)
		{
			MsgBox, Your wait time for Macro 2 is invalid or 0.
		}
		Gui, Show
		return
	}
	if (MacroCount = 3 && (!Macro1Sleep || !Macro2Sleep || !Macro3Sleep))
	{
		if (!Macro1Sleep)
		{ 
			MsgBox, Your wait time for Macro 1 is invalid or 0.
		}
		if (!Macro2Sleep)
		{
			MsgBox, Your wait time for Macro 2 is invalid or 0.
		}
		if (!Macro3Sleep)
		{
			MsgBox, Your wait time for Macro 3 is invalid or 0.
		}
		Gui, Show
		return
	}
	if (!ItemsNum)
	{
		MsgBox, You are trying to craft 0 items
		Gui, Show
		return
	}

	;MsgBox, UsingFood = %UsingFood% `nMacro 1 Button = %Macro1key% `nMacro 2 Button = %Macro2key% `nFood Button = %Foodingkey%
	CraftTime := Macro1Sleep + Macro2Sleep + 8
	TotalTimeCalc := ((CraftTime * ItemsNum) / 60 )
	TotalTime := Round(TotalTimeCalc,2)
	FoodLoopCalc := (FoodTime * 60) / CraftTime
	FoodLoop := Floor(FoodLoopCalc)
	NumOfFoodUsesCalc := ItemsNum / FoodLoop
	NumOfFoodUses := Ceil(NumOfFoodUsesCalc)
	ItemsLeft := ItemsNum
	;MsgBox, %UsingFood%
		;	IfMsgBox No
	;{	
		;MsgBox, Bye then!
		;ExitApp
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
	Gui, Help:New, ,Help Screen
	Gui, Add, Picture, x0 y0 w800 h800, TestImg
	Gui, Help:Show
	return
}

ButtonKeyTest:
{
	Gui, Submit, NoHide
	MsgBox, Pressed Key = %keyd%
	PressKey(keyd)
	MsgBox, tempkey = %tempkey%
	return
}

LoadPreset:
{
	Gui, Submit, NoHide
	;IniRead, OutputVar, Filename, Section, Key
	IniRead, MacroCount, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Macro_Count
	IniRead, Macro1, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Macro_Button_1,
	IniRead, Macro1Sleep, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Macro_1_Wait_Time,
	IniRead, Macro2, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Macro_Button_2,
	IniRead, Macro2Sleep, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Macro_2_Wait_Time,
	IniRead, Macro3, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Macro_Button_3,
	IniRead, Macro3Sleep, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Macro_3_Wait_Time,
	IniRead, FoodCheck, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Food_Check,
	IniRead, UsingFood, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Use_Food,
	IniRead, Fooding, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Food_Button,
	GuiControl, , Button%MacroCount%, 1
	ButtonSelected = %Macro1%
	ButtonSelected += 3
	GuiControl, , Button%ButtonSelected%, 1
	GuiControl, , Macro1Sleep, %Macro1Sleep%
	ButtonSelected = %Macro2%
	ButtonSelected += 15
	GuiControl, , Button%ButtonSelected%, 1
	GuiControl, , Macro2Sleep, %Macro2Sleep%
	ButtonSelected = %Macro3%
	ButtonSelected += 27
	GuiControl, , Button%ButtonSelected%, 1
	GuiControl, , Macro3Sleep, %Macro3Sleep%
	ButtonSelected = %FoodCheck%
	ButtonSelected += 39
	GuiControl, , Button%ButtonSelected%, 1
	GuiControl, , UsingFood, %UsingFood%
	ButtonSelected = %Fooding%
	ButtonSelected += 40
	GuiControl, , Button%ButtonSelected%, 1
	GuiControl, , FoodTime, %FoodTime%

	MsgBox,Parameters, Your selections:`n`nMacro Count = %MacroCount%`n`nFirst macro Button = %Macro1% `nMacro one wait time = %Macro1Sleep%`n`nSecond Macro Button = %Macro2%`nMacro two wait time = %Macro2Sleep%`n`nThird macro Button = %Macro3% `nMacro three wait time = %Macro3Sleep%`n`nNumber of items to craft = %ItemsNum%`n`nFood Check = %FoodCheck%`n`nCollectable = %Collectable%
	;MsgBox,Parameters, Your selections:`n`nFirst macro Button = %Macro1% `nMacro one wait time = %Macro1Sleep%`n`nSecond Macro Button = %Macro2%`nMacro two wait time = %Macro2Sleep%`n`nThird macro Button = %Macro3% `nMacro three wait time = %Macro3Sleep%`n`nNumber of items to craft = %ItemsNum%`n`nNumber of Crafts per Food Cycle = %FoodLoop%`nTotal time to complete the craft = %TotalTime% minutes `n`n Is this correct?,
	;Gui, Submit, NoHide
	Gui, Show
	;MsgBox,Parameters, Your selections:`n`nFirst macro Button = %Macro1% `nMacro one wait time = %Macro1Sleep%`n`nSecond Macro Button = %Macro2%`nMacro two wait time = %Macro2Sleep%`n`nThird macro Button = %Macro3% `nMacro three wait time = %Macro3Sleep%`n`nNumber of items to craft = %ItemsNum%`n`nNumber of Crafts per Food Cycle = %FoodLoop%`nTotal time to complete the craft = %TotalTime% minutes `n`n Is this correct?,
	return
}

SavePreset:
{
	Gui, Submit, NoHide
	;IniWrite, Value, Filename, Section, Key
	IniWrite, %MacroCount%, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Macro_Count
	IniWrite, %Macro1%, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Macro_Button_1
	IniWrite, %Macro1Sleep%, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Macro_1_Wait_Time
	IniWrite, %Macro2%, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Macro_Button_2
	IniWrite, %Macro2Sleep%, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Macro_2_Wait_Time
	IniWrite, %Macro3%, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Macro_Button_3
	IniWrite, %Macro3Sleep%, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Macro_3_Wait_Time
	IniWrite, %FoodCheck%, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Food_Check
	IniWrite, %UsingFood%, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Use_Food
	IniWrite, %Fooding%, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Food_Button
	IniWrite, %FoodTime%, FFXIV_Macro_Buttons_R4_Presets.ini, Preset_%Preset%, Food_Time
	Gui, Show
	return
}


;----------------SubRoutineEND-------------


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
	if (MacroCount = 1)
	{ 
		PressKey(Macro1)
		Macro1Sleeping := Macro1Sleep * 1000
		Sleep %Macro1Sleeping%
		If (Collectable = 1)
		{
			Sleep 3000
			Numpad0Key()
			Sleep 2000
		}
	}
	if (MacroCount = 2)
	{
		PressKey(Macro1)
		Macro1Sleeping := Macro1Sleep * 1000
		Sleep %Macro1Sleeping%
		PressKey(Macro2)
		Macro2Sleeping := Macro2Sleep * 1000
		Sleep %Macro2Sleeping%
		If (Collectable = 1)
		{
			Sleep 3000
			Numpad0Key()
			Sleep 2000
		}
	}
	if (MacroCount = 3)
	{
		PressKey(Macro1)
		Macro1Sleeping := Macro1Sleep * 1000
		Sleep %Macro1Sleeping%
		PressKey(Macro2) 
		Macro2Sleeping := Macro2Sleep * 1000
		Sleep %Macro2Sleeping%
		PressKey(Macro3)
		Macro3Sleeping := Macro3Sleep * 1000
		Sleep %Macro3Sleeping%
		If (Collectable = 1)
		{
			Sleep 3000
			Numpad0Key()
			Sleep 2000
		}
	}
	ItemsLeft-=1
	Sleep 4000
	return
}


UseFood()
{
	EscKey()
	Sleep 2000
	PressKey(Fooding)
	Sleep 3000
	NKey()
	Sleep 700
	Numpad0Key()
	Sleep 400
	if (Mat_1 > 0)
	{
		Numpad0Key()
		Sleep 400
		Loop, 3
		{
			Numpad2Key()
			Sleep 400
		}
		Numpad6Key()
		Sleep 400
		Numpad6Key()
		Sleep 400
		Loop, %Mat_1%
		{
			Numpad0Key()
			Sleep 400
		}
		NumpadDotKey()
		Sleep 1000
	}
	if (Mat_2 > 0)
	{
		Numpad0Key()
		Sleep 400
		Loop, 4
		{
			Numpad2Key()
			Sleep 400
		}
		Numpad6Key()
		Sleep 400
		Numpad6Key()
		Sleep 400
		Loop, %Mat_2%
		{
			Numpad0Key()
			Sleep 200
		}
		NumpadDotKey()
		Sleep 1000
	}
	if (Mat_3 > 0)
	{
		Numpad0Key()
		Sleep 400
		Loop, 5
		{
			Numpad2Key()
			Sleep 400
		}
		Numpad6Key()
		Sleep 400
		Numpad6Key()
		Sleep 400
		Loop, %Mat_3%
		{
			Numpad0Key()
			Sleep 200
		}
		NumpadDotKey()
		Sleep 1000
	}
	if (Mat_4 > 0)
	{
		Numpad0Key()
		Sleep 400
		Loop, 6
		{
			Numpad2Key()
			Sleep 400
		}
		Numpad6Key()
		Sleep 400
		Numpad6Key()
		Sleep 400
		Loop, %Mat_4%
		{
			Numpad0Key()
			Sleep 200
		}
		NumpadDotKey()
		Sleep 1000
	}
	if (Mat_5 > 0)
	{
		Numpad0Key()
		Sleep 400
		Loop, 7
		{
			Numpad2Key()
			Sleep 400
		}
		Numpad6Key()
		Sleep 400
		Numpad6Key()
		Sleep 400
		Loop, %Mat_5%
		{
			Numpad0Key()
			Sleep 200
		}
		NumpadDotKey()
		Sleep 1000
	}
	if (Mat_6 > 0)
	{
		Numpad0Key()
		Sleep 400
		Loop, 8
		{
			Numpad2Key()
			Sleep 400
		}
		Numpad6Key()
		Sleep 400
		Numpad6Key()
		Sleep 400
		Loop, %Mat_6%
		{
			Numpad0Key()
			Sleep 200
		}
		NumpadDotKey()
		Sleep 1000
	}
	return
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

NumpadDotKey()
{
	PostMessage, 0x100, 0x6E,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, 0x6E,,, ahk_pid %pid1%
}

Numpad2Key()
{
	PostMessage, 0x100, 0x62,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, 0x62,,, ahk_pid %pid1%
}

Numpad4Key()
{
	PostMessage, 0x100, 0x64,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, 0x64,,, ahk_pid %pid1%
}

Numpad6Key()
{
	PostMessage, 0x100, 0x66,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, 0x66,,, ahk_pid %pid1%
}


Numpad8Key()
{
	PostMessage, 0x100, 0x68,,, ahk_pid %pid1% 
		Sleep 75
	PostMessage, 0x101, 0x68,,, ahk_pid %pid1%
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

PressKey(text)
{
	;MsgBox, Text = %text%
	if (text = 11 || - || _ )
	{
		tempkey := 0xBD
		PostMessage, 0x100, tempkey ,,, ahk_pid %pid1% 
		Sleep 50
		PostMessage, 0x101, tempkey ,,, ahk_pid %pid1%
		return
	}
	if (text = 12 || = || + )
	{
		tempkey := 0xBB
		PostMessage, 0x100, tempkey ,,, ahk_pid %pid1% 
		Sleep 50
		PostMessage, 0x101, tempkey ,,, ahk_pid %pid1%
		return
	}
	else
	ChtoHex(text)
	PostMessage, 0x100, tempkey ,,, ahk_pid %pid1% 
		Sleep 50
	PostMessage, 0x101, tempkey ,,, ahk_pid %pid1% 
}



/* DEBUG STUFF
//Used to figure out what keys are being pressed in game with their hex value
AppsKey::
{

Loop, 1
	{
		keycheck := keycheck + 1
		SetFormat, IntegerFast, hex	
		keycheck += 0  ; Sets Var (which previously contained 11) to be 0xb.
		keycheck .= ""  ; Necessary due to the "fast" mode.
		SetFormat, IntegerFast, d
		PostMessage, 0x100, keycheck,,, ahk_pid %pid1% 
			Sleep 75
		PostMessage, 0x101, keycheck,,, ahk_pid %pid1%
		Sleep 100
		MsgBox,0,HexUp,%keycheck%,0.4
	}
	return
}

^AppsKey::
{

Loop, 1
	{
		keycheck := keycheck - 1
		SetFormat, IntegerFast, hex	
		keycheck += 0  ; Sets Var (which previously contained 11) to be 0xb.
		keycheck .= ""  ; Necessary due to the "fast" mode.
		SetFormat, IntegerFast, d
		PostMessage, 0x100, keycheck,,, ahk_pid %pid1% 
			Sleep 75
		PostMessage, 0x101, keycheck,,, ahk_pid %pid1%
		Sleep 100
		MsgBox,0,HexDn,%keycheck%,0.4
	}
	return
}
*/
