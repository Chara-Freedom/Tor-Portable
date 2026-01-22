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
string TESTYO = "ZeroOmegaOptions-RU.bak";
string link = "https://ipfs.io/ipns/k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4/" + TESTYO;
string filename = "./tor/" + TESTYO;
URLDownloadToFile(NULL, link.c_str(), filename.c_str(), 0, NULL);
_wchdir(L"./tor");
system("start /min tor.exe -f ../torrc.txt");
}