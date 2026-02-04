#include <fstream>
#include <filesystem>
#include <windows.h>
#include <conio.h>
#include <VersionHelpers.h>
using namespace std;
int main() {
WCHAR path[MAX_PATH];
GetModuleFileNameW(NULL, path, MAX_PATH);
filesystem::path fullpath(path);
filesystem::path pathname = fullpath;
filesystem::current_path(fullpath.remove_filename());
char buffer[256];
string UPD;
FILE* pipe1 = _popen("for %I in (VERSION*) do echo %~nxI", "r");
while (fgets(buffer, sizeof(buffer), pipe1) != NULL) {
buffer[strcspn(buffer, "\n")] = 0;
UPD = buffer;
}
_pclose(pipe1);
string link;
if (UPD.find('V') != string::npos) link = "https://ipfs.io/ipns/k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4/" + UPD;
IStream* pStream = NULL;
if (FAILED(URLOpenBlockingStream(0, link.c_str(), &pStream, 0, 0)))
{
char choice;
printf("The local version does not match the latest version. It means that update is available, but in edge cases marks accessibility issues. Press any key if you want to update or 0 to skip");
choice = _getch();
if (choice == '0') goto Skip;
string TEMP;
FILE* pipe2 = _popen("echo %TEMP%", "r");
while (fgets(buffer, sizeof(buffer), pipe2) != NULL) {
buffer[strcspn(buffer, "\n")] = 0;
TEMP = buffer;
}
_pclose(pipe2);
string TEMPUPDATE = TEMP + "\\" + "autoupdater.cmd";
string TEMPQUOTE = "\"" + TEMPUPDATE + "\"";
ofstream outfile(TEMPUPDATE);
outfile << "@echo off" << endl;
outfile << "call " << fullpath << "updater.cmd" << endl;
outfile << "cls" << endl;
outfile << ":Wait" << endl;
outfile << "if not exist " << fullpath << "torrc.txt" << " GOTO Wait" << endl;
outfile << "timeout /t 1 /nobreak" << endl;
outfile << "call " << pathname;
string finale = "start "" cmd /c " + TEMPQUOTE;
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
if (system("sc query \"Tor Win32 Service\" >nul") == 0) {
system("call service-manager.cmd");
system("timeout /t 3 /nobreak");
}
if (!filesystem::exists("C:\\Windows\\Sysnative\\acryptprimitives.dll") && !filesystem::exists("C:\\Windows\\System32\\acryptprimitives.dll") && PROC.find('8') != string::npos || !(IsWindows8OrGreater())) {
if (system("net session >nul 2>&1") != 0) {
ShellExecuteW(NULL, (L"runas"), (pathname.c_str()), NULL, NULL, SW_SHOWNORMAL);
return 0;
}
if (PROC.find('4') != string::npos) system("copy \"%CD%\\oldwin\\acryptprimitives.dll\" \"C:\\Windows\\Sysnative\\acryptprimitives.dll\"");
if (PROC.find('8') != string::npos) system("copy \"%CD%\\oldwin\\acryptprimitives.dll\" \"C:\\Windows\\System32\\acryptprimitives.dll\"");
}
_wchdir(L"./tor");
system("start /min tor -f ../torrc.txt");
}