#!/bin/bash
#
# Start arbitrator daemon on Monero's stagenet (zeroswap testnet)

runArbitrator() {
    ./haveno-daemon --baseCurrencyNetwork=XMR_STAGENET \
    --useLocalhostForP2P=false \
    --useDevPrivilegeKeys=false \
    --apiPassword="${HAVENO_API_PASSWORD:?Set HAVENO_API_PASSWORD to a strong API password}" \
    --nodePort=7777 \
    --appName=zeroswap-XMR_STAGENET_arbitrator \
    --xmrNode=http://127.0.0.1:38088 \
    --xmrNodeUsername=admin \
    --xmrNodePassword=password
}

cd /home/haveno/haveno && \
runArbitrator
