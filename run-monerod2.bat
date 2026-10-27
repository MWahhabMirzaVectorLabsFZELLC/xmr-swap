@echo off
cd /d "%~dp0"
.localnet\monerod.exe --testnet --no-igd --hide-my-port --data-dir .localnet/xmr_local/node2 --p2p-bind-ip 127.0.0.1 --p2p-bind-port 48080 --rpc-bind-port 48081 --zmq-rpc-bind-port 48082 --log-level 0 --add-exclusive-node 127.0.0.1:28080 --add-exclusive-node 127.0.0.1:58080 --rpc-access-control-origins http://localhost:8080 --fixed-difficulty 500 --disable-rpc-ban --rpc-max-connections 1000 --max-connections-per-ip 10 --rpc-max-connections-per-private-ip 1000
