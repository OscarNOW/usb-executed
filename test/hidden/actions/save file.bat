@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
cd ..

for %%I in (.) do set hidden=%%~nxI

cd ..
for /R "%cd%" %%F in (*.lnk) do (
    set name=%%~nxF
    set name=!name:~0,-4!
)
cd !hidden!

cd ..
if not exist "!name!" (
    echo Can't save, doesn't exist
    pause
    exit
)
cd !hidden!

del "!name!"

cd ..
copy "!name!" "!hidden!/!name!"
