@echo off
cd /d "%~dp0"
call haveno-desktop.bat --baseCurrencyNetwork=XMR_LOCAL --useLocalhostForP2P=true --useDevPrivilegeKeys=true --nodePort=6666 --appName=haveno-XMR_LOCAL_user2 --apiPassword=apitest --apiPort=10000 --walletRpcBindPort=38092 --logLevel=info
