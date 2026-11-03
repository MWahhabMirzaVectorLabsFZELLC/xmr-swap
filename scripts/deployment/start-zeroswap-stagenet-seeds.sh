#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
LOG_DIR="$REPO_ROOT/.localnet/logs/stagenet-seeds"
PID_DIR="$REPO_ROOT/.localnet/pids/stagenet-seeds"
SEEDNODE_LAUNCHER="$REPO_ROOT/seednode/build/install/seednode/bin/seednode"
mkdir -p "$LOG_DIR" "$PID_DIR"

if [[ ! -x "$SEEDNODE_LAUNCHER" ]]; then
    "$REPO_ROOT/gradlew" :seednode:installDist
fi

start_seed() {
    local name="$1"
    local port="$2"
    local app_name="$3"
    local pid_file="$PID_DIR/$name.pid"
    local log_file="$LOG_DIR/$name.log"

    if [[ -f "$pid_file" ]] && kill -0 "$(<"$pid_file")" 2>/dev/null; then
        echo "$name already appears to be running (PID $(<"$pid_file")). Log: $log_file"
        return
    fi

    nohup "$SEEDNODE_LAUNCHER" \
        --baseCurrencyNetwork=XMR_STAGENET \
        --useLocalhostForP2P=false \
        --useDevPrivilegeKeys=false \
        --nodePort="$port" \
        --appName="$app_name" \
        >"$log_file" 2>&1 &
    echo "$!" > "$pid_file"
    echo "Started $name on P2P port $port (PID $!). Log: $log_file"
}

start_seed "seed-1" 3002 "zeroswap-XMR_STAGENET_Seed_3002"
start_seed "seed-2" 3003 "zeroswap-XMR_STAGENET_Seed_3003"

echo "Wait for both logs to show Tor bootstrap and hidden-service publication before connecting clients."
