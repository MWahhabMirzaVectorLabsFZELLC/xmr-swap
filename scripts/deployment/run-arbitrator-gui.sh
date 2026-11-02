#!/bin/bash
#
# Start arbitrator GUI on Monero's stagenet (zeroswap testnet)

runArbitrator() {
    ./haveno-desktop --baseCurrencyNetwork=XMR_STAGENET \
    --useLocalhostForP2P=false \
    --useDevPrivilegeKeys=false \
    --nodePort=7777 \
    --appName=zeroswap-XMR_STAGENET_arbitrator \
    --xmrNode=http://127.0.0.1:38088 \
    --xmrNodeUsername=admin \
    --xmrNodePassword=password
}

cd /home/haveno/haveno && \
runArbitrator
