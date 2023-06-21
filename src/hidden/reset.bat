@echo off
set name=file hello.txt
set hidden=hidden

cd ..
del "%name%"

cd %hidden%
move "%name%.lnk" "../%name%.lnk"