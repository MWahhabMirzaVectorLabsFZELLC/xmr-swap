# Production Mainnet Ki Asaan Checklist

Mojooda halat: **MAINNET KE LIYE TAYYAR NAHI**
Review ki tareekh: 2026-11-02
Review kiya gaya commit: `47815100d151e152dc85e88a86725a4e9d2bb9fc`

Is file mein woh tamam zaroori kaam likhe hain jo real users ko real XMR ke sath trading dene se pehle karne hain. Jab tak har **Lazmi kaam** mukammal, test aur approve na ho, mainnet launch na karein.

Yeh checklist professional security audit aur legal mashware ki jagah nahi le sakti.

## 1. Is file mein istemal hone wale labels

- **Lazmi kaam**: is ke baghair mainnet launch nahi ho sakta.
- **Public launch se pehle**: chhote private test ke waqt yeh baad mein ho sakta hai, lekin aam users ke liye network kholne se pehle lazmi hai.

Har mukammal kaam ka saboot save karein, jaise test report, screenshot, configuration file, public URL ya approval record. Private keys, wallet seeds, passwords aur secret recovery maloomat kabhi Git mein save na karein.

## 2. Is repository mein milne wale masail

| Masla | Kya mila | Kya karna hai |
|---|---|---|
| P-01 | Mainnet seed file mein sirf `placeholder.onion:8000` hai | Asli aur test kiye hue production seed nodes add karein |
| P-02 | Arbitrator, filter, alert aur private notification ki mainnet key lists khaali hain | Production keys banayein aur sirf public keys code mein add karein |
| P-03 | Desktop installers `XMR_STAGENET` par start hote hain | Production installers ko `XMR_MAINNET` par karein aur test karein |
| P-04 | App ka naam abhi `Haveno` aur P2P network version `A` hai | Is fork ka alag app naam aur P2P network version rakhein |
| P-05 | Network release date abhi `25-05-2024` hai | Asli launch date set karke shuru ke limits test karein |
| P-06 | Deployment files stagenet aur example passwords use karti hain | Mehfooz mainnet files banayein aur passwords Git se bahar rakhein |
| P-07 | Price aur download links upstream Haveno services use karte hain | Apni services use karein ya third-party owner se ijazat lein |
| P-08 | Packaging guide ke mutabiq macOS signing mojood nahi | Signing/notarization add karein ya macOS release na dein |
| P-09 | Trade fees aur fee wallet is network ke liye approve nahi | Fee rules, wallet control, hisaab aur public fee info tay karein |
| P-10 | Review ke waqt doosri uncommitted changes mojood thin | Release sirf clean, reviewed, protected aur tagged commit se banayein |

Zaroori baat: `getGlobalTradeFeeAddress()` mainnet par fail hota hai. Jab tak arbitrators fee address choose karte hain tab yeh use nahi hota. Agar ek global fee address use karna hai to pehle is code ko implement aur test karein.

## 3. Network ka naam aur rules

- [ ] **Lazmi kaam:** Public network aur application ka naam choose karein.
- [ ] **Lazmi kaam:** Alag `DEFAULT_APP_NAME` set karein taa-ke app kisi aur Haveno installation ka data use ya kharab na kare.
- [ ] **Lazmi kaam:** Alag `P2P_NETWORK_VERSION` set karein taa-ke yeh upstream Haveno ya test network se connect na ho.
- [ ] **Lazmi kaam:** Asli `RELEASE_DATE` set karein.
- [ ] **Lazmi kaam:** Supported currencies, countries aur payment methods tay karein.
- [ ] **Lazmi kaam:** Trade limits, security deposits, confirmations, timeouts aur fees tay karein.
- [ ] **Lazmi kaam:** Tay karein ke filters, alerts, private notifications, releases aur disputes ka control kis ke paas hoga.
- [ ] **Public launch se pehle:** Users ke liye rules, risks, fees, dispute rules aur supported versions publish karein.

Saboot: approved network rules, exact code changes, clean-install tests aur yeh proof ke app kisi doosre Haveno network se connect nahi hoti.

## 4. Production keys aur secrets

