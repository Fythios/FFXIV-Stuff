; <COMPILER: v1.1.20.02>
MsgBox, This simply presses the in game macro of your choice waits and the presses the next macro on your 1st hotbar. Ensure you have the needed mats and that they are selected!! `n-Ava `nYou can press Alt + Q at any time to quit the program.
InputBox, Macro1, MacroButton1, The button for the in game macro 1 you are using on the hot bar (1-9).
if ErrorLevel
MsgBox, Already messed up the first choice didn't you?
else
{
InputBox, Macro1Sleep, Macro 1 Wait, The time it takes in seconds to run your macro i.e.`nHint: add up the wait.X numbers`n`n2star80 I = 40., , 400, 250
if ErrorLevel
MsgBox, yeah that's an odd time to be waiting.
else
{
InputBox, Macro2, MacroButton2, The button for the in game macro 2 you are using on the hot bar (1-9).
if ErrorLevel
MsgBox, Are you sure you meant to press that?
else
{
InputBox, Macro2Sleep, End of Macro, The time it takes in seconds to run your macro i.e.`nHint: add up the wait.X numbers`n`n2star80 I = 21., , 400, 250
if ErrorLevel
MsgBox, So you didn't really want to put that in there did you?
else
{
InputBox, itemsnum, NumberOfItems, The number of times you want to run it (aka number of items you are making).
if ErrorLevel
MsgBox, Program is now exiting sorry.
else
MsgBox, Your selections: `nFirst macro Button = %Macro1% `nMacro 1 wait time = %Macro1Sleep% `nSecond Macro Button = %Macro2% `nMacro 2 wait time = %Macro2Sleep% `nNumber of items to craft = %itemsnum%
{
MsgBox, To run this macro press Ctrl + Alt + M and it will auto run for the number of times you set it with the set delays or press Alt + Q to quit now.
!q::ExitApp
^!m::
SplashTextOn, 200, 50, Start, The crafting Macro is starting!!
sleep 2000
SplashTextOff
sleep 1000
itemsleft := itemsnum
Loop, %itemsnum%
{
SplashTextOn, 200, 50, Items To Craft, There are %itemsleft% left to make.
IfWinNotActive, FINAL FANTASY XIV: A Realm Reborn, , WinActivate, FINAL FANTASY XIV: A Realm Reborn,
Send {Numpad0}
Sleep 850
SplashTextOff
IfWinNotActive, FINAL FANTASY XIV: A Realm Reborn, , WinActivate, FINAL FANTASY XIV: A Realm Reborn,
Send {Numpad0}
Sleep 1650
IfWinNotActive, FINAL FANTASY XIV: A Realm Reborn, , WinActivate, FINAL FANTASY XIV: A Realm Reborn,
Send %Macro1%
Macro1Sleeping := Macro1Sleep * 1000
Sleep %Macro1Sleeping%
IfWinNotActive, FINAL FANTASY XIV: A Realm Reborn, , WinActivate, FINAL FANTASY XIV: A Realm Reborn,
Send %Macro2%
Macro2Sleeping := Macro2Sleep * 1000
Sleep %Macro2Sleeping%
itemsleft-=1
Sleep 3000
}
ExitApp
}
}
}
}
}
ExitApp