# FAQ

## Does this guide guarantee FAIAR rewards?

No.

This guide does not guarantee FAIAR rewards, airdrop allocation, leaderboard rewards, free tile eligibility, or any future token distribution.

## Does this guide guarantee a free tile claim?

No.

Free tile eligibility depends on Billions rules and the official claim flow.

## Can one verified human claim free tiles with many agents?

Based on support clarification:

```text
One verified human = one agent = one free tile.
```

A verified human may have multiple verified agents, but that does not mean every agent can claim a free tile.

## What if I see `10 USDC`?

Stop if you wanted a free claim.

`10 USDC` means this is a paid action.

Read:

[Paid Tile Guide](./guides/paid-tile.md)

## What if I see `amount=10000000`?

Stop if you wanted a free claim.

This may represent 10 USDC using 6 decimals.

## Should I use my main wallet?

No.

Use a separate wallet or identity key for agent activity.

## Can an AI agent do the claim for me?

An AI agent can help prepare, check, and explain steps.

The human must review critical actions.

The agent must stop before any paid claim or unclear action.

## Can I choose tile coordinates or Seed area?

Do not force coordinates manually unless the official UI explicitly allows it.

The official claim flow may assign coordinates automatically.

After a successful claim, save:

```text
Tile ID:
Canvas ID:
X:
Y:
Role:
Tx hash:
```

## What should I save after success?

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
Claim type:
Date:
```

Do not share private keys, seed phrases, wallet files, or identity backups.

## Should I post feedback for gn1y?

Optional.

If this guide helped, you can optionally leave feedback or a comment in Discord, X, or GitHub.

Do not share sensitive data.

## How do I create a new OpenClaw agent?

Start here:

[Create an OpenClaw Agent](./guides/create-agent.md)

This covers OpenClaw install, onboarding, Gateway check, Dashboard check, and `openclaw agents add`.

## What is `BILLIONS_NETWORK_MASTER_KMS_KEY`?

It is a local encryption secret for Billions identity storage.

It is not a seed phrase and not a wallet private key.

Read:

[KMS Security](./guides/kms-security.md)

## Why run `getIdentities.js` before x402?

Because the official Billions skill guardrail requires checking identity before link/sign/x402 actions.

Run:

```bash
node scripts/getIdentities.js
```

Continue only if the DID/default identity/human link belong to the intended agent.
