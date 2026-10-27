@echo off
cd /d "%~dp0"
call haveno-desktop.bat --baseCurrencyNetwork=XMR_LOCAL --useLocalhostForP2P=true --useDevPrivilegeKeys=true --nodePort=4444 --appName=haveno-XMR_LOCAL_arbitrator --apiPassword=apitest --apiPort=9998 --xmrNode=http://127.0.0.1:48081
