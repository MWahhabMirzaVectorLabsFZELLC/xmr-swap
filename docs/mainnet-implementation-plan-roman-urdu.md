# zeroswap Mainnet Implementation Plan

Mojooda branch: `feature/mainnet`
Mojooda status: **MAINNET KE LIYE TAYYAR NAHI**
Plan ka maqsad: repository, deployment templates, tests aur release process ko real-XMR pilot ke liye tayyar karna

Yeh plan sirf un kaamon ka hai jo main code, configuration, tests aur documentation mein kar sakta hoon. Jahan server, private key, legal approval, paid account ya real XMR chahiye ho, wahan main setup aur verification karunga lekin final input/approval aap denge.

## Kaam karne ke rules

- Har phase alag reviewed commit mein hoga.
- Har phase ke baad relevant build, Checkstyle aur tests chalenge.
- Private keys, seeds aur passwords kabhi Git ya chat mein nahi aayenge.
- Mainnet par real funds tab tak use nahi honge jab tak stagenet rehearsal pass na ho.
- Real-XMR test sirf aapki alag aur clear approval ke baad hoga.
- Ek phase ka required input missing ho to us phase ko rok kar doosra independent kaam kiya ja sakta hai.
- Kisi bhi critical security, payout ya balance problem par launch status dobara **NO-GO** hoga.

## Phase 0: Mojooda branding changes ko complete aur isolate karna

### Main kya karunga

- User-facing naam ko exact lowercase `zeroswap` rakhunga.
- Window titles, startup screen, CLI help, app profiles aur service descriptions verify karunga.
- Windows, macOS, Linux aur Flatpak installer names ko verify karunga.
- GitHub release artifact names ko installer output ke sath match karunga.
- Internal `haveno.*` Java packages, protocol names, upstream links aur license history ko compatibility ke liye preserve karunga.
- Purane Haveno wordmark ko active UI se hata kar `zeroswap` text branding verify karunga.
- Final diff review ke baad branding ko alag commit mein rakhunga.

### Aapse kya chahiye

- Final zeroswap logo aur icon, agar existing icon bhi change karna hai.
- Confirm karna ke product name hamesha lowercase `zeroswap` hi dikhna chahiye.
- Official website, support email aur download URL jab available hon.

### Verification

- `:common:checkstyleMain`
- `:core:checkstyleMain`
- `:desktop:checkstyleMain`
- `:seednode:checkstyleMain`
- `:desktop:compileJava`
- Packaging configuration audit
- User-facing `Haveno` literal audit

### Phase complete kab hoga

- App ke active screens, window title aur installer metadata mein `zeroswap` ho.
- Build aur Checkstyle pass hon.
- Internal compatibility names ke ilawa koi accidental user-facing Haveno branding na ho.

## Phase 1: Network identity ko upstream se alag karna

### Main kya karunga

- `DEFAULT_APP_NAME=zeroswap` verify karunga.
- Naya `P2P_NETWORK_VERSION` code mein set karunga.
- Mainnet, stagenet aur localnet data folders ko clearly separate karunga.
- Cross-network protection tests add/update karunga.
- Actual launch date ko `RELEASE_DATE` mein set karunga.
- Account-age aur starting seller limits par release date ke asar ko test karunga.
- Network identity aur future protocol-version policy document karunga.

### Aapse kya chahiye

- Naya P2P version, misal ke taur par `Z`. Main available values audit karke recommendation de sakta hoon.
- Planned mainnet launch date.
- Confirm karna ke purane local/stagenet profiles migrate karne hain ya fresh profiles use honge.

### Verification

- Unit tests for network/version selection.
- Fresh profile test on localnet and stagenet.
- Proof ke zeroswap peer upstream Haveno P2P network se mix nahi hota.
- Data-directory path test on Windows, Linux aur macOS configuration.

### Stop condition

- P2P version ya launch date approve na ho to final mainnet identity commit nahi hoga.

## Phase 2: Production mainnet build aur configuration

### Main kya karunga

- Production installer ko `XMR_MAINNET` par set karunga.
- Build guard add karunga jo production package mein `XMR_STAGENET` ya `XMR_LOCAL` milne par fail ho.
- Mainnet-specific configuration files aur safe defaults banaunga.
- Example passwords hata kar environment variables ya protected files use karwaunga.
- gRPC ko default localhost/private bind par verify karunga.
- Unsafe public binds aur disabled rate limits ke liye checks add karunga.
- Mainnet, stagenet aur localnet build commands clearly document karunga.

### Aapse kya chahiye

- Public beta mein GUI release chahiye, daemon release chahiye, ya dono.
- Launch platforms: Windows, Linux, macOS mein se kaun se officially supported honge.
- Remote API ki zaroorat hai ya sirf local GUI use hogi.

