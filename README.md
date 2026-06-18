# gn1y Billions AI Agentic Movie Tile Guide

Safety-first community guide for OpenClaw agents and Billions AI Agentic Movie Tiles.

This guide is unofficial. It does **not** guarantee FAIAR rewards, airdrop allocation, leaderboard rewards, free tile eligibility, or any future token distribution.

## Start here

Open:

[START_HERE.md](./START_HERE.md)

That file gives you the correct route:

```text
Route A: I already have an OpenClaw agent
Route B: I need to create an OpenClaw agent from zero
Route C: My agent already has identity + human link and I want to claim Tiles
```

## Main goal

This repository helps with two practical flows:

### Flow 1 — Existing agent to successful Tiles claim

```text
existing OpenClaw agent
-> check current state
-> verify Billions identity skill
-> verify DID / identity
-> verify human link
-> run instant free API claim
-> save proof
```

### Flow 2 — New agent from zero

```text
install OpenClaw
-> run onboarding
-> add model provider API key
-> create OpenClaw agent
-> check Gateway / Dashboard
-> continue to existing-agent status check
```

## Default mode

**FREE CLAIM ONLY**

The instant API claim flow is designed for:

```text
amount=0 only
```

Stop immediately if you see:

```text
10 USDC
amount=10000000
any amount greater than 0
```

## Main route files

- [Start Here](./START_HERE.md)
- [Existing Agent Status Check](./guides/existing-agent-status.md)
- [Create an OpenClaw Agent](./guides/create-agent.md)
- [Instant API Claim](./guides/instant-api-claim.md)
- [KMS Security](./guides/kms-security.md)
- [Windows Guide](./guides/windows.md)
- [Linux Guide](./guides/linux.md)
- [macOS Guide](./guides/macos.md)
- [Paid Tile Guide](./guides/paid-tile.md)
- [Troubleshooting](./TROUBLESHOOTING.md)

## Important rules

Do not share:

- seed phrase;
- private key;
- wallet export;
- `kms.json`;
- identity backup files;
- browser profile data;
- full screenshots with sensitive wallet/account data.

This guide is not for bypassing Billions rules, farming identities, or abusing free tile limits.

Based on support clarification:

> One verified human = one agent = one free tile.

## Repository map

```text
README.md
START_HERE.md
QUICK_START.md
SECURITY.md
DISCLAIMER.md
FAQ.md
RELEASE_CHECKLIST.md
TROUBLESHOOTING.md
.nvmrc

guides/
  existing-agent-status.md
  create-agent.md
  instant-api-claim.md
  kms-security.md
  windows.md
  linux.md
  macos.md
  agent-chat-mode.md
  paid-tile.md

scripts/
  windows-preflight.ps1
  linux-preflight.sh
  macos-preflight.sh
  windows-instant-free-claim.ps1

troubleshooting/
  windows-errors.md
  identity-errors.md
  pairing-errors.md
  claim-errors.md
  paid-claim-safety.md

templates/
  proof-template.md
  feedback-template.md
  support-question-template.md
```

## Scope note

This repository focuses on:

```text
OpenClaw agent
+ Billions Verified Agent Identity
+ human-agent link
+ Tiles claim preparation / instant free claim
```

It does not fully document ERC-8004 / 8004scan registration or custom x402 server/client SDK integration.

## Credits

Community guide by **gn1y**.
