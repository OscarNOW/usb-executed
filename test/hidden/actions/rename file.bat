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

set oldName2=!name:~0,-3!.!name:~-3!
set newName2=!newName:~0,-3!.!newName:~-3!

attrib -R -S -H "!oldName2!"
ren "!oldName2!" "!newName2!"
attrib +R +S +H "!newName2!"

cd "!newName2!"
ren "!name!.bat" "!newName!.bat"

cd ..

del "!name!.lnk"
cd !hidden!

ren "!name!.lnk" "!newName!.lnk"
copy "!newName!.lnk" "../!newName!.lnk"