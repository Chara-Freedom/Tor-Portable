#include <iostream>
#include <windows.h>
#include <filesystem>
int main() {
WCHAR path[MAX_PATH];
GetModuleFileNameW(NULL, path, MAX_PATH);
std::filesystem::path fullpath(path);
std::filesystem::current_path(fullpath.remove_filename());
_wchdir(L"./tor");
std::system("start /min tor.exe -f ../torrc.txt");
}