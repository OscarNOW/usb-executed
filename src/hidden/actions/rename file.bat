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

ren "!name!" "!newName!"

cd ..

attrib -R -S -H "!name:~0,-4!.!name:~-4!"
ren "!name:~0,-4!.!name:~-4!" "!newName:~0,-4!.!newName:~-4!"
attrib +R +S +H "!newName:~0,-4!.!newName:~-4!"

cd "!newName:~0,-4!.!newName:~-4!"
ren "!name!.bat" "!newName!.bat"
cd ..
cd !hidden!

cd ..
del "!name!.lnk"
cd !hidden!

ren "!name!.lnk" "!newName!.lnk"
copy "!newName!.lnk" "..\!newName!.lnk"