# Manual Test Plan

Before promoting this guide publicly, run these manual tests.

The repo can look good, but the real test is a clean beginner flow.

---

## Test 1 — Existing linked agent to free claim

Goal:

```text
existing OpenClaw agent
identity exists
human link exists
x402-ready skill exists
free Tile claim succeeds
```

Steps:

```text
1. Open COMMAND_CENTER.md.
2. Run Windows Agent Doctor.
3. Confirm Doctor says ready to claim.
4. Open guides/free-claim-copy-paste-windows.md.
5. Run the free claim command.
6. Confirm amount is exactly 0.
7. Confirm paid claim is blocked.
8. Confirm Tile claim succeeds.
9. Open guides/after-claim-proof.md.
10. Save proof.
```

Pass condition:

```text
Tile claimed
Paid: false
amount=0
proof saved
terminal shows community guide by gn1y footer
```

---

## Test 2 — New agent setup only

Goal:

```text
a beginner can create/setup an agent
but does not accidentally claim
```

Steps:

```text
1. Open COMMAND_CENTER.md.
2. If Doctor finds no agent, open guides/create-agent.md.
3. Create the agent.
4. Run Doctor again.
5. Confirm Doctor points to the correct next setup step.
6. Stop before claim.
```

Pass condition:

```text
agent created
no paid flow triggered
no claim triggered by accident
```

---

## Test 3 — Old identity skill

Goal:

```text
Doctor detects old skill and blocks claim route
```

Expected result:

```text
buildX402Payment.js missing
Doctor says skill outdated / not x402-ready
Doctor sends user to guides/update-identity-skill.md
```

Pass condition:

```text
user is not sent to claim guide
```

---

## Test 4 — Paid amount safety

Goal:

```text
claim flow stops if amount is not 0
```

Expected stop signals:

```text
10 USDC
amount=10000000
amount > 0
```

Pass condition:

```text
script stops
no paid claim submitted
```

---

## Test 5 — Privacy check

Goal:

```text
public logs are safe to share
```

Steps:

```text
1. Run Doctor.
2. Check output.
3. Confirm PRIVACY.md tells user what to redact.
4. Confirm README and COMMAND_CENTER link to PRIVACY.md.
```

Pass condition:

```text
no seed/private key/kms.json requested
privacy warnings visible
```

---

## Final release condition

Do not call the guide production-ready until:

```text
Windows Agent Doctor tested
existing agent claim tested
new agent setup tested
old skill route tested
paid amount block tested
privacy/redaction guide checked
```
