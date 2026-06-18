# Instant API Claim

One-shot safety-first API claim flow for Billions AI Agentic Movie Tiles.

This guide is unofficial. It does **not** guarantee FAIAR rewards, airdrop allocation, leaderboard rewards, free tile eligibility, or any future token distribution.

Default mode:

**FREE CLAIM ONLY**

---

## Why this section exists

When claiming Tiles from terminal, the claim can expire quickly.

During previous successful terminal claims, the claim response showed roughly:

```text
seconds left: ~297
```

That is around 5 minutes.

Because of this, users should not manually pause between:

1. API challenge request;
2. free payment/proof build;
3. claim_id extraction;
4. tile submit.

The safe approach is:

```text
Phase1 -> select free amount=0 -> Phase2 -> extract fresh claim_id -> immediately POST /api/v1/tiles
```

Do not try to reuse old claims.

Do not try to salvage expired claims.

If claim expired, run the full fresh flow again.

---

## Critical safety rules

Stop immediately if you see:

```text
10 USDC
amount=10000000
any amount greater than 0
```

That is not a free claim.

This instant script must only use:

```text
amount=0
```

The script must not approve payments.

The script must not use paid claim.

The script must not continue if only paid options are available.

---

## Required files

This flow expects the Billions Verified Agent Identity skill to be installed and to contain:

```text
buildX402Payment.js
```

The script searches inside the selected OpenClaw agent folder for:

```text
buildX402Payment.js
```

If the file is missing, install or repair the official Billions Verified Agent Identity skill first.

---


---

## Identity-first check

Before running `buildX402Payment.js`, check identities:

```powershell
node scripts/getIdentities.js
```

Continue only if:

```text
DID exists
default identity is correct
human link is verified
agent address is correct
```

Stop if the identity belongs to another agent.

---

## Experimental status

This one-shot script follows the terminal flow used in successful community claims.

Before recommending it publicly, test it on one safe agent and confirm:

```text
amount=0 selected
paid=false after submit
claim_id is fresh
no 10 USDC path used
proof JSON saved locally
```

## Windows one-shot free claim script

Run from the guide repository folder:

```powershell
.\scripts\windows-instant-free-claim.ps1
```

The script will ask for your OpenClaw agent folder.

It will:

1. search for `buildX402Payment.js`;
2. call `https://x402.billions.network/api/v1/canvas/current`;
3. find only the free `amount=0` option;
4. block paid `amount=10000000`;
5. build a fresh claim;
6. extract `claim_id`;
7. immediately submit to `https://x402.billions.network/api/v1/tiles`;
8. save proof JSON locally.

---

## Expected success output

A successful result should contain fields like:

```text
tile_id
canvas_id
coordinates / x / y
paid: false
```

Save:

```text
Agent name:
Agent address:
DID:
Tile ID:
Tx hash:
Human field:
Attestation:
Canvas ID:
X:
Y:
Placed at:
Explorer link:
Claim type: free
Date:
```

Do not publish seed phrases, private keys, wallet files, `kms.json`, or identity backups.

---

## Important note

This script is designed for free claim only.

If free claim is not available for your verified human / agent, the script must stop.

Based on support clarification:

```text
One verified human = one agent = one free tile.
```

