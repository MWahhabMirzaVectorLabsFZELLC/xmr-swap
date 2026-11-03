#!/usr/bin/env bash
set -euo pipefail

: "${ZEROSWAP_XMR_RPC_USER:?Set ZEROSWAP_XMR_RPC_USER in the protected operator environment}"
: "${ZEROSWAP_XMR_RPC_PASSWORD:?Set ZEROSWAP_XMR_RPC_PASSWORD in the protected operator environment}"

exec ./haveno-desktop \
    --baseCurrencyNetwork=XMR_MAINNET \
    --useLocalhostForP2P=false \
    --useDevPrivilegeKeys=false \
    --nodePort=7777 \
    --appName=zeroswap-XMR_MAINNET-arbitrator \
    --xmrNode=http://127.0.0.1:18081 \
    --xmrNodeUsername="$ZEROSWAP_XMR_RPC_USER" \
    --xmrNodePassword="$ZEROSWAP_XMR_RPC_PASSWORD"
