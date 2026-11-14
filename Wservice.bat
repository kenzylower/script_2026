@echo off
setlocal enabledelayedexpansion
title Multi-Noka Auto-Joiner (Batched)
color 0A

:: Path is correct based on your screenshot
set "ADB=C:\LDPlayer\LDPlayer9\adb.exe"
set "LD=C:\LDPlayer\LDPlayer9\ldconsole.exe"

set "PKG1=free.nokaA"
set "PKG2=free.nokaB"

set "PLACE=79389059854988"
set "DEEPLINK=roblox://experiences/start?placeId=%PLACE%"

:: Changed temp name to avoid confusing ADB
set "STATS_TMP=%TEMP%\noka_data.txt"

:: ============================================================
:: Ask how many emulators to launch
:: ============================================================
cls
echo =========================================
echo   Multi-Noka Auto-Joiner (Batched)
echo =========================================
set /p "COUNT=How many emulators do you want to launch (e.g. 7): "

if "%COUNT%"=="" goto :bad_input
echo %COUNT%| findstr /r "^[0-9][0-9]*$" >nul
if errorlevel 1 goto :bad_input

set "LAST="
for /l %%i in (0,1,%COUNT%) do (
    if %%i LSS %COUNT% set "LAST=%%i"
)
if "%LAST%"=="" goto :bad_input

echo.
echo Will launch instance 0 through %LAST% (%COUNT% total).

:: ============================================================
:: Launch all emulators
:: ============================================================
echo.
echo =========================================
echo Launching %COUNT% emulators...
echo =========================================
for /l %%i in (0,1,%LAST%) do (
    echo   - Launching index %%i ...
    "%LD%" launch --index %%i >nul 2>&1
    timeout /t 2 /nobreak >nul
)

echo Waiting 30 seconds for Android to settle...
timeout /t 30 /nobreak >nul

:: ============================================================
:: Restart ADB cleanly
:: ============================================================
taskkill /f /im adb.exe >nul 2>&1
"%ADB%" start-server >nul 2>&1
timeout /t 3 /nobreak >nul

echo.
echo Emulator -^> adb mapping (based on your screenshot):
for /l %%i in (0,1,%LAST%) do (
    set /a "PORT=5554 + (%%i * 2)"
    echo   index %%i  =^>  emulator-!PORT!
)

:: ============================================================
:: PHASE 1 - Open Noka B on ALL emulators
:: ============================================================
echo.
echo =========================================
echo PHASE 1: Opening %PKG2% on all instances...
echo =========================================
for /l %%i in (0,1,%LAST%) do (
    set /a "PORT=5554 + (%%i * 2)"
    echo   - i%%i : monkey %PKG2%
    "%ADB%" -s emulator-!PORT! shell monkey -p %PKG2% 1 >nul 2>&1
)
echo Waiting 15 seconds...
timeout /t 15 /nobreak >nul

:: ============================================================
:: PHASE 2 - Send deep link to Noka B on ALL emulators
:: ============================================================
echo.
echo =========================================
echo PHASE 2: Sending deep link to %PKG2% on all instances...
echo =========================================
for /l %%i in (0,1,%LAST%) do (
    set /a "PORT=5554 + (%%i * 2)"
    echo   - i%%i : deep link
    "%ADB%" -s emulator-!PORT! shell am start -W -a android.intent.action.VIEW -d "%DEEPLINK%" -p %PKG2%
)
echo Waiting 20 seconds...
timeout /t 20 /nobreak >nul

:: ============================================================
:: PHASE 3 - Open Noka A on ALL emulators
:: ============================================================
echo.
echo =========================================
echo PHASE 3: Opening %PKG1% on all instances...
echo =========================================
for /l %%i in (0,1,%LAST%) do (
    set /a "PORT=5554 + (%%i * 2)"
    echo   - i%%i : monkey %PKG1%
    "%ADB%" -s emulator-!PORT! shell monkey -p %PKG1% 1 >nul 2>&1
)
echo Waiting 15 seconds...
timeout /t 15 /nobreak >nul

:: ============================================================
:: PHASE 4 - Send deep link to Noka A on ALL emulators
:: ============================================================
echo.
echo =========================================
echo PHASE 4: Sending deep link to %PKG1% on all instances...
echo =========================================
for /l %%i in (0,1,%LAST%) do (
    set /a "PORT=5554 + (%%i * 2)"
    echo   - i%%i : deep link
    "%ADB%" -s emulator-!PORT! shell am start -W -a android.intent.action.VIEW -d "%DEEPLINK%" -p %PKG1%
)
echo Waiting 20 seconds...
timeout /t 20 /nobreak >nul

:: ============================================================
:: Arrange windows
:: ============================================================
echo.
echo Arranging windows...
"%LD%" sortWnd >nul 2>&1

echo.
echo =========================================
echo Monitoring started (read-only). Ctrl+C to stop.
echo =========================================

:: ============================================================
:: Monitor loop — NO joining, NO force-stop
:: ============================================================
:monitor
for /l %%i in (0,1,%LAST%) do (
    set /a "PORT=5554 + (%%i * 2)"
    set "SER=emulator-!PORT!"

    set "RX1="
    "%ADB%" -s !SER! shell "cat /proc/net/xt_qtaguid/stats 2>/dev/null" > "%STATS_TMP%" 2>nul
    for /f "tokens=2 delims==" %%a in ('findstr /i "10060" "%STATS_TMP%"') do set "RX1=%%a"

    timeout /t 4 /nobreak >nul

    set "RX2="
    "%ADB%" -s !SER! shell "cat /proc/net/xt_qtaguid/stats 2>/dev/null" > "%STATS_TMP%" 2>nul
    for /f "tokens=2 delims==" %%a in ('findstr /i "10060" "%STATS_TMP%"') do set "RX2=%%a"

    if "!RX1!"=="" (
        echo [%time%] [i%%i] Could not read stats. (Normal if Android 9+)
    ) else if "!RX1!"=="!RX2!" (
        echo [%time%] [i%%i] NO DATA (disconnected).
    ) else (
        echo [%time%] [i%%i] OK - RX=!RX2!
    )
)

echo.
echo Cycle complete. Waiting 10s before next check...
timeout /t 10 /nobreak >nul
goto monitor

:: ============================================================
:: Bad input handler
:: ============================================================
:bad_input
echo.
echo Invalid input. Please enter a whole number like 1, 3, 7, 10 ...
pause
exit /b 1