;

pausestatus = 0

InputBox, Retainers, Who Shall Go?, Enter which Retainer you want to send out. `ni.e. 1`,2 for the first two`, or 1`,2`,3`,4`,5`,6`,7`,8 for all eight.
	if ErrorLevel OR !Retainers 
		MsgBox,0,Error 1,Fine press cancel! you'll just have to do it all again.,1
	else
	{

StringReplace, RetainersNS, Retainers, %A_SPACE%,,All		;Removes any spaces from string
StringSplit, Retainers_sp, RetainersNS, `,					;Creates an array using comma delimiting
StringReplace, RetainersNS2, RetainersNS, `, ,,All			;Removes any commas from string
StringLen, RetainersLen, RetainersNS2						;returns the string length from RetainersNS2 into RetainersLen

MsgBox %RetainersLen%
MsgBox %Retainers_sp0%
;MsgBox % RetainersNS
	Loop, %Retainers_sp0%
	{
    Retainer_Num := Retainers_sp%a_index%
    MsgBox, Retainer number %a_index% is %Retainer_Num%.
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