### Verification

- Production package argument test.
- Clean mainnet launcher smoke test without real funds.
- API bind/authentication tests.
- Example-secret scan.
- Installer output-name and metadata audit.

## Phase 3: Production public keys aur secret-handling system

### Main kya karunga

- Chaar roles ke public-key slots implement karunga:
  - arbitrator registration;
  - network filter;
  - public alert;
  - private notification.
- Public-key format aur duplicate/reused-key validation add karunga.
- Valid aur invalid signatures ke tests chalaunga.
- Offline key ceremony ki simple guide banaunga.
- Key inventory, backup, rotation, loss aur compromise runbooks banaunga.
- CI/repository secret scanning setup karunga.
- Private credentials ke liye environment/secrets templates banaunga.

### Aapse kya chahiye

- Har role ki production **public key**.
- Har key ka owner/custodian aur backup owner.
- Decide karna ke ek role mein ek key hogi ya multiple approved keys.

### Aapko kya share nahi karna

- Private keys.
- Wallet seeds.
- API/RPC passwords.
- Release-signing private key.

### Verification

- Correct private key se registration/signing success.
- Wrong key, reused key aur malformed key rejection.
- Secret scan clean.
- Documented recovery exercise.

### Stop condition

- Production public keys aur custody decision ke baghair mainnet release candidate nahi banega.

## Phase 4: Trade fees, addresses aur exposure limits

### Main kya karunga

- Current maker/taker fee calculations audit karunga.
- Arbitrator-assigned fee address aur global fee address modes compare karke technical recommendation dunga.
- Chune hue mode ka mainnet implementation karunga.
- Agar global mode choose hua to `getGlobalTradeFeeAddress()` implement karunga.
- Mainnet XMR address validation add/verify karunga.
- Minimum, normal, maximum aur rounding fee tests banaunga.
- Buyer-without-deposit fee case test karunga.
- Pilot trade limit aur total exposure controls implement karunga.
- Fee reconciliation report/script banaunga.

### Aapse kya chahiye

- Maker fee percentage.
- Taker fee percentage.
- Fiat/crypto ke fees same hongi ya alag.
- Fee address mode.
- Fee wallet ka public mainnet address.
- Pilot minimum/maximum trade aur total exposure limits.

### Verification

- Exact expected fee assertions.
- Invalid/stagenet address rejection.
- Completed trade fee blockchain record se match.
- Limit se zyada offer/trade safe rejection.

## Phase 5: Monero node aur seed-node deployment package

### Main kya karunga

- Private unrestricted Monero mainnet node config banaunga.
- Optional public restricted node ki separate config banaunga.
- systemd services, dedicated users, safe binds aur firewall guide banaunga.
- Strong RPC credentials ko Git se bahar load karwaunga.
- Tor v3 seed-node service templates harden karunga.
- Seed nodes ke staggered restart/update runbook banaunga.
- Node sync, block height, disk, memory aur RPC health checks banaunga.
- Primary/backup Monero node failover test scripts banaunga.
- Real onion addresses milne par `xmr_mainnet.seednodes` update karunga.

### Aapse kya chahiye

- Kam az kam teen seed-node VPS.
- Kam az kam do hosting/operator failure domains.
- VPS operating system aur access method.
- Generated Tor onion addresses.
- Private Monero RPC architecture aur network details.

### Verification

- Har onion address doosri machine se reachable.
- Fresh client har seed ke individual outage ke bawajood bootstrap kare.
- Unrestricted RPC public internet/Tor se inaccessible.
- Monero node fully synced aur height reference nodes se match.
- Service restart aur server reboot recovery pass.

### Stop condition

- Real onion addresses ke baghair placeholder seed entry remove karke release nahi ki jayegi.

## Phase 6: Arbitrator production setup

### Main kya karunga

- Mainnet arbitrator GUI aur daemon launch configs banaunga.
- Strong account/API password loading setup karunga.
- gRPC/Tor/SSH private access guide banaunga.
- Arbitrator data aur wallet backup/restore procedure banaunga.
- Registration, visibility aur restart recovery verify karunga.
- Dispute, custom award, missing deposit, extra deposit aur payout flows test karunga.
- Arbitrator incident aur handover runbook banaunga.

### Software setup ki had

- Public authorization key app mein lagi hui hai. Is key ki private key arbitrator account registration ko authorize karti hai; yeh operator ke apne account keys nahi hain.
- `scripts/deployment/run-zeroswap-arbitrator-mainnet.sh` GUI arbitrator ko mainnet aur loopback Monero RPC ke sath start karta hai.
- Har operator ko apna alag zeroswap account/data folder banana aur backup restore test karna hoga.
- Real dispute chalane ke liye operator, registered account, synced node aur human coverage ab bhi zaroori hain.

