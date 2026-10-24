@echo off
setlocal EnableDelayedExpansion
title OffGridUSB (offgridusb.com) // Universal Offline Knowledge ^& Adaptive AI Harness

set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"
call "%SCRIPT_DIR%START_OFFGRIDUSB_WINDOWS.bat" %*
