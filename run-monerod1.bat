@echo off
cd /d "%~dp0"
.localnet\monerod.exe --testnet --no-igd --hide-my-port --data-dir .localnet/xmr_local/node1 --p2p-bind-ip 127.0.0.1 --log-level 0 --add-exclusive-node 127.0.0.1:48080 --add-exclusive-node 127.0.0.1:58080 --rpc-access-control-origins http://localhost:8080 --fixed-difficulty 500 --disable-rpc-ban --rpc-max-connections 1000 --max-connections-per-ip 10 --rpc-max-connections-per-private-ip 1000
