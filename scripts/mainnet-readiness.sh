#!/usr/bin/env bash
set -euo pipefail

failures=0

check_absent() {
    local pattern="$1"
    local path="$2"
    local message="$3"
    if grep -Eq -- "$pattern" "$path"; then
        echo "NO-GO: $message"
        failures=$((failures + 1))
    fi
}

check_present() {
    local pattern="$1"
    local path="$2"
    local message="$3"
    if ! grep -Eq -- "$pattern" "$path"; then
        echo "NO-GO: $message"
        failures=$((failures + 1))
    fi
}

check_present 'P2P_NETWORK_VERSION = "Z"' common/src/main/java/haveno/common/app/Version.java 'zeroswap P2P version is not Z'
check_present 'RELEASE_DATE = "15-12-2026 00:00:00"' core/src/main/java/haveno/core/trade/HavenoUtils.java 'approved launch date is missing'
check_present '--arguments --baseCurrencyNetwork=XMR_MAINNET' desktop/package/package.gradle 'installer is not mainnet'
check_absent 'placeholder\.onion|@placeholder' core/src/main/resources/xmr_mainnet.seednodes 'real mainnet seed nodes are missing'

if grep -A2 'case XMR_MAINNET:' core/src/main/java/haveno/core/filter/FilterManager.java | grep -q 'return List.of();'; then
    echo 'NO-GO: mainnet filter public keys are missing'
    failures=$((failures + 1))
fi
if grep -A2 'case XMR_MAINNET:' core/src/main/java/haveno/core/alert/AlertManager.java | grep -q 'return List.of();'; then
    echo 'NO-GO: mainnet alert public keys are missing'
    failures=$((failures + 1))
fi
if grep -A2 'case XMR_MAINNET:' core/src/main/java/haveno/core/alert/PrivateNotificationManager.java | grep -q 'return List.of();'; then
    echo 'NO-GO: mainnet private-notification public keys are missing'
    failures=$((failures + 1))
fi
if grep -A2 'case XMR_MAINNET:' core/src/main/java/haveno/core/support/dispute/arbitration/arbitrator/ArbitratorManager.java | grep -q 'return List.of();'; then
    echo 'NO-GO: mainnet arbitrator public keys are missing'
    failures=$((failures + 1))
fi
if grep -q 'elaxlgigphpicy5q7pi5wkz2ko2vgjbq4576vic7febmx4xcxvk6deqd.onion' core/src/main/java/haveno/core/provider/ProvidersRepository.java; then
    echo 'NO-GO: upstream Haveno price providers are still configured'
    failures=$((failures + 1))
fi
if [[ ! -f config/mainnet/release-approval.properties ]]; then
    echo 'NO-GO: release signing approval file is missing'
    failures=$((failures + 1))
elif grep -q 'REQUIRED' config/mainnet/release-approval.properties; then
    echo 'NO-GO: release signing approvals are incomplete'
    failures=$((failures + 1))
fi

if ((failures > 0)); then
    echo "Mainnet readiness failed with $failures blocking item(s)."
    exit 1
fi

echo 'Mainnet repository readiness checks passed.'
