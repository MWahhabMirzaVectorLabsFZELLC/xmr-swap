@echo off
cd /d "%~dp0"
call haveno-desktop.bat --baseCurrencyNetwork=XMR_LOCAL --useLocalhostForP2P=true --useDevPrivilegeKeys=true --nodePort=5555 --appName=zeroswap-XMR_LOCAL_user1 --apiPassword=apitest --apiPort=9999 --walletRpcBindPort=38091 --logLevel=info
