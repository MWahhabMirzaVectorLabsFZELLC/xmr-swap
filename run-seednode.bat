@echo off
cd /d "%~dp0"
call haveno-seednode.bat --baseCurrencyNetwork=XMR_LOCAL --useLocalhostForP2P=true --useDevPrivilegeKeys=true --nodePort=2002 --appName=haveno-XMR_LOCAL_Seed_2002 --xmrNode=http://localhost:28081
