@echo off
setlocal enabledelayedexpansion

:: Đặt tên môi trường
set CONDA_INSTALL_PATH=%USERPROFILE%\miniconda3

:: Kiểm tra xem Conda đã được cài đặt chưa
where conda >nul 2>nul
if %errorlevel% neq 0 (
    echo Miniconda not found. Downloading and installing...

    start /c install_conda.bat

    if %errorlevel% neq 0 (
        echo Error installing Miniconda. Exiting.
        exit /b 1
    )

    :: Cập nhật PATH tạm thời
    set PATH=%CONDA_INSTALL_PATH%\Scripts;%CONDA_INSTALL_PATH%\Library\bin;%PATH%

    if %errorlevel% neq 0 (
        echo Error activating Conda. Exiting.
        exit /b 1
    )
) else (
    echo Miniconda is already installed.
)

:: Kiểm tra xem môi trường đã tồn tại chưa
conda env list | findstr /C:"%ENV_NAME%" >nul
if %errorlevel% neq 0 (
    echo Creating new Conda environment '%ENV_NAME%' with Python 3.10...
    conda create -n %ENV_NAME% python=3.10 -y
    if %errorlevel% neq 0 (
        echo Error creating Conda environment. Exiting.
        echo %errorlevel%
    )
) else (
    echo Conda environment '%ENV_NAME%' already exists.
)