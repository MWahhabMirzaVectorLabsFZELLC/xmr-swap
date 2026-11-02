# zeroswap Mainnet GO/NO-GO

Current result: **NO-GO**

## Repository controls

- [x] User-facing zeroswap branding
- [x] Separate P2P version `Z`
- [x] Planned release date configured
- [x] Production installer set to `XMR_MAINNET`
- [x] Installer network guard and P2P tests
- [x] Local-only API default and secret-free examples
- [x] Operations, recovery, incident, and staged-launch guidance
- [x] Automated readiness gate

## Blocking production inputs

- [ ] Real mainnet seed onion addresses verified from another host
- [ ] Four production public-key role lists populated and independently checked
- [ ] Two or more approved price providers deployed and monitored
- [ ] Arbitrators registered, trained, backed up, and tested
- [ ] Fee policy and pilot exposure caps approved by the owner
- [ ] Official domain, downloads, docs, support, and security contacts live
- [ ] External security audit findings closed or formally accepted
- [ ] Dependency/license/SBOM report reviewed for the release commit
- [ ] GPG signature and platform code signing verified
- [ ] Monitoring alerts and clean-host restore exercise passed
- [ ] Lawyer-approved terms/privacy/dispute/retention text published
- [ ] Complete stagenet evidence passed without unexplained balance differences
- [ ] Explicit approval for a limited real-XMR canary

No checkbox may be waived silently. The owner, security reviewer, operations lead, and release approver must record their name, date, evidence link, and accepted risks before changing the result to **GO**.
