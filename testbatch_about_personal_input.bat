@echo off
setlocal ENABLEDELAYEDEXPANSION

call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"

cl /Fetest.exe test.cpp /EHsc >nul

set test_input_count=0
set test_correct_count=0

rem Initialize Test Inputs and Expected Results
for /f "delims=" %%i in (test_input.txt) do (
    set test_input[!test_input_count!]=%%i
    set /a test_input_count+=1
)
for /f "delims=" %%i in (test_correct.txt) do (
    set test_correct[!test_correct_count!]=%%i
    set /a test_correct_count+=1
)
if NOT %test_input_count%==%test_correct_count% (
    echo =================== V I T A L E R R O R ===================
    echo The line of test_input.txt and test_correct.txt is DIFFERENT
    echo test_input.txt   ::   %test_input_count% lines
    echo test_correct.txt ::   %test_correct_count% lines
    echo ===========================================================
    echo Press ANY KEY to exit.
    pause
    exit
)

@echo off
rem Because array starts from 0 and ends at minus 1 of the number of inputs
set /a forloopcount=test_input_count-1

echo ^| TEST INPUT ^|  EXPECTED  ^| USER ANSWER ^|
echo ^|------------^|------------^|-------------^|
for /l %%i in (0,1,%forloopcount%) do (
    cmd /c echo !test_input[%%i]! | test.exe > temp.txt
    set /p temp=<temp.txt
    if !temp!==!test_correct[%%i]! (
        echo ^|      !test_input[%%i]!     ^|      !test_correct[%%i]!     ^|      !temp!      ^|
    ) else (
        echo ^|      !test_input[%%i]!     ^|      !test_correct[%%i]!     ^|      !temp!      ^|  ^<----- WRONG!
    )
)
pause
for /f "delims=" %%i in (test_input.txt) do (
    cmd /c echo %%i | test.exe > test.txt

    echo The Answer is 
    type test.txt
    echo.
    echo =============

    fc /w test.txt test_correct.txt >nul

    if errorlevel 1 (
        echo Incorrect
    ) else (
        echo Correct
    )
    del test.txt
)

del test.exe
del test.obj

del temp.txt

pause