### Aapse kya chahiye

- Kam az kam do trained arbitrator operators.
- Un ke public registration keys.
- Supported languages aur coverage hours.
- Dispute policy aur human decision authority.

### Verification

- Arbitrator production-like stagenet par register ho.
- Trade ko arbitrator assign ho.
- Messages, evidence, award aur payout complete hon.
- Restart ke baad active dispute recover ho.

## Phase 7: Price providers aur update/download services

### Main kya karunga

- Default provider list ko zeroswap-approved endpoints se update karunga.
- Multiple providers aur failover behavior verify karunga.
- Stale, unavailable, manipulated aur bohat different prices par tests banaunga.
- Price freshness/deviation monitoring add karunga.
- Upstream download links ko official zeroswap URLs se replace karunga.
- Update, signature, source aur documentation endpoints configure karunga.
- Invalid update signature aur missing-download behavior test karunga.

### Aapse kya chahiye

- Kam az kam do approved price endpoint URLs, ya unhein deploy karne ke servers.
- Official domain.
- Download URL.
- Documentation URL.
- Support URL/email.

### Stop condition

- Invented ya unapproved domain/endpoint code mein add nahi hoga.

## Phase 8: Security hardening aur internal audit

### Main kya karunga

- Source aur Git history ka secret scan.
- Dependency vulnerability aur license audit.
- Bundled Monero/JDK/Tor/package-tool hashes verify karna.
- CI actions aur permissions audit/harden karna.
- Logs aur error messages mein sensitive data audit karna.
- API auth, rate limits aur network binds audit karna.
- Wallet, trade state, dispute aur persistence ke risky paths review karna.
- Disk full, forced shutdown, corrupted data, wrong clock, node restart, Tor restart aur network loss tests banana.
- Private vulnerability-reporting policy aur emergency patch runbook banana.
- Findings report ko severity, owner aur status ke sath maintain karna.

### Aapse kya chahiye

- Accepted risk ka final owner.
- External auditor ko hire/access dena.
- Private security contact address.

### Limit

- Mera internal audit independent professional audit ka replacement nahi hoga.
- Main issues fix aur retest kar sakta hoon; external audit approval third party degi.

## Phase 9: Automated trade aur recovery test suite

### Main kya karunga

- Full Gradle build aur module Checkstyle gates.
- API tests ko explicit CI job mein run karna.
- Localnet/stagenet test matrix automate karna:
  - XMR buy aur sell;
  - buyer/seller as maker/taker;
  - minimum/normal/maximum amounts;
  - enabled payment methods;
  - concurrent trades;
  - offline/reconnect behavior;
  - disputes aur payouts;
  - missing/extra deposits;
  - wrong/stale prices;
  - restart, upgrade, backup aur restore.
- Balance, deposit, mining fee aur trade-fee reconciliation checks add karna.
- Test evidence report format banana.

### Aapse kya chahiye

- Public launch ke liye enabled payment methods ki final list.
- Test accounts jo real personal information use na karein.
- Expected minimum/maximum trade limits.

### Verification

- Koi unexplained balance difference nahi.
- Koi duplicate/wrong payout nahi.
- Failed test ka written cause aur fix/retest ho.

## Phase 10: Signed release aur supply-chain pipeline

### Main kya karunga

- Protected tag se release build enforce karunga.
- Windows/Linux/macOS artifacts ka workflow banaunga, sirf approved platforms ke liye.
- SHA-256 manifest aur detached-signature steps add karunga.
- SBOM generation add karunga.
- Build provenance/attestation aur release logs preserve karunga.
- Public artifact ko download karke hash/signature/smoke test automate karunga.
- Doosri build machine par reproducibility comparison guide/workflow banaunga.
- Release notes, known issues, migration aur rollback templates banaunga.

### Aapse kya chahiye

- GPG release-signing public fingerprint aur secure signing arrangement.
- Windows code-signing certificate agar Windows supported hai.
- Apple Developer signing/notarization account agar macOS supported hai.
- GitHub protected environment aur required approvers.

### Stop condition

- Unsigned ya unverifiable installer public mainnet release nahi banega.

## Phase 11: Monitoring, backups aur incident response

### Main kya karunga

- Monero nodes, seeds, Tor, peers, arbitrators, price providers, disk, CPU, memory, clocks, domains, downloads aur backups ke health checks.
- Prometheus/Grafana ya existing monitor config, available infrastructure ke mutabiq.
- Warning/critical alert rules aur escalation fields.
- Encrypted backup scripts/templates.
- Clean-host restore instructions aur restore checklist.
- Runbooks for:
  - seed loss;
  - Monero desync;
  - Tor outage;
  - stale/wrong price;
  - stuck trade;
  - dispute surge;
  - full disk;
  - wallet damage;
  - stolen key;
  - bad release;
  - domain compromise;
  - DDoS.
