@echo on
setlocal ENABLEDELAYEDEXPANSION

set test=1009

set last_two=%test:~2,2%
echo %last_two%
cmd /c exit %last_two%
set /a last_two=%ErrorLevel%
echo %last_two%
set /a test2=%last_two%+1
echo %test2%
echo.
echo.

set last_two_second=%test:~2,2%
echo %last_two_second%
set /a last_two_second=(1%last_two_second%-100)*11
echo %last_two_second%

set StartTime=%time%
echo %StartTime%
echo. 
for /f "tokens=1-4 delims=:. " %%a in ("%time%") do (
    rem removing leading zeros because of 08, 09
    set /a h1=%%a
    set /a m1=1%%b-100
    set /a s1=1%%c-100
    set /a ms1=1%%d-100 & set /a ms1=!ms1!*10
)

echo !h1! - !m1! - !s1! - !ms1!

pause