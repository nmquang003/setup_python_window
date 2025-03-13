@echo off
setlocal enabledelayedexpansion

:: Đặt tên môi trường
set ENV_NAME=mttn
set CONDA_INSTALL_PATH=%USERPROFILE%\miniconda3

:: Kích hoạt môi trường
echo Activating environment '%ENV_NAME%'...
call conda activate %ENV_NAME%
if %errorlevel% neq 0 (
    echo Error activating environment. Exiting.
    exit /b 1
)

:: Cập nhật pip trước khi cài đặt
echo Updating pip...
python -m pip install --upgrade pip

:: Cài đặt thư viện bằng pip
echo Installing machine learning libraries...
@REM pip install numpy pandas matplotlib scikit-learn torch torchvision torchaudio tensorflow

if %errorlevel% neq 0 (
    echo Error installing libraries. Continuing.
)

echo Setup complete! To activate the environment, use:
echo conda activate %ENV_NAME%