- [ ] **Lazmi kaam:** Arbitrator, filter, public alert aur private notification ke liye alag production keys banayein.
- [ ] **Lazmi kaam:** Keys ek trusted offline computer par banayein.
- [ ] **Lazmi kaam:** Localnet, stagenet ya development keys mainnet par dobara use na karein.
- [ ] **Lazmi kaam:** Code ki chaar mainnet lists mein sirf public keys add karein.
- [ ] **Lazmi kaam:** Private keys, seeds, API/RPC passwords, Tor keys aur signing keys Git aur CI logs se bahar rakhein.
- [ ] **Lazmi kaam:** Secret backups encrypt karein aur access sirf zaroori logon ko dein.
- [ ] **Lazmi kaam:** Record rakhein ke har key kis ke control mein hai aur gum/chori hone par kaise badli jayegi.
- [ ] **Lazmi kaam:** Launch se pehle key recovery aur replacement test karein.
- [ ] **Lazmi kaam:** Release signing ke liye alag key aur release approval ke liye kam az kam do log rakhein.
- [ ] **Public launch se pehle:** Jahan mumkin ho hardware-protected keys use karein.

## 5. Mainnet servers

### Monero nodes

- [ ] **Lazmi kaam:** Seed nodes aur arbitrators ke liye fully synced mainnet Monero nodes chalayein.
- [ ] **Lazmi kaam:** In services ke liye local ya private unrestricted RPC nodes use karein.
- [ ] **Lazmi kaam:** Unrestricted RPC ko public internet ya public Tor address par kabhi expose na karein.
- [ ] **Lazmi kaam:** Har server ka alag strong RPC password ho aur tamam example passwords hata dein.
- [ ] **Lazmi kaam:** Bind settings aur firewall se sirf approved services ko RPC access dein.
- [ ] **Lazmi kaam:** Monero software install karne se pehle download hash verify karein.
- [ ] **Lazmi kaam:** Block height, sync status, disk space aur nodes ke disagreement ko monitor karein.
- [ ] **Lazmi kaam:** Backup nodes rakhein aur safe failover test karein.
- [ ] **Public launch se pehle:** Public restricted nodes ko private operator nodes se alag rakhein.

### Seed nodes aur Tor

- [ ] **Lazmi kaam:** Kam az kam teen production seed nodes chalayein.
- [ ] **Lazmi kaam:** Kam az kam do alag operators, hosting companies aur locations use karein.
- [ ] **Lazmi kaam:** Permanent Tor v3 addresses banayein aur identity files ka mehfooz backup rakhein.
- [ ] **Lazmi kaam:** Har onion address aur port ko doosri machine se test karein.
- [ ] **Lazmi kaam:** `xmr_mainnet.seednodes` se `placeholder.onion:8000` hata kar asli addresses dalein.
- [ ] **Lazmi kaam:** Tamam seed nodes ko ek sath restart ya update na karein.
- [ ] **Lazmi kaam:** Har seed ko alag alag offline karke naye client ka connection test karein.
- [ ] **Lazmi kaam:** Har service alag limited user aur firewall rules ke sath chalayein.
- [ ] **Lazmi kaam:** Tor, CPU, memory, disk, connections aur file limits monitor karein.
- [ ] **Lazmi kaam:** Launch se pehle seed nodes ka load test karein.

### Arbitrators

- [ ] **Lazmi kaam:** Alag systems par kam az kam do trained arbitrators hon. Chhota private test ek arbitrator ke sath sirf formally approved risk aur limits par ho sakta hai.
- [ ] **Lazmi kaam:** Har approved arbitrator ko production network par register karein.
- [ ] **Lazmi kaam:** Disputes, messages, custom awards, payouts, restarts, missing deposits aur extra deposits test karein.
- [ ] **Lazmi kaam:** Har arbitrator ko private unrestricted Monero node aur encrypted backups dein.
- [ ] **Lazmi kaam:** Strong app password aur safe admin access use karein.
- [ ] **Lazmi kaam:** Agar gRPC use ho to strong API password lagayein aur localhost ya protected private network par bind karein.
- [ ] **Lazmi kaam:** Login rate limits on rakhein. API access ka matlab poore wallet ka access hai.

### Prices, downloads aur support

- [ ] **Lazmi kaam:** Alag systems par kam az kam do reliable price-service endpoints use karein.
- [ ] **Lazmi kaam:** Missing, late, ghalat aur bohat mukhtalif prices ka behavior test karein.
- [ ] **Lazmi kaam:** Upstream price services badlein, jab tak un ke owners production use approve na karein.
- [ ] **Lazmi kaam:** Source code, installers, signatures, documents aur update files reliable servers par host karein.
- [ ] **Lazmi kaam:** Tamam `haveno.exchange/downloads` links ko apne download address se badlein.
- [ ] **Public launch se pehle:** Public status page aur safe support channels dein.

## 6. Fees aur paison ka control

- [ ] **Lazmi kaam:** Tay karein fee addresses arbitrators choose karenge ya poora network ek global address use karega.
- [ ] **Lazmi kaam:** Chune hue method ko mainnet par implement aur test karein.
- [ ] **Lazmi kaam:** Har fee address ko alag se verify karein ke woh valid Monero mainnet address hai.
- [ ] **Lazmi kaam:** Shared funds ko multisig ya multi-person approval se protect karein.
- [ ] **Lazmi kaam:** Users ke trade se pehle maker aur taker fees publish karein.
- [ ] **Lazmi kaam:** Minimum, normal aur maximum trades par fees aur rounding test karein.
- [ ] **Lazmi kaam:** Jama fees ko trades aur blockchain transactions se match karein.
- [ ] **Lazmi kaam:** Chhoti trade aur total network limits se shuru karein; successful tests ke baad ahista barhayein.
- [ ] **Public launch se pehle:** Operating funds aur trade fees alag rakhein.

## 7. Security

- [ ] **Lazmi kaam:** Release sirf clean aur reviewed Git tag se banayein.
- [ ] **Lazmi kaam:** Crypto wallets aur trading systems ka tajurba rakhne wali independent team se audit karwayein.
- [ ] **Lazmi kaam:** Audit mein multisig, deposits, payouts, disputes, wallets, RPC, passwords, P2P, Tor, updates aur saved user data shamil hon.
- [ ] **Lazmi kaam:** Tamam critical aur high-risk issues fix karke dobara check karwayein.
- [ ] **Lazmi kaam:** Code, dependencies, installers aur CI ko security issues, malware aur leaked secrets ke liye scan karein.
- [ ] **Lazmi kaam:** Libraries, Monero, JDK, Tor aur packaging tools ke licenses aur hashes check karein.
- [ ] **Lazmi kaam:** CI/release accounts protect karein aur do logon ka approval lazmi rakhein.
- [ ] **Lazmi kaam:** Logs mein seeds, keys, passwords, payment details, chat ya sensitive RPC data na aaye.
- [ ] **Lazmi kaam:** Force close, broken files, full disk, ghalat clock, Tor/Monero restart, network loss aur blockchain reorganization test karein.
- [ ] **Lazmi kaam:** Private security-reporting channel aur emergency fix plan banayein.
- [ ] **Public launch se pehle:** Long load tests aur invalid input tests chalayein.

## 8. Lazmi tests

Har test ka command, commit, computer setup, tareekh, result aur report record karein.

- [ ] **Lazmi kaam:** `./gradlew clean build` pass ho.
- [ ] **Lazmi kaam:** Changed Java modules par `checkstyleMain` aur `checkstyleTest` pass hon.
- [ ] **Lazmi kaam:** `./gradlew :apitest:test -DrunApiTests=true` se API tests pass hon.
- [ ] **Lazmi kaam:** Neeche diye gaye tamam trade tests production jaisi setup ke sath stagenet par karein.
- [ ] **Lazmi kaam:** Do users aur ek arbitrator ke sath bohat chhoti real-XMR amount ka private mainnet test karein.
- [ ] **Lazmi kaam:** Har supported system par install, upgrade, uninstall, backup, restore aur rollback test karein.
- [ ] **Lazmi kaam:** Har public installer download karke us ka hash aur signature verify karein.
- [ ] **Lazmi kaam:** Doosri trusted machine par same release build karke results compare karein.
- [ ] **Public launch se pehle:** Kam az kam saat din system chala kar failures aur restarts test karein.

