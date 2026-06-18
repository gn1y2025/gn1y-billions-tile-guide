# gn1y Billions AI Agentic Movie Tile Guide

Safety-first community guide for verified human-backed OpenClaw agents who want to claim Billions AI Agentic Movie Tiles.

This guide is unofficial. It does **not** guarantee FAIAR rewards, airdrop allocation, leaderboard rewards, free tile eligibility, or any future token distribution.

## Start here

- [Quick Start](./QUICK_START.md)
- [Create an OpenClaw Agent](./guides/create-agent.md)
- [KMS Security](./guides/kms-security.md)
- [Security](./SECURITY.md)
- [Windows Guide](./guides/windows.md)
- [Linux Guide](./guides/linux.md)
- [macOS Guide](./guides/macos.md)
- [AI Agent Chat Mode](./guides/agent-chat-mode.md)
- [Paid Tile Guide](./guides/paid-tile.md)
- [Instant API Claim](./guides/instant-api-claim.md)
- [Troubleshooting](./TROUBLESHOOTING.md)
- [FAQ](./FAQ.md)
- [Disclaimer](./DISCLAIMER.md)
- [Release Checklist](./RELEASE_CHECKLIST.md)

## Default mode

**FREE CLAIM ONLY**

Paid tile claim is optional and spends real funds.

## Tested baseline

Recommended baseline for this guide:

```text
Node.js 24
OpenClaw latest stable
Billions Verified Agent Identity skill
```

Node 22.19+ may work, but Node 24 is the recommended baseline.

## What this guide helps with

This guide helps users and AI agents safely:

- install and verify OpenClaw;
- run OpenClaw onboarding;
- check Gateway and Dashboard;
- create or identify an OpenClaw agent;
- install or verify the official Billions Verified Agent Identity skill;
- configure KMS security for Billions identity storage;
- create or verify an agent identity / DID;
- check identities before link/sign/x402 actions;
- link an agent to a verified Billions human account;
- prepare for the official Billions AI Agentic Movie / x402 claim flow;
- run an experimental one-shot free API claim flow;
- stop before accidental paid claims;
- save proof after a successful claim;
- troubleshoot common setup, identity, pairing, and claim errors.

## Repository structure

```text
README.md
QUICK_START.md
SECURITY.md
DISCLAIMER.md
FAQ.md
RELEASE_CHECKLIST.md
.nvmrc

guides/
  create-agent.md
  kms-security.md
  windows.md
  linux.md
  macos.md
  agent-chat-mode.md
  paid-tile.md
  instant-api-claim.md

troubleshooting/
  windows-errors.md
  identity-errors.md
  pairing-errors.md
  claim-errors.md
  paid-claim-safety.md

scripts/
  windows-preflight.ps1
  linux-preflight.sh
  macos-preflight.sh
  windows-instant-free-claim.ps1

templates/
  proof-template.md
  feedback-template.md
  support-question-template.md
```

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

## x402 / API claim note

The instant API claim script is designed for:

```text
FREE CLAIM ONLY
amount=0 only
```

It must stop on:

```text
10 USDC
amount=10000000
any amount greater than 0
```

The script reflects community-tested terminal flow behavior, including the short claim expiry window observed during successful agent claims.

## Scope note

This repository focuses on OpenClaw + Billions identity + Tiles claim preparation.

It does not fully document ERC-8004 / 8004scan registration or custom x402 server/client SDK integration.

For custom x402 provider/client development, use official Billions x402 Human Proof documentation and repositories.

## Credits

Community guide by **gn1y**.
