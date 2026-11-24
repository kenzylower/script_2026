@echo off
setlocal enabledelayedexpansion

REM ================= CONFIGURATION =================
REM 1. Set your LDPlayer 9 installation path
set "LD_PATH=C:\LDPlayer\LDPlayer9"

REM 2. Set the exact path to your backup file (replace 'YourUsername' with your actual Windows username)
set "BACKUP_FILE=C:\Users\ADMIN\Downloads\LDPlayer-new.ldbk"

REM 3. Set the target instances to overwrite (1 to 13)
set "TOTAL=14"
REM =================================================

cd /d "%LD_PATH%"

echo Starting the restore process...
echo Please ensure ALL target instances (Index 1 to 13) are FULLY CLOSED.
echo.

for /l %%i in (1,1,%TOTAL%) do (
    echo [Restoring] Index %%i ...
    
    REM Execute the restore command
    ldconsole.exe restore --index %%i --file "%BACKUP_FILE%"
    
    REM Check if the command was successful
    if !errorlevel! neq 0 (
        echo [FAILED] Index %%i could not be restored. Make sure it is not running.
    ) else (
        echo [SUCCESS] Index %%i has been overwritten with Index 0 data.
    )
    echo ----------------------------------------
)

echo.
echo All operations completed. Please refresh LDMultiplayer.
pause