#!/usr/bin/env bash
echo "============================================="
echo "        Haveno Localnet Status               "
echo "============================================="

# Node 1
if curl -s http://127.0.0.1:28081/get_info > /dev/null 2>&1; then
    INFO=$(curl -s http://127.0.0.1:28081/get_info)
    HEIGHT=$(echo "$INFO" | grep -o '"height": *[0-9]*' | awk '{print $NF}')
    PEERS=$(echo "$INFO" | grep -o '"outgoing_connections_count": *[0-9]*' | awk '{print $NF}')
    echo "[Node 1]   RUNNING (port 28081 | Height: $HEIGHT | Peers: $PEERS)"
else
    echo "[Node 1]   STOPPED (port 28081)"
fi

# Node 2
if curl -s http://127.0.0.1:48081/get_info > /dev/null 2>&1; then
    INFO2=$(curl -s http://127.0.0.1:48081/get_info)
    HEIGHT2=$(echo "$INFO2" | grep -o '"height": *[0-9]*' | awk '{print $NF}')
    echo "[Node 2]   RUNNING (port 48081 | Height: $HEIGHT2)"
else
    echo "[Node 2]   STOPPED (port 48081)"
fi

# Seednode
if netstat -ano 2>/dev/null | grep -q ":2002.*LISTENING"; then
    echo "[Seednode] RUNNING (port 2002)"
else
    echo "[Seednode] STOPPED (port 2002)"
fi
echo "============================================="
