@echo off
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)


if '%errorlevel%' NEQ '0' (
    echo [CONSOLE] Check: Run as Admin...
	echo [CONSOLE] Open UAC...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
	echo Run as Admin..
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

echo Install Rufus...
cd "%appdata%\Microsoft\Windows\Start Menu\Programs"
mkdir "Rufus"
cd Rufus
powershell.exe -ExecutionPolicy Bypass -Command (new-object System.Net.WebClient).DownloadFile('https://github.com/pbatard/rufus/releases/download/v3.18/rufus-3.18.exe','rufus.exe')
mklink "%appdata%\Microsoft\Windows\Start Menu\Programs\Rufus\Rufus-3.18" "%appdata%\Microsoft\Windows\Start Menu\Programs\Rufus\rufus.exe"
mklink "%userprofile%\desktop\Rufus" "%appdata%\Microsoft\Windows\Start Menu\Programs\Rufus\rufus.exe"