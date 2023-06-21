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

set /p newName="Rename (!name!)->"

cd ..
del "!name!.lnk"
cd !hidden!

ren "!name!.lnk" "!newName!.lnk"
copy "!newName!.lnk" "../!newName!.lnk"

ren "!name!/" "!newName!/"
cd "!newName!"
ren "!name!.bat" "!newName!.bat"
cd ..

ren "!name!" "!newName!"