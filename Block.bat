@echo off
title Website Block/Unblock Script

:: Display Branding Banner
echo.
echo ================================================
echo          Website Block/Unblock Script
echo              Developed by Avanish Kumar
echo                  (Thelegendavanish)
echo ================================================
echo.

:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo This script requires administrative privileges.
    echo.
    echo Please run this script as Administrator.
    pause
    exit /B
)

:MENU
echo ================================================
echo        Website Block/Unblock Script
echo ================================================
echo [1] Block a Website
echo [2] Unblock a Website
echo [3] List Blocked Websites
echo [4] Exit
echo ================================================
set /p choice="Enter your choice (1/2/3/4): "

if "%choice%" == "1" goto BLOCK
if "%choice%" == "2" goto UNBLOCK
if "%choice%" == "3" goto LIST
if "%choice%" == "4" exit

:INVALID
echo Invalid choice! Please try again.
goto MENU

:BLOCK
set /p website="Enter the website to block (e.g., example.com): "
echo Blocking %website% by modifying the hosts file...

:: Backup the current hosts file
if not exist C:\Windows\System32\drivers\etc\hosts.bak (
    copy C:\Windows\System32\drivers\etc\hosts C:\Windows\System32\drivers\etc\hosts.bak
)

:: Add the website to hosts file
findstr /C:"127.0.0.1 %website%" C:\Windows\System32\drivers\etc\hosts >nul 2>&1
if '%errorlevel%' EQU '0' (
    echo %website% is already blocked.
) else (
    echo 127.0.0.1 %website% >> C:\Windows\System32\drivers\etc\hosts
    echo 127.0.0.1 www.%website% >> C:\Windows\System32\drivers\etc\hosts
    echo %website% has been blocked successfully!
)
pause
goto MENU

:UNBLOCK
set /p website="Enter the website to unblock (e.g., example.com): "
echo Unblocking %website% by modifying the hosts file...

:: Remove the website entries from hosts file
findstr /v "%website%" C:\Windows\System32\drivers\etc\hosts > C:\Windows\System32\drivers\etc\hosts.tmp
move /Y C:\Windows\System32\drivers\etc\hosts.tmp C:\Windows\System32\drivers\etc\hosts

echo %website% has been unblocked successfully!
pause
goto MENU

:LIST
echo ================================================
echo          List of Blocked Websites
echo ================================================
echo Blocked websites are:
findstr /C:"127.0.0.1" C:\Windows\System32\drivers\etc\hosts
echo ================================================
pause
goto MENU
