; <COMPILER: v1.1.20.02>
MsgBox, This simply presses the in game macro of your choice on your 1st hotbar. Ensure you have the needed mats and that they are selected!! `n-Ava `nYou can press Alt + Q at any time to quit the program.
InputBox, Macro1, MacroButton1, The button for the in game macro you are using on the hot bar (1-9).
if ErrorLevel
MsgBox, Already messed up the first choice didn't you?
else
{
InputBox, itemsnum, NumberOfItems, The number of times you want to run it (aka number of items you are making).
if ErrorLevel
MsgBox, fine press cancel! you'll just have to do it all again.
else
{
InputBox, sleepytime, Time, The time it takes in seconds to run your macro`nHint: add up the wait.X numbers`n`nHQ > 35 = 22		1s NoFood = 38`nDone40 = 5.		Done80 = 8.`nDone 4Star = 17., , 400, 250
if ErrorLevel
MsgBox, Why is this cancel button even here?
else
{
MsgBox, Your selections: `nMacro Button = %Macro1% `nMacro wait time = %sleepytime% `nNumber of items to craft = %itemsnum%
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
waittime := sleepytime * 1000
Sleep %waittime%
itemsleft-=1
Sleep 3000
}
ExitApp
}
}
}
ExitApp