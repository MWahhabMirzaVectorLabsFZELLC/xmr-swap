#!/usr/bin/env bash
ADDRESS="9whdX4LvjC6azmuoRG3gKJUNnhm7rg9PAi5FgtCijRjcZrv6dgZkDKdj4ehLNkXS4oVaqHeBZL3TNVC5irHsXSnHHpofNTf"
echo "Stopping any previous miner..."
curl -s -X POST http://127.0.0.1:28081/stop_mining -H "Content-Type: application/json" > /dev/null
echo "Starting mining to Seller address..."
curl -s -X POST http://127.0.0.1:28081/start_mining -H "Content-Type: application/json" -d "{\"miner_address\":\"$ADDRESS\",\"threads_count\":2}"
echo ""
echo "Mining successfully started to Seller address!"
echo "Check status anytime with: ./check-mining.sh"
echo "Stop mining anytime with: ./stop-mining.sh"
