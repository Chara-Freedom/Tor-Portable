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
filesystem::path pathname = fullpath;
filesystem::current_path(fullpath.remove_filename());
char buffer[256];
string UPD;
FILE* pipe1 = _popen("@echo off & for %I in (VERSION*) do echo %~nxI", "r");
while (fgets(buffer, sizeof(buffer), pipe1) != NULL) {
buffer[strcspn(buffer, "\n")] = 0;
UPD = buffer;
}
_pclose(pipe1);
string link = "https://ipfs.io/ipns/k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4/" + UPD;
string filename = "./tor/" + UPD;
IStream* pStream = NULL;
if (FAILED(URLOpenBlockingStream(0, link.c_str(), &pStream, 0, 0)))
{
char choice;
cout << "The local version does not match the latest version. It means that update is available, but in edge cases marks accessibility issues. Press any key if you want to update or 0 to skip";
choice = _getch();
if (choice == '0') goto Skip;
string TEMP;
FILE* pipe2 = _popen("echo %TEMP%", "r");
while (fgets(buffer, sizeof(buffer), pipe2) != NULL) {
buffer[strcspn(buffer, "\n")] = 0;
TEMP = buffer;
}
_pclose(pipe2);
string TEMPUPDATE = TEMP + "\\" + "autoupdate.cmd";
ofstream outfile(TEMPUPDATE);
outfile << "@echo off" << endl;
outfile << "call " << fullpath << "updater.cmd" << endl;
outfile << "cls" << endl;
outfile << ":Wait" << endl;
outfile << "if not exist " << fullpath << "torrc.txt" << " GOTO Wait" << endl;
outfile << "timeout /t 1 /nobreak" << endl;
outfile << "call " << pathname << endl;
outfile << "del " << TEMPUPDATE;
string finale = "start "" cmd /c " + TEMPUPDATE;
system(finale.c_str());
return TRUE;
}
pStream->Release();
Skip:
string PROC;
FILE* pipe3 = _popen("IF DEFINED PROCESSOR_ARCHITEW6432 (echo AMD64) else (echo x86)", "r");
while (fgets(buffer, sizeof(buffer), pipe3) != NULL) {
buffer[strcspn(buffer, "\n")] = 0;
PROC = buffer;
}
_pclose(pipe3);
string quoted = "\"sc query \"Tor Win32 Service\" >nul\"";
int service = system(quoted.c_str());
if (service == 0) {
system("call service-manager.cmd");
system("timeout /t 3 /nobreak");
}
int admin = system("net session >nul 2>&1");
if (PROC.find('8') != string::npos) {
ShellExecuteW(NULL, (L"runas"), (pathname.c_str()), NULL, NULL, SW_SHOWNORMAL);
return 0;
}
_wchdir(L"./tor");
system("start /min tor -f ../torrc.txt");
}