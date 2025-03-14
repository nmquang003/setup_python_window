@echo off
setlocal enabledelayedexpansion

:: Đặt tên môi trường
set CONDA_INSTALL_PATH=%USERPROFILE%\miniconda3

:: Cập nhật PATH tạm thời
set PATH=%CONDA_INSTALL_PATH%\Scripts;%CONDA_INSTALL_PATH%\Library\bin;%PATH%

:: Kiểm tra xem Conda đã được cài đặt chưa
where conda >nul 2>nul
if %errorlevel% neq 0 call install_conda.bat
else echo Miniconda already installed.

if %errorlevel% neq 0 echo Error installing Miniconda & echo Exiting & exit /b 1