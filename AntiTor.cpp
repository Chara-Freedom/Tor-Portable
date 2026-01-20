#include <iostream>

int main() {
_wchdir(L"./tor");
std::system("tor.exe -f ../torrc.txt");
}