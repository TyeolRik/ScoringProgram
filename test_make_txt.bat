@echo off
setlocal ENABLEDELAYEDEXPANSION

for /l %%i in (0,4,20000) do (
    echo %%i>>test_input.txt
    set /a output=%%i*2
    echo !output!>>test_correct.txt
)