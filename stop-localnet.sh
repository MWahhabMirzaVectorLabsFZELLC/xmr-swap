#!/usr/bin/env bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

echo "============================================="
echo " Stopping Haveno Localnet services...        "
echo "============================================="

# Cleanly stop Monero nodes via RPC
curl -s -X POST http://127.0.0.1:28081/stop_daemon > /dev/null 2>&1 || true
curl -s -X POST http://127.0.0.1:48081/stop_daemon > /dev/null 2>&1 || true

sleep 1

# Kill remaining monerod if still running
taskkill //F //IM monerod.exe 2>/dev/null || true

# Kill seednode java process by port 2002
SEED_PID=$(netstat -ano 2>/dev/null | grep ":2002.*LISTENING" | awk '{print $NF}' | head -n 1)
if [ -n "$SEED_PID" ]; then
    taskkill //F //PID "$SEED_PID" 2>/dev/null || true
fi

# Clean PID files
rm -f .localnet/pids/*.pid 2>/dev/null || true

echo "All 3 background services stopped."
echo "============================================="
