# zeroswap Mainnet Operations

## Safe defaults

- Production network is `XMR_MAINNET`; P2P identity is `Z`.
- Planned launch date is 15 December 2026.
- GUI and daemon are supported targets on Windows, Linux, and macOS.
- API binds to `127.0.0.1`; remote access must use an authenticated private tunnel.
- Fresh `zeroswap` profiles are required. Do not copy an upstream Haveno profile into production.
- Arbitrators assign trade-fee addresses. No global fee wallet is enabled.

## Required production inputs

Mainnet cannot launch until the owner supplies and verifies:

- at least three Tor v3 seed nodes across two operators/providers;
- separate public keys for arbitrator registration, filters, alerts, and private notifications;
- at least two zeroswap-controlled price providers;
- two trained arbitrators and their public registration keys;
- official domain, download, documentation, support, and private security contacts;
- release-signing fingerprint, protected signing setup, and platform certificates;
- legal text, operating entity, target countries, and data-retention policy;
- monitoring destination, on-call order, backup location, and recovery objectives.

Private keys, seeds, passwords, and RPC credentials must never enter Git, CI logs, tickets, or chat.

## Key ceremony

Generate every role key on an offline clean machine. Use a different key per role and custodian. Record only the public key, fingerprint, owner, backup owner, creation date, and rotation date in the inventory. Encrypt two offline backups and test recovery before activation. Two people must compare fingerprints before a code change is approved.

## Deployment

1. Create dedicated `zeroswap`, `monero`, and monitoring users.
2. Copy example configs outside the repository and replace all `REQUIRED` values.
3. Restrict secret files to their service owner.
4. Keep unrestricted Monero RPC on loopback or a private authenticated network.
5. Allow public traffic only to intended Tor/onion services. Do not expose gRPC directly.
6. Start one seed at a time, confirm peer health, then continue.
7. Run `bash scripts/mainnet-readiness.sh` before any release tag.
8. Commit `config/mainnet/release-approval.properties` with public fingerprints and evidence references only.

## Monitoring and alerts

Monitor Monero sync height, RPC health, Tor bootstrap, seed peer count, provider price age/deviation, arbitrator visibility, disk, memory, clock drift, backup age, domain/download TLS, and release hashes. Warning alerts need an owner; critical alerts need a primary and backup responder.

## Backup and restore

Stop or quiesce the service, encrypt the complete application directory and operator records, copy it to two independent locations, and record a checksum. Never back up an unlocked wallet to shared storage. Every release cycle, restore onto a clean isolated host and verify wallet addresses, trade state, disputes, and service startup before marking the backup healthy.

## Incident actions

- Seed loss: remove it from rotation, verify remaining seeds, rebuild from a clean host, then rotate its onion address if compromise is possible.
- Monero desync: stop new operational actions, fail over to a verified synced node, compare heights, and investigate the failed node.
- Wrong/stale price: disable affected providers and new market-price offers; preserve fixed-price offers and in-progress trades.
- Stuck trade/dispute surge: preserve all data, avoid forced payouts, increase human coverage, and reconcile each trade independently.
- Disk or wallet damage: stop writes, take a forensic copy, restore the last tested backup, then reconcile from chain and peer messages.
- Stolen key/domain: revoke or replace it, publish an alert through a separate trusted channel, block releases, and rotate all related credentials.
- Bad release: stop distribution, keep in-progress trades safe, publish verified hashes of the last good release, and require a new signed tag for the fix.

## Staged launch

Run private stagenet first: buy/sell, maker/taker, min/normal/max, concurrent trades, reconnects, disputes, deposits, payouts, restart, upgrade, backup, and restore. Record balances, mining fees, and trade fees before and after each case. Any unexplained difference is a stop condition.

Real-XMR canary requires separate owner approval, funded test wallets, agreed caps, live monitoring, and two operators. Public beta and full release remain blocked until the final checklist is fully signed.
