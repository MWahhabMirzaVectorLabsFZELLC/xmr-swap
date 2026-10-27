@echo off
cd /d "%~dp0"
echo Stopping Haveno Localnet background services...
powershell -NoProfile -ExecutionPolicy Bypass -Command "& 'C:\Program Files\Git\bin\bash.exe' -c './stop-localnet.sh'"
pause
