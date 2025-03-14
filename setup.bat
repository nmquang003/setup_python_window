@echo off
setlocal enabledelayedexpansion

:: Kiểm tra xem Conda đã được cài đặt chưa
where conda >nul 2>nul
if %errorlevel% equ 0 call echo Miniconda already installed.
if %errorlevel% neq 0 echo Miniconda not found. & call install_conda.bat