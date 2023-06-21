set hidden=hidden
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

if 'z%1' NEQ 'z' (
    cd %1
) else (
    cd ..
    cd !hidden!
)

@REM cscript "execute_2.vbs"
@REM start /min cmd /c execute_3.bat
@REM start cmd /c execute_3.bat
start cmd /k execute_3.bat
exit