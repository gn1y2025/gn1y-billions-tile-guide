# Release Checklist

Use this before sharing the guide publicly.

---

## Required files

Check that these files exist:

```text
README.md
COMMAND_CENTER.md
START_HERE.md
QUICK_START.md
SECURITY.md
DISCLAIMER.md
PRIVACY.md
FAQ.md
TROUBLESHOOTING.md
MANUAL_TEST_PLAN.md
guides/windows-agent-doctor.md
guides/create-agent.md
guides/existing-agent-status.md
guides/update-identity-skill.md
guides/free-claim-copy-paste-windows.md
guides/after-claim-proof.md
scripts/windows-agent-doctor.ps1
scripts/windows-instant-free-claim.ps1
templates/feedback-template.md
templates/proof-template.md
```

---

## Manual tests

Run:

```text
Test 1: existing agent -> Doctor -> free claim
Test 2: new agent -> create/setup -> stop before claim
Test 3: old skill -> Doctor sends to update skill
Test 4: paid amount -> flow stops
Test 5: privacy check
```

Read:

[MANUAL_TEST_PLAN.md](./MANUAL_TEST_PLAN.md)

---

## Safety checks

Confirm the guide says to stop on:

```text
10 USDC
amount=10000000
amount > 0
wrong agent
wrong DID
wrong human link
missing buildX402Payment.js
```

Confirm the guide warns users never to share:

```text
seed phrase
private key
kms.json
API keys
unredacted logs
```

---

## Public repo requirement

Public GitHub copy-paste commands use raw GitHub URLs.

They work only when the repo is public.

While the repo is private, use local testing mode.

---

## Final release condition

Do not promote as production-ready until:

```text
Doctor tested
claim tested on one safe existing agent
new agent route tested without claim
old skill route tested
paid amount block tested
privacy/redaction checked
```
