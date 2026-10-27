@echo off
cd /d "%~dp0"
echo Starting Haveno Localnet background services...
powershell -NoProfile -ExecutionPolicy Bypass -Command "& 'C:\Program Files\Git\bin\bash.exe' -c './start-localnet.sh'"
pause
