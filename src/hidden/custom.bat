@echo off

net session >nul 2>&1
if %errorLevel% == 0 (
    echo admin
) else (
    echo no admin
)

pause
exit