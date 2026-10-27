#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

mkdir -p .localnet/logs
mkdir -p .localnet/pids

echo "============================================="
echo " Starting Haveno Localnet in Background...   "
echo "============================================="

# 1. Monero Node 1 (port 28081)
if netstat -ano 2>/dev/null | grep -q ":28081.*LISTENING"; then
    echo "[Node 1]   Already running on port 28081."
else
    echo "[Node 1]   Starting on port 28081 (log: .localnet/logs/node1.log)..."
    nohup ./.localnet/monerod.exe \
        --testnet \
        --no-igd \
        --hide-my-port \
        --data-dir .localnet/xmr_local/node1 \
        --p2p-bind-ip 127.0.0.1 \
        --log-level 0 \
        --add-exclusive-node 127.0.0.1:48080 \
        --add-exclusive-node 127.0.0.1:58080 \
        --rpc-access-control-origins http://localhost:8080 \
        --fixed-difficulty 500 \
        --disable-rpc-ban \
        --rpc-max-connections 1000 \
        --max-connections-per-ip 10 \
        --rpc-max-connections-per-private-ip 1000 \
        > .localnet/logs/node1.log 2>&1 &
    echo $! > .localnet/pids/node1.pid
fi

# 2. Monero Node 2 (port 48081)
if netstat -ano 2>/dev/null | grep -q ":48081.*LISTENING"; then
    echo "[Node 2]   Already running on port 48081."
else
    echo "[Node 2]   Starting on port 48081 (log: .localnet/logs/node2.log)..."
    nohup ./.localnet/monerod.exe \
        --testnet \
        --no-igd \
        --hide-my-port \
        --data-dir .localnet/xmr_local/node2 \
        --p2p-bind-ip 127.0.0.1 \
        --p2p-bind-port 48080 \
        --rpc-bind-port 48081 \
        --zmq-rpc-bind-port 48082 \
        --log-level 0 \
        --add-exclusive-node 127.0.0.1:28080 \
        --add-exclusive-node 127.0.0.1:58080 \
        --rpc-access-control-origins http://localhost:8080 \
        --fixed-difficulty 500 \
        --disable-rpc-ban \
        --rpc-max-connections 1000 \
        --max-connections-per-ip 10 \
        --rpc-max-connections-per-private-ip 1000 \
        > .localnet/logs/node2.log 2>&1 &
    echo $! > .localnet/pids/node2.pid
fi

# 3. Haveno Seed Node (port 2002)
if netstat -ano 2>/dev/null | grep -q ":2002.*LISTENING"; then
    echo "[Seednode] Already running on port 2002."
else
    echo "[Seednode] Starting on port 2002 (log: .localnet/logs/seednode.log)..."
    nohup cmd.exe /c haveno-seednode.bat \
        --baseCurrencyNetwork=XMR_LOCAL \
        --useLocalhostForP2P=true \
        --useDevPrivilegeKeys=true \
        --nodePort=2002 \
        --appName=haveno-XMR_LOCAL_Seed_2002 \
        --xmrNode=http://localhost:28081 \
        > .localnet/logs/seednode.log 2>&1 &
    echo $! > .localnet/pids/seednode.pid
fi

echo "============================================="
echo " All 3 services are active in background!    "
echo "============================================="
echo "Status check:  ./status-localnet.sh"
echo "Stop all:      ./stop-localnet.sh"
