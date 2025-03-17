import subprocess
import sys
import importlib

# Danh sách thư viện cần kiểm tra
libraries = [
    "numpy", "pandas", "matplotlib", "scikit-learn",
    "torch", "torchvision", "torchaudio", "tensorflow", "notebook"
]

# Danh sách môi trường cần kiểm tra
envs_to_check = ["natri", "base"]

def check_conda_env(env):
    """ Kiểm tra xem môi trường Conda có tồn tại không """
    try:
        result = subprocess.run(["conda", "env", "list"], capture_output=True, text=True, check=True)
        return any(env in line for line in result.stdout.splitlines())
    except subprocess.CalledProcessError:
        return False

def check_libraries(env):
    """ Kiểm tra các thư viện trong một môi trường Conda cụ thể """
    missing_libs = []
    
    for lib in libraries:
        result = subprocess.run(
            f"conda run -n {env} python -c \"import {lib}\"",
            shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
        )
        if result.returncode != 0:
            missing_libs.append(lib)
    
    if missing_libs:
        print(f"Missing libraries in {env}: {', '.join(missing_libs)}")
    else:
        print(f"All libraries are installed in {env}.")

# Kiểm tra lần lượt các môi trường
for env in envs_to_check:
    if check_conda_env(env):
        print(f"Checking environment: {env}")
        check_libraries(env)
