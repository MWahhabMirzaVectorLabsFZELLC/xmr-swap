#!/usr/bin/env bash
curl -s -X POST http://127.0.0.1:28081/stop_mining -H "Content-Type: application/json"
echo ""
echo "Mining stopped."
