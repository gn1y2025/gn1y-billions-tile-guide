# Release Checklist

Before public promotion, check:

```text
README.md
COMMAND_CENTER.md
START_HERE.md
QUICK_START.md
guides/windows-agent-doctor.md
guides/existing-agent-status.md
guides/create-agent.md
guides/update-identity-skill.md
guides/free-claim-copy-paste-windows.md
guides/instant-api-claim.md
scripts/windows-agent-doctor.ps1
scripts/windows-instant-free-claim.ps1
templates/proof-template.md
troubleshooting/claim-errors.md
```

---

## Required manual tests

### Test 1 — Existing agent to successful Tile claim

```text
Run Agent Doctor
-> confirm ready
-> open free-claim-copy-paste-windows.md
-> claim free Tile
-> save proof
```

### Test 2 — New agent from zero without claim

```text
create OpenClaw agent
-> run Agent Doctor
-> confirm agent / skill path
-> stop before claim
```

---

## Safety checks

Confirm docs warn about:

```text
10 USDC
amount=10000000
amount greater than 0
seed phrase
private key
kms.json
wrong DID
wrong agent address
unverified human link
```

---

## Command checks

Confirm docs include:

```text
openclaw onboard --install-daemon
openclaw gateway status
openclaw dashboard
openclaw agents add
openclaw agents list --bindings
npx clawhub@latest install verified-agent-identity
npx skills add BillionsNetwork/verified-agent-identity
node scripts/createNewEthereumIdentity.js
node scripts/getIdentities.js
node scripts/manualLinkHumanToAgent.js
scripts/buildX402Payment.js
```

---

## Final rule

Do not promote the guide as fully tested until:

```text
windows-agent-doctor.ps1 works on a real PC
windows-instant-free-claim.ps1 succeeds on one safe agent
```