| Trade test | Kya check karna hai |
|---|---|
| XMR buy aur sell | Offer, deposit, confirmation, payment, payout, balance aur fee |
| Buyer/seller as maker/taker | Charon role combinations |
| Har enabled payment type | Normal trade, validation aur limits |
| Minimum, normal aur maximum amounts | Rounding, deposit, mining fee, trade fee aur total |
| Ek sath kai trades | Koi lost message, duplicate payout ya stuck wallet na ho |
| User, Tor ya server offline | Reconnect, resend aur timeout behavior |
| Payment dispute | Dispute, proof/chat, decision aur payout |
| Missing ya extra deposit | Safe rejection ya theek custom award |
| Ghalat price ya blockchain reorganization | Ghalat payout ke baghair safe pause aur recovery |
| Software upgrade | Wallets, trades, offers, keys aur saved data theek rahen |

Balance mein koi bhi unexplained difference qabool nahi.

## 9. Installers aur releases

- [ ] **Lazmi kaam:** Packaging ko `XMR_STAGENET` se `XMR_MAINNET` par karein.
- [ ] **Lazmi kaam:** Production build mein stagenet/localnet setting mile to build automatic fail ho.
- [ ] **Lazmi kaam:** Product name, version, icons, publisher, app ID, data folder, website, repository, download URL aur support URL update karein.
- [ ] **Lazmi kaam:** Windows installers sign karein.
- [ ] **Lazmi kaam:** macOS support ho to installers sign aur notarize karein. Users ko OS warning bypass karne ko na kahen.
- [ ] **Lazmi kaam:** Linux packages sign karein aur hashes publish karein.
- [ ] **Lazmi kaam:** Hashes, signatures, signing-key fingerprint, source tag, build steps, release notes, known problems aur rollback steps publish karein.
- [ ] **Lazmi kaam:** SBOM publish karein, yani release mein shamil software libraries ki list.
- [ ] **Lazmi kaam:** Confirm karein ke public source tag shipped app se match karta hai.
- [ ] **Lazmi kaam:** Alerts aur forced updates ko stagenet par wrong signatures aur rollback ke sath test karein.
- [ ] **Public launch se pehle:** Independent team se release build aur verify karwayein.

## 10. Monitoring, backups aur emergencies

- [ ] **Lazmi kaam:** Seeds, Tor, peers, Monero sync, wallet RPC, arbitrators, prices, CPU, memory, disk, clocks, domains, backups aur downloads monitor karein.
- [ ] **Lazmi kaam:** Important alert us shakhs ko mile jo kisi bhi waqt response de sake.
- [ ] **Lazmi kaam:** Har important service ke uptime aur response-time targets likhein.
- [ ] **Lazmi kaam:** Zaroori configuration, Tor identity, app data aur operator wallet material ke encrypted backups rakhein.
- [ ] **Lazmi kaam:** Launch se pehle har backup ko clean machine par restore karke test karein.
- [ ] **Lazmi kaam:** Seed loss, Tor failure, wrong price, stuck trade, wallet damage, full disk, stolen key, bad release, domain theft aur attack ke guides banayein.
- [ ] **Lazmi kaam:** Tay karein emergency ka lead kaun hoga aur alert, limit kam, release stop ya key replace kaun kar sakta hai.
- [ ] **Lazmi kaam:** Update ya emergency ke waqt chalti hui trades ko protect karne ka plan ho.
- [ ] **Public launch se pehle:** Poori team ke sath emergency plans practice karein.

## 11. User safety aur legal kaam

- [ ] **Lazmi kaam:** Team, servers, arbitrators, fees aur target users se related countries ke liye qualified lawyer hire karein.
- [ ] **Lazmi kaam:** Exchange rules, money-service rules, sanctions, applicable AML duties, tax, privacy, consumer protection, software distribution aur dispute responsibility check karein.
- [ ] **Lazmi kaam:** Tay karein project aur important services ko legally kaun operate karta hai.
- [ ] **Lazmi kaam:** Terms, privacy notice, fees, prohibited-use rules, dispute rules, complaint contact aur data-retention rules publish karein.
- [ ] **Lazmi kaam:** Batayein user ka konsa data collect hota hai, kyun, kaun dekh sakta hai, kaise protect aur kab delete hota hai.
- [ ] **Lazmi kaam:** Seed backup, passwords, scams, installer verification, node choice, payment risks aur safe support ki simple guides publish karein.
- [ ] **Lazmi kaam:** Confirmation se pehle price, fees, deposit, confirmations, timeout, dispute result aur irreversible actions saaf dikhayein.
- [ ] **Public launch se pehle:** Har supported translation mein important warnings check karein.

## 12. Safe launch ke stages

### Stage 1: Private stagenet

Sirf test XMR use karein. Server, keys, release, trade, backup aur emergency tests mukammal karein.

### Stage 2: Private mainnet test

Trusted testers, bohat chhoti real-XMR amounts aur sakht limits use karein. Developers, server operators aur arbitrators available rahen.

Unexplained balance, wrong/missing payout, wallet problem, network split, unsigned installer, wrong price, failed monitoring ya uncertain production key par test foran rok dein.

### Stage 3: Limited public beta

Kam users aur chhoti limits ke sath kholein. Roz trades, disputes, payouts, fees, servers, support aur security reports review karein.

### Stage 4: Public release

Beta stable hone aur tamam **Public launch se pehle** wale kaam mukammal hone ke baad hi poora launch karein. Limits manually aur ahista barhayein.

Agla stage shuru karne se pehle:

- Har trade aur fee blockchain aur app records se match kare.
- Koi unexplained loss, wrong/duplicate payout, network split ya open critical/high issue na ho.
- Server failure, backup restore, monitoring, alert aur release recovery tests pass hon.
- Har failed trade/incident ki written wajah aur fix ho, ya temporary risk clearly approve ho.
- Product, security, operations, arbitrator, release aur legal owners approval dein.

## 13. Final launch decision

Mainnet sirf tab launch ho jab har jawab yes ho:

- [ ] Har **Lazmi kaam** ka saboot ho aur doosre shakhs ne check kiya ho.
- [ ] P-01 se P-10 tak tamam masail final release mein fix hon.
- [ ] Final Git tag protected, repository clean aur tamam checks pass hon.
- [ ] Public installers download karke independently verify kiye gaye hon.
- [ ] Nodes, seeds, arbitrators, prices, downloads, monitoring, backups aur support kaam kar rahe hon.
- [ ] Private real-XMR test pass ho aur tamam paisa theek match kare.
- [ ] Security audit complete aur tamam critical/high issues close hon.
- [ ] Legal review complete ho.
- [ ] User guides, terms, privacy, risks, support aur status pages public hon.
- [ ] Emergency/rollback ke waqt chalti trades ka safe plan ho.
- [ ] Launch owner ne version, commit, hashes, signatures, limits aur launch time approve kiya ho.

Agar koi lazmi kaam baad mein toot jaye to status dobara **MAINNET KE LIYE TAYYAR NAHI** hoga jab tak woh fix aur retest na ho.

## 14. Saboot aur approval table

| Requirement | Zimmedar shakhs | Saboot/report | Version | Check karne wala | Tareekh | Result |
|---|---|---|---|---|---|---|
| Misal: build test |  |  |  |  |  |  |

| Final release ki info | Value |
|---|---|
| Release version aur tag |  |
| Git commit |  |
| Installer hash file |  |
| Signing-key fingerprint |  |
| Private-test limits |  |
| UTC launch time |  |
| Emergency aur rollback guide |  |

| Approval role | Naam | Approve/reject | Tareekh | Saboot/signature |
|---|---|---|---|---|
| Product/network owner |  |  |  |  |
| Security owner |  |  |  |  |
| Server operations owner |  |  |  |  |
| Release owner |  |  |  |  |
| Lead arbitrator |  |  |  |  |
| Legal reviewer |  |  |  |  |
| Final launch owner |  |  |  |  |

## 15. Repository ki important files

- `docs/create-mainnet.md`: upstream mainnet setup guide
- `docs/deployment-guide.md`: upstream server aur operator guide
- `docs/trade_protocol/trade-protocol.md`: trade protocol ki tafseel
- `desktop/package/README.md`: installer build guide
- `core/src/main/resources/xmr_mainnet.seednodes`: mainnet seed list
- `core/src/main/java/haveno/core/trade/HavenoUtils.java`: release date, fees aur fee addresses
- `common/src/main/java/haveno/common/app/Version.java`: P2P network version
- `core/src/main/java/haveno/core/app/HavenoExecutable.java`: app name aur data folder
- `core/src/main/java/haveno/core/provider/ProvidersRepository.java`: default price services
- `scripts/deployment`: current examples; yeh production mainnet ke liye tayyar nahi
