#include <iostream>
#include <fstream>
#include <windows.h>
#include <filesystem>
#include <conio.h>
using namespace std;
int main() {
WCHAR path[MAX_PATH];
GetModuleFileNameW(NULL, path, MAX_PATH);
filesystem::path fullpath(path);
filesystem::current_path(fullpath.remove_filename());
FILE* pipe = _popen("@echo off & for %I in (VERSION*) do echo %~nxI", "r");
char buffer[256];
string UPD;
while (fgets(buffer, sizeof(buffer), pipe) != NULL) {
buffer[strcspn(buffer, "\n")] = 0;
UPD += buffer;
}
_pclose(pipe);
string link = "https://ipfs.io/ipns/k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4/" + UPD;
string filename = "./tor/" + UPD;
IStream* pStream = NULL;
if (FAILED(URLOpenBlockingStream(0, link.c_str(), &pStream, 0, 0)))
{
char choice;
cout << "The local version does not match the latest version. It means that update is available, but in edge cases marks accessibility issues. Press any key if you want to update or 0 to skip";
choice = _getch();
if (choice == '0') goto Skip;
return TRUE;
}
pStream->Release();
Skip:
_wchdir(L"./tor");
system("start /min tor -f ../torrc.txt");
}