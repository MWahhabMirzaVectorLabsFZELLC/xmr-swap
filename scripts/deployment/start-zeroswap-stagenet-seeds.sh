#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
LOG_DIR="$REPO_ROOT/.localnet/logs/stagenet-seeds"
PID_DIR="$REPO_ROOT/.localnet/pids/stagenet-seeds"
LIB_DIR="$REPO_ROOT/lib"
if command -v cygpath >/dev/null 2>&1; then
    JAVA_CLASSPATH="$(cygpath -w "$LIB_DIR")\\*"
else
    JAVA_CLASSPATH="$LIB_DIR/*"
fi
mkdir -p "$LOG_DIR" "$PID_DIR"

if [[ ! -d "$LIB_DIR" ]]; then
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

    nohup java \
        -Xms512m \
        -Xmx1g \
        -XX:+UseG1GC \
        -XX:+ExitOnOutOfMemoryError \
        -Djava.net.preferIPv4Stack=true \
        -Dfile.encoding=UTF-8 \
        -classpath "$JAVA_CLASSPATH" \
        haveno.seednode.SeedNodeMain \
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
