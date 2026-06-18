# Start Here

This is the main entry point for the gn1y Billions AI Agentic Movie Tile Guide.

Default mode:

**FREE CLAIM ONLY**

This guide is for two main users:

1. You already have an OpenClaw agent.
2. You do not have an agent yet and want to create one from zero.

---

## Choose your route

### Route A — I already have an OpenClaw agent

Start here:

[Existing Agent Status Check](./guides/existing-agent-status.md)

Use this route if:

- you already created an OpenClaw agent;
- you are not sure if Billions identity skill is installed;
- you are not sure if the agent has DID / identity;
- you are not sure if the agent is linked to your Billions human account;
- you already linked the agent before and only want to claim Tiles safely.

Important:

Do **not** reinstall skill, create new identity, or relink human blindly.

First diagnose the current agent state.

---

### Route B — I do not have an agent yet

Start here:

[Create an OpenClaw Agent](./guides/create-agent.md)

Then continue here:

[Existing Agent Status Check](./guides/existing-agent-status.md)

Use this route if:

- you are starting from zero;
- you need to install OpenClaw;
- you need to complete onboarding;
- you need to add a model provider API key;
- you need to create a new OpenClaw agent;
- you want to verify Gateway and Dashboard before Billions identity / Tiles.

After the agent is created, it becomes Route A.

---

### Route C — My agent already has identity + human link

Start here:

[Existing Agent Status Check](./guides/existing-agent-status.md)

Then continue here:

[Instant API Claim](./guides/instant-api-claim.md)

Use this route if:

- verified-agent-identity skill is already installed;
- DID / default identity exists;
- human link is already verified;
- agent address is correct;
- you only want to claim a free Tile safely.

Before claim, always run:

```bash
node scripts/getIdentities.js
```

Continue only if the DID/default identity/human link belong to the intended agent.

---

## Fast decision tree

```text
Do you already have an OpenClaw agent?

NO:
  1. Open guides/create-agent.md
  2. Install OpenClaw
  3. Run onboarding
  4. Add model provider API key
  5. Create agent
  6. Check gateway/dashboard
  7. Continue to guides/existing-agent-status.md

YES:
  1. Open guides/existing-agent-status.md
  2. Run preflight
  3. Check verified-agent-identity skill
  4. Run getIdentities.js
  5. Only do missing steps
  6. Continue to instant free claim only when ready

READY AGENT:
  1. Confirm DID/default identity/human link
  2. Open guides/instant-api-claim.md
  3. Run one-shot free claim
  4. Save proof
```

---

## Stop immediately if you see

```text
10 USDC
amount=10000000
any amount greater than 0
seed phrase request
private key request
wrong DID
wrong agent address
unverified human link
unknown pairing link
```

---

## Main files

- [Create an OpenClaw Agent](./guides/create-agent.md)
- [Existing Agent Status Check](./guides/existing-agent-status.md)
- [Instant API Claim](./guides/instant-api-claim.md)
- [KMS Security](./guides/kms-security.md)
- [Windows Guide](./guides/windows.md)
- [Linux Guide](./guides/linux.md)
- [macOS Guide](./guides/macos.md)
- [Paid Tile Guide](./guides/paid-tile.md)
- [Troubleshooting](./TROUBLESHOOTING.md)
- [Release Checklist](./RELEASE_CHECKLIST.md)

---

## Personal test plan before public release

Before promoting this guide publicly, test two flows:

### Test 1 — Existing agent to successful Tile claim

Use an already-created safe agent.

Goal:

```text
existing agent -> identity check -> human link check -> instant free claim -> proof saved
```

### Test 2 — New agent from zero without Tiles claim

Create a new safe test agent.

Goal:

```text
install/openclaw check -> onboarding -> create agent -> gateway/dashboard -> identity skill check
```

Do not claim Tile in Test 2 unless intentionally testing a real claim.
