#include <iostream>
#include <windows.h>
#include <filesystem>
int main() {
WCHAR path[MAX_PATH];
GetModuleFileNameW(NULL, path, MAX_PATH);
std::filesystem::path fullpath(path);
std::filesystem::current_path(fullpath.remove_filename());
FILE* pipe = _popen("@echo off & for %I in (VERSION*) do echo %~nxI", "r");
char buffer[100];
std::string UPD;
while (fgets(buffer, sizeof(buffer), pipe) != NULL) UPD += buffer;
_pclose(pipe);
_wchdir(L"./tor");
std::system("start /min tor.exe -f ../torrc.txt");
}