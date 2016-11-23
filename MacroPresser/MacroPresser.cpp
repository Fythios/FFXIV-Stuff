#include <conio.h>
#include <iostream>
#include <windows.h>
#include <winuser.h>
#include <stdio.h>


struct extraKeyInfo
{
	unsigned short repeatCount;
	unsigned char scanCode;
	bool extendedKey, prevKeyState, transitionState;

	operator unsigned int()
	{
		return repeatCount | (scanCode << 16) | (extendedKey << 24) |
			(prevKeyState << 30) | (transitionState << 31);
	}
};


int main()
{


	Sleep(5000);
//	HWND Find = ::FindWindowEx(0, 0, "FINAL FANTASY XIV", 0);
	HWND hFFXIV = FindWindowEx(NULL, NULL, TEXT("RAPTURE", "FINAL FANTASY XIV"), NULL);
//	HWND hFFXIV = FindWindow(TEXT("FINAL FANTASY XIV"), 0);

	if (!hFFXIV)
		std::cout << "FINAL FANTASY XIV was not found!\n";
	else
	{
		HWND hEdit = FindWindowEx(hFFXIV, NULL, TEXT("Edit"), NULL);

		if (!hEdit)
			std::cout << "FINAL FANTASY XIV's edit control was not found!\n";
		else
		{
			SetForegroundWindow(hFFXIV);

			for (char ch = 'a'; ch <= 'z'; ch++) // Output a-z in FINAL FANTASY XIV
			{
				short vkCode = LOBYTE(VkKeyScan(ch));

				extraKeyInfo lParam = {};
				lParam.scanCode = MapVirtualKey(vkCode, MAPVK_VK_TO_VSC);

				PostMessage(hEdit, WM_KEYDOWN, vkCode, lParam);

				lParam.repeatCount = 1;
				lParam.prevKeyState = true;
				lParam.transitionState = true;

				PostMessage(hEdit, WM_KEYUP, vkCode, lParam);
				Sleep(100);
			}
		}
	}
	std::cin.get();
	return 0;
}