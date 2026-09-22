@echo off
setlocal

echo ============================================================
echo UltraSam official Windows/Anaconda environment setup
echo ============================================================

where conda >nul 2>nul
if errorlevel 1 (
  echo ERROR: conda was not found. Open this file from Anaconda Prompt.
  pause
  exit /b 1
)

call conda create -n UltraSam python=3.8 -y
if errorlevel 1 goto :fail

call conda activate UltraSam
if errorlevel 1 goto :fail

python -m pip install --upgrade pip
if errorlevel 1 goto :fail

python -m pip install torch==2.0.0 torchvision==0.15.1 torchaudio==2.0.1 --index-url https://download.pytorch.org/whl/cu118
if errorlevel 1 goto :fail

python -m pip install -U openmim
if errorlevel 1 goto :fail

mim install mmengine
if errorlevel 1 goto :fail

mim install "mmcv==2.1.0"
if errorlevel 1 goto :fail

mim install mmdet
if errorlevel 1 goto :fail

mim install mmpretrain
if errorlevel 1 goto :fail

python -m pip install tensorboard ipykernel pillow opencv-python scipy scikit-learn pandas matplotlib tqdm albumentations
if errorlevel 1 goto :fail

python -m ipykernel install --user --name UltraSam --display-name "Python (UltraSam)"
if errorlevel 1 goto :fail

echo.
echo ============================================================
echo SUCCESS

echo In Jupyter: Kernel ^> Change kernel ^> Python (UltraSam)
echo Then restart the notebook and Run All.
echo ============================================================
pause
exit /b 0

:fail
echo.
echo ============================================================
echo SETUP FAILED. Copy the first ERROR shown above and send it here.
echo ============================================================
pause
exit /b 1
