#include <iostream>
#include <windows.h>
#include <filesystem>
using namespace std;
int main() {
WCHAR path[MAX_PATH];
GetModuleFileNameW(NULL, path, MAX_PATH);
filesystem::path fullpath(path);
filesystem::current_path(fullpath.remove_filename());
FILE* pipe = _popen("@echo off & for %I in (VERSION*) do echo %~nxI", "r");
char buffer[100];
string UPD;
while (fgets(buffer, sizeof(buffer), pipe) != NULL) UPD += buffer;
_pclose(pipe);
_wchdir(L"./tor");
system("start /min tor.exe -f ../torrc.txt");
}
