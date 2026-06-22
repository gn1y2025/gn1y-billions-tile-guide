# gn1y Billions AI Agentic Movie Tile Guide

Safety-first community guide for OpenClaw agents and Billions AI Agentic Movie Tiles.

This guide is unofficial. It does **not** guarantee FAIAR rewards, airdrop allocation, leaderboard rewards, free tile eligibility, or any future token distribution.

---

## Start here

Open:

[COMMAND_CENTER.md](./COMMAND_CENTER.md)

The first step is:

```text
Run Windows Agent Doctor
```

Agent Doctor checks your PC and tells you what file to open next.

---

## Main flow

```text
README
-> COMMAND_CENTER
-> Windows Agent Doctor
-> terminal result
-> correct next guide file
```

---

## What Agent Doctor can tell you

```text
No agent found
-> guides/create-agent.md

Agent found, no identity skill
-> guides/existing-agent-status.md Case A1

Agent found, old/broken identity skill
-> guides/update-identity-skill.md

Agent found, skill OK, no DID
-> guides/existing-agent-status.md Case A2

Agent found, DID OK, human link needs check
-> guides/existing-agent-status.md Case A3

Agent found, DID OK, x402-ready
-> guides/free-claim-copy-paste-windows.md
```

---

## Main files

- [Command Center](./COMMAND_CENTER.md)
- [Start Here](./START_HERE.md)
- [Windows Agent Doctor](./guides/windows-agent-doctor.md)
- [Existing Agent Status Check](./guides/existing-agent-status.md)
- [Create an OpenClaw Agent](./guides/create-agent.md)
- [Update Identity Skill](./guides/update-identity-skill.md)
- [Free Claim Copy-Paste Windows](./guides/free-claim-copy-paste-windows.md)
- [Instant API Claim](./guides/instant-api-claim.md)
- [KMS Security](./guides/kms-security.md)
- [Paid Tile Guide](./guides/paid-tile.md)
- [Troubleshooting](./TROUBLESHOOTING.md)

---

## Default mode

```text
FREE CLAIM ONLY
```

Stop immediately if you see:

```text
10 USDC
amount=10000000
any amount greater than 0
wrong DID
wrong agent address
unverified human link
seed phrase request
private key request
```

---

## Repository map

```text
COMMAND_CENTER.md
README.md
START_HERE.md
QUICK_START.md
SECURITY.md
DISCLAIMER.md
FAQ.md
RELEASE_CHECKLIST.md
TROUBLESHOOTING.md

guides/
  windows-agent-doctor.md
  existing-agent-status.md
  create-agent.md
  update-identity-skill.md
  free-claim-copy-paste-windows.md
  instant-api-claim.md
  kms-security.md
  windows.md
  linux.md
  macos.md
  agent-chat-mode.md
  paid-tile.md

scripts/
  windows-agent-doctor.ps1
  windows-preflight.ps1
  windows-instant-free-claim.ps1
  linux-preflight.sh
  macos-preflight.sh

templates/
  proof-template.md
  feedback-template.md
  support-question-template.md

troubleshooting/
  windows-errors.md
  identity-errors.md
  pairing-errors.md
  claim-errors.md
  paid-claim-safety.md
```

---

## Scope

This repository focuses on:

```text
OpenClaw agent
+ Billions Verified Agent Identity
+ human-agent link
+ x402-ready skill check
+ free Tiles claim preparation
```

It does not fully document ERC-8004 / 8004scan registration or custom x402 server/client SDK integration.

---

Community guide by **gn1y**.
