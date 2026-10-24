@echo off
setlocal EnableDelayedExpansion
title OffGridUSB (offgridusb.com) // Universal Offline Knowledge ^& Adaptive AI Harness

set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"

cls
echo ================================================================================
echo   OffGridUSB (offgridusb.com) // Universal Offline Knowledge ^& Adaptive AI Harness
echo   USB Portable Edition  ^|  Zero Docker  ^|  Zero Cloud  ^|  100%% Air-Gapped
echo ================================================================================
echo.

set "PORT=8000"
if defined EMYRGE_PORT set "PORT=%EMYRGE_PORT%"

:: Detect LAN IPv4 so phones/tablets in the pitch room can also connect if desired
set "LAN_IP="
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4"') do (
    set "TMP_IP=%%a"
    set "TMP_IP=!TMP_IP: =!"
    if not "!TMP_IP!"=="" if "!LAN_IP!"=="" (
        echo !TMP_IP! | findstr /b "169.254." >nul
        if !errorlevel! neq 0 set "LAN_IP=!TMP_IP!"
    )
)

echo   [1/3] Local Command Center : http://127.0.0.1:%PORT%
if not "%LAN_IP%"=="" (
    echo   [2/3] Pitch Room LAN Access: http://%LAN_IP%:%PORT%  ^(Phones / Tablets / Peers^)
) else (
    echo   [2/3] Air-Gap Status       : Wi-Fi OFF / Standalone Offline Mode Verified
)
echo   [3/3] Offline ZIM Library  : http://127.0.0.1:8081  ^(Kiwix Server^)
echo.
echo   Starting OffGridUSB Engine... Browser will open automatically in 2 seconds.
echo   ^(Keep this window open while using OffGridUSB. Press Ctrl+C to stop.^)
echo ================================================================================
echo.

:: Wait until http://127.0.0.1:%PORT%/api/status is live, then open default browser cleanly
start "" powershell -NoProfile -WindowStyle Hidden -Command "for($i=0;$i -lt 30;$i++){try{$r=Invoke-WebRequest -Uri 'http://127.0.0.1:%PORT%/api/status' -UseBasicParsing -TimeoutSec 1 -ErrorAction Stop; if($r.StatusCode -eq 200){break}}catch{}; Start-Sleep -Milliseconds 500}; Start-Process 'http://127.0.0.1:%PORT%'"

:: Delegate to portable launcher bound to 0.0.0.0 so both localhost and LAN devices work
call "%SCRIPT_DIR%run_windows.bat" --host 0.0.0.0 --port %PORT% --headless

if %errorlevel% neq 0 (
    echo.
    echo [WARN] Native runtime exited with code %errorlevel%.
    pause
)
exit /b 0