- In-progress trades ko update/rollback ke waqt protect karne ka procedure.

### Aapse kya chahiye

- Monitoring server ya service.
- Alert destination, jaise email/Matrix/PagerDuty.
- On-call operators aur escalation order.
- Required uptime, recovery time aur backup-loss limits.

### Verification

- Test alert operator tak pohanche.
- Backup clean machine par restore ho.
- Server/release failure exercise pass ho.

## Phase 12: User safety documents aur legal implementation support

### Main kya karunga

- Draft terms/privacy/fee/dispute pages ke technical sections banaunga.
- Collected data ka code-based inventory banaunga.
- Seed backup, password, scam, installer verification, payment risk aur safe support guides banaunga.
- Confirmation screens par price, fee, deposit, timeout aur irreversible action visibility audit/fix karunga.
- Important warning translations ka technical consistency check karunga.

### Aapse kya chahiye

- Qualified lawyer ka approved text.
- Operating entity aur responsible contacts.
- Target countries/jurisdictions.
- Data-retention aur complaint policy.

### Limit

- Main legal advice ya legal approval nahi de sakta.
- Lawyer-approved text ko app aur website/documentation mein implement kar sakta hoon.

## Phase 13: Staged launch rehearsal

### Stage A: Private stagenet

Main complete production-like environment, trade matrix, failover, backup aur emergency exercises chalaunga. Is stage mein real XMR use nahi hoga.

### Stage B: Private mainnet canary

Main test checklist, commands, reconciliation aur stop conditions prepare karunga. Real-XMR transactions sirf aapki explicit approval, approved limits aur funded test wallets ke sath hongi.

### Stage C: Limited public beta

Main technical caps, monitoring reports, daily reconciliation template aur incident tracking provide karunga. Human support/arbitration aapki team degi.

### Stage D: Public release

Main final tag, artifacts, hashes, signatures, documentation aur technical go/no-go evidence verify karunga. Final business, legal aur launch approval aap denge.

## Recommended execution order

1. Phase 0: branding changes finish aur commit.
2. Phase 1: network identity.
3. Phase 2: production mainnet build.
4. Phase 3: public keys/secrets design.
5. Phase 4: fee policy implementation.
6. Phase 5: Monero aur seed-node deployment.
7. Phase 6: arbitrator setup.
8. Phase 7: prices/download/update endpoints.
9. Phase 8: security hardening.
10. Phase 9: automated tests.
11. Phase 10: signed release pipeline.
12. Phase 11: monitoring/backups/incidents.
13. Phase 12: user/legal documents implementation.
14. Phase 13: stagenet rehearsal aur approved staged launch.

Phase 3 se 7 ke infrastructure-dependent kaam parallel tayyar ho sakte hain, lekin Phase 8 se 13 ke launch gates tabhi close honge jab approved production inputs mil jayen.

## Aapse pehle round mein chahiye decisions

Kaam shuru karne ke liye pehle yeh decisions sab se useful hain:

1. Exact P2P network version.
2. Planned launch date.
3. Supported operating systems.
4. GUI, daemon ya dono releases.
5. Maker/taker fee percentages.
6. Fee address mode.
7. Pilot minimum, maximum aur total exposure limits.
8. Supported currencies/payment methods.
9. Official domain/download/support URLs.
10. Seed-node VPS plan aur operators.
11. Arbitrator operators aur public keys.
12. Price-provider deployment plan.

In mein se jo decisions abhi available nahi, unhein `TBD` rakha ja sakta hai. Main un se independent code audit, test automation, configuration templates aur security hardening pehle kar sakta hoon.

## Main kya nahi kar sakta

- Legal opinion ya legal approval dena.
- Independent external security auditor ka role replace karna.
- VPS, domain, Apple ya Windows developer account khareedna.
- Private keys ya wallet seeds ki physical custody lena.
- Human dispute decision karna.
- 24/7 human support/on-call dena.
- Bina explicit approval real XMR spend karna.

## Plan completion ka final result

Plan ke technical phases complete hone par repository mein yeh deliverables honge:

- isolated zeroswap network identity;
- safe mainnet build configuration;
- production public-key integration;
- approved fee logic aur limits;
- hardened node, seed aur arbitrator deployment templates;
- provider failover aur monitoring;
- security findings/fixes;
- automated trade/recovery test evidence;
- signed release pipeline;
- backup/restore aur incident runbooks;
- staged-launch evidence aur final technical go/no-go report.

Is ke bawajood public mainnet launch tabhi **GO** hoga jab external security audit, legal approval, production infrastructure, human arbitrators aur final owner sign-off bhi complete hon.
