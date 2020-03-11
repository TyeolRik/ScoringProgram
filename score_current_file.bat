@echo off
setlocal ENABLEDELAYEDEXPANSION

title C language Scoring Program - Teaching Assistant, Mr. Baek, in Cloud Computing Labs. 
echo This Program is made by TyeolRik in Univ. of Seoul for scoring student's homework
echo.
echo.
echo Run Visual Studio 2017
echo.
echo.

rem This exe should be run before run cl.exe

call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"

rem run all .cpp or .c files in current directory and make test.exe files
for %%F in ("[1] Submitted Homework"\*.cpp "[1] Submitted Homework"\*.c) do (

    rem >nul means hide the result and 2>nul means hide errors
    rem /Fe<filename> means make output file named <filename>
    rem Without /EHsc, causing error.
    cl /Fe%%~nF.exe "%%F" /EHsc >nul
    echo %%~nF is Completely compiled

    rem Start Time Definition
    set StartTime=!time!
    for /f "tokens=1-4 delims=:." %%a in ("!StartTime!") do (
        rem removing leading zeros because of 08, 09
        set /a h1=%%a
        set /a m1=1%%b-100
        set /a s1=1%%c-100
        set /a ms1=1%%d-100 & set /a ms1=!ms1!*10
    )
    set /a StartTimeStamp=!h1!*3600000 + !m1!*60000 + !s1!*1000 + !ms1!

    call %%~nF.exe > %%~nF.txt

    rem End Time Definition
    set EndTime=!time!
    for /f "tokens=1-4 delims=:." %%a in ("!EndTime!") do (
        rem removing leading zeros because of 08, 09
        set /a h2=%%a
        set /a m2=1%%b-100
        set /a s2=1%%c-100
        set /a ms2=1%%d-100 & set /a ms2=!ms2!*10
    )
    rem for /f "tokens=1-4 delims=:." %%a in ("!EndTime!") do set h2=%%a & set /a h2+=0 & set m2=%%b & set /a m2+=0 & set s2=%%c & set /a s2+=0 & set ms2=%%d & set /a ms2+=0 & set /a ms2*=10
    set /a EndTimeStamp=!h2!*3600000 + !m2!*60000 + !s2!*1000 + !ms2!

    rem Difference
    set /a h3=!h2!-!h1! & set /a m3=!m2!-!m1! & set /a s3=!s2!-!s1! & set /a ms3=!ms2!-!ms1!
    set /a TimeStampDifference=!EndTimeStamp!-!StartTimeStamp!

    rem Time Adjustment
    if !h3! LSS 0 set /a h3=!h3!+24
    if !m3! LSS 0 set /a m3=!m3!+60 & set /a h3=!h3!-1
    if !s3! LSS 0 set /a s3=!s3!+60 & set /a m3=!m3!-1
    if !ms3! LSS 0 set /a ms3=!ms3!+1000 & set /a s3=!s3!-1

    
    echo StartTimeStamp    :    !StartTimeStamp! . . . !StartTime! . . !h1! !m1! !s1! !ms1!
    echo EndTimeStamp      :    !EndTimeStamp! . . . !EndTime! . . !h2! !m2! !s2! !ms2!
    echo -----------------------------------------------------------
    echo Cost Time         :    !TimeStampDifference!  ms
    echo Cost Time         :    !h3!hr !m3!min !s3!sec !ms3!msec
    echo File Size         :    %%~zF  bytes
    echo.

    for /f "tokens=1-2 delims=_" %%a in ("%%~nF") do set studentId=%%a & set studentName=%%b

    rem fc /w %%~nF.txt correct_answer.txt >nul&&echo Correct||echo Incorrect
    fc /w %%~nF.txt correct_answer.txt >nul
    if errorlevel 1 (
        echo Incorrect
        move %%~nF.txt "[2] Incorrect Homework" >nul
        echo !studentId!!studentName! %%~nF Incorrect !TimeStampDifference! %%~zF>>result.txt

    ) else (
        echo Correct
        move %%~nF.txt "[2] Correct Homework" >nul
        echo !studentId!!studentName! %%~nF Correct !TimeStampDifference! %%~zF>>result.txt
    )
    echo.
    echo ============================================================
    echo.

    del %%~nF.exe
    del %%~nF.obj
)

echo Press ANY KEY to exit.
pause>nul

rem Reference
rem https://stackoverflow.com/a/35524720/7105963 (Batch Script Time Stamp)

@echo on
