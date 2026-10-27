# Haveno Localnet Commands (Windows)

## Quick Start: All-in-One Background Services

To start **Node 1, Node 2, and the Seednode** all together in the background with a single command:

```bash
./start-localnet.sh
```

* **Check status anytime:** `./status-localnet.sh`
* **Stop all 3 services:** `./stop-localnet.sh`
* **Logs are saved cleanly to:** `.localnet/logs/node1.log`, `node2.log`, `seednode.log`

*(You can also double-click `start-localnet.bat` / `stop-localnet.bat` directly from Windows Explorer).*

---

## Running Desktop Applications

Once the background network is running, launch whichever desktop apps you need:

* **Seller Desktop (`user1`):** `./run-seller.bat` (or `make user1-desktop-local`)
* **Buyer Desktop (`user2`):**  `./run-buyer.bat` (or `make user2-desktop-local`)
* **Arbitrator Desktop:**       `./run-arbitrator.bat` (or `make arbitrator-desktop-local`)

---

## Individual Manual Commands

### 1. Monero Daemon (Node 1)
Starts the local Monero testnet daemon on port `28081` (p2p: `28080`):
```bash
make monerod1-local
```
> Keep this terminal accessible for issuing mining commands (`start_mining` / `stop_mining`).

---

### 2. Haveno Seed Node
Starts the local P2P seed node on localhost port `2002`:
```bash
make seednode-local
```

---

### 3. Arbitrator Desktop
Launches the Arbitrator desktop GUI (port `4444`, API port `9998`):
```bash
make arbitrator-desktop-local
```
> **First-time setup:** After the GUI opens, navigate to the **Account** tab and press <kbd>Ctrl</kbd> + <kbd>R</kbd> (or <kbd>Alt</kbd> + <kbd>R</kbd>) to register the arbitrator.

---

### 4. Seller Desktop (`user1`)
Launches the first trader instance as the **Seller** (port `5555`, API port `9999`, wallet RPC `38091`):
```bash
make user1-desktop-local
```
*Data directory: `%APPDATA%\haveno-XMR_LOCAL_user1\`*

---

### 5. Buyer Desktop (`user2`)
Launches the second trader instance as the **Buyer** (port `6666`, API port `10000`, wallet RPC `38092`):
```bash
make user2-desktop-local
```
*Data directory: `%APPDATA%\haveno-XMR_LOCAL_user2\`*

---

## Supplementary Notes

### Optional Monero Node 2 (Arbitrator Node)
The Makefile configures `arbitrator-desktop-local` with `--xmrNode=http://127.0.0.1:48081`. To run the dedicated paired node for the arbitrator:
```bash
make monerod2-local
```
*(Node 1 and Node 2 peer together and share the same chain).*

---

## Quick Reference: Mining & Funding Commands

Run these directly inside the **Monero Daemon (Node 1)** terminal:

### 1. Initial Chain Warmup (150 blocks)
Run once before creating or funding wallets:
```text
start_mining 9tsUiG9bwcU7oTbAdBwBk2PzxFtysge5qcEsHEpetmEKgerHQa1fDqH7a4FiquZmms7yM22jdifVAD7jAb2e63GSJMuhY75 1
```
Wait ~1–2 minutes, then:
```text
stop_mining
```

### 2. Fund Seller Wallet
Copy the address from Seller GUI (**Funds** → **Deposit**):
```text
start_mining <SELLER_ADDRESS> 1
```
Mine ~30–50 blocks until the balance appears, then:
```text
stop_mining
```

### 3. Fund Buyer Wallet
Copy the address from Buyer GUI (**Funds** → **Deposit**):
```text
start_mining <BUYER_ADDRESS> 1
```
Mine ~30–50 blocks until the balance appears, then:
```text
stop_mining
```

### 4. Confirming Trades
Whenever a trade step waits for blockchain confirmations (e.g., funding or payout), mine a few blocks:
```text
start_mining 9tsUiG9bwcU7oTbAdBwBk2PzxFtysge5qcEsHEpetmEKgerHQa1fDqH7a4FiquZmms7yM22jdifVAD7jAb2e63GSJMuhY75 1
```
And stop when the step completes:
```text
stop_mining
```
