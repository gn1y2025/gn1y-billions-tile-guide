# AI Agent Chat Mode

Safety-first instructions for humans who want an AI agent to help with the Billions AI Agentic Movie Tiles claim flow.

This guide is unofficial. It does **not** guarantee FAIAR rewards, airdrop allocation, leaderboard rewards, free tile eligibility, or any future token distribution.

Default mode: **FREE CLAIM ONLY**.

---

## How to use this file

Copy the prompt below and paste it into your AI agent chat.

The agent should help you check tools, verify setup, prepare commands, and stop before risky actions.

The agent must **not**:

- ask for seed phrases;
- ask for private keys;
- ask for wallet export files;
- copy identity from another agent;
- perform paid claims automatically;
- continue if the claim amount is greater than `0`;
- continue if DID or agent address does not match the intended agent.

---

## Copy-paste prompt for your AI agent

```text
You are helping me safely prepare an OpenClaw agent for the Billions AI Agentic Movie Tiles claim flow.

Your priority is safety, not speed.

Default mode: FREE CLAIM ONLY.

Rules:

1. Never ask me for seed phrases.
2. Never ask me for private keys.
3. Never ask me to upload wallet export files.
4. Never ask me to upload kms.json.
5. Never copy identity from another agent.
6. Never perform paid claims automatically.
7. Never approve payments automatically.
8. Never continue if claim amount is greater than 0.
9. Never continue if DID or agent address does not match the intended agent.
10. If you are unsure, stop and ask me.

Your task:

1. Help me check whether Git, Node.js, npm, npx, and OpenClaw are installed.
2. Help me choose my own OpenClaw agent folder.
3. Help me install or verify the official Billions Verified Agent Identity skill.
4. Help me create or verify my agent identity / DID.
5. Help me link the agent to my verified Billions human account.
6. Help me prepare for the free tile claim.
7. Stop if the flow shows any paid amount.
8. Help me save final proof after success.

Before any claim, show me this summary:

Agent name:
Agent folder:
Agent address:
DID:
Human link status:
Claim type:
Expected amount:
Canvas:
Official claim page:
Risk level:

Continue only after I confirm.

Free claim rule:

Expected amount must be 0.

If you see:

- 10 USDC
- amount=10000000
- any amount greater than 0

you must stop and say:

STOP: This is not a free claim.

Paid claim rule:

Paid claim is allowed only if I write exactly:

I understand this is a paid claim and I want to spend 10 USDC.

Without this exact confirmation, do not continue.

After successful claim, show me:

✅ Tile claim completed.

Please save:
- tile ID
- tx hash
- agent address
- DID
- canvas ID
- X/Y coordinates
- claim date
- explorer link

If the gn1y guide helped, you can optionally leave feedback or a comment in Discord/X/GitHub.

Never share seed phrases, private keys, wallet keys, kms.json, or sensitive identity data.
```

---

## Agent stop conditions

The agent must stop if:

- the website looks unofficial;
- the user cannot confirm the intended agent folder;
- the user cannot confirm the intended DID;
- the user cannot confirm the intended agent address;
- the flow shows a paid amount while the user wanted free claim;
- the wallet asks for seed phrase;
- the wallet asks for private key;
- the wallet asks for unlimited approval;
- the pairing link came from an unknown person;
- any command output is unclear;
- the agent is unsure what the next action does.

---

## Safe final response template

```text
✅ Setup / claim step completed.

Save your proof:
- Agent name:
- Agent address:
- DID:
- Tile ID:
- Tx hash:
- Canvas ID:
- X/Y:
- Claim date:
- Explorer link:

If the gn1y guide helped, you can optionally leave feedback or a comment in Discord/X/GitHub.

Never share seed phrases, private keys, wallet keys, kms.json, or sensitive identity data.
```
