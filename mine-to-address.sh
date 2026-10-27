#!/usr/bin/env bash
ADDRESS="$1"
if [ -z "$ADDRESS" ]; then
    echo "Usage: ./mine-to-address.sh <XMR_ADDRESS>"
    exit 1
fi
curl -s -X POST http://127.0.0.1:28081/stop_mining -H "Content-Type: application/json" > /dev/null
curl -s -X POST http://127.0.0.1:28081/start_mining -H "Content-Type: application/json" -d "{\"miner_address\":\"$ADDRESS\",\"threads_count\":2}"
echo ""
echo "Mining started to $ADDRESS"
