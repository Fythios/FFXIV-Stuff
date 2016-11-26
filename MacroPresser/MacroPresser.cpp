#include <iostream>
#include <windows.h>
//#include <conio.h>
//#include <winuser.h>
//#include <stdio.h>


int ChtoHex(char Mnum);

int main()
{
	Sleep(1000);
	HWND hFFXIV = FindWindow(TEXT("FFXIVGAME"), TEXT("FINAL FANTASY XIV"));

	if (!hFFXIV)
		std::cout << "FINAL FANTASY XIV is not running or not found!\n";
	else
	
	for (int i=0; i<10; i++)
	{
		//PostMessage(hFFXIV, 0x100, 0x48, 0);
		Sleep(100);
		PostMessage(hFFXIV, 0x101, 0x48, 0);
		Sleep(100);
		//PostMessage(hFFXIV, 0x100, 0x49, 0);
		Sleep(100);
		PostMessage(hFFXIV, 0x101, 0x49, 0);
	}
	std::cout << "Press any key to quit.\n";
	std::cin.get();
	return 0;
}


/*
ChtoHex(Mnum)
{
		Mnum == asc(char)
		char_hex : = char_number

		; Convert a decimal integer to hexadecimal :
		SetFormat, IntegerFast, hex
		char_hex += 0; Sets char_number to its hex value.
		char_hex . = ""; Necessary due to the "fast" mode.
		SetFormat, IntegerFast, d

		tempkey : = char_hex
	}
*/