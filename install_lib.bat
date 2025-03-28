@echo off
setlocal enabledelayedexpansion

:: Đặt tên môi trường
set ENV_NAME=mttn

:: Kiểm tra xem môi trường đã tồn tại chưa
conda env list | findstr /C:"%ENV_NAME%" >nul
if %errorlevel% equ 0 echo Conda environment '%ENV_NAME%' already exists.
if %errorlevel% neq 0 echo Creating new Conda environment '%ENV_NAME%' with Python 3.10... & call conda create -n %ENV_NAME% python=3.10 -y

:: Kích hoạt môi trường
echo Activating environment '%ENV_NAME%'...
call conda activate %ENV_NAME%

:: Cập nhật pip trước khi cài đặt
echo Updating pip...
python -m pip install --upgrade pip

:: Cài đặt thư viện bằng pip
echo Installing machine learning libraries...
pip install numpy pandas matplotlib scikit-learn torch torchvision torchaudio tensorflow notebook

echo Setup complete. To activate the environment, use:
echo conda activate %ENV_NAME%
