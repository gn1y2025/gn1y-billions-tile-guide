# Create an OpenClaw Agent

This guide explains how to create or identify an OpenClaw agent before using the Billions Verified Agent Identity skill and the Billions AI Agentic Movie Tiles claim flow.

This guide is unofficial. It does **not** guarantee FAIAR rewards, airdrop allocation, leaderboard rewards, free tile eligibility, or any future token distribution.

Default mode:

**FREE CLAIM ONLY**

---

## Scope

This page covers:

- installing / verifying OpenClaw runtime;
- running onboarding;
- verifying Gateway and Dashboard;
- creating a new isolated OpenClaw agent;
- identifying the correct agent workspace before installing Billions identity skill.

This page does **not** claim Tiles by itself.

For Tiles API claim, use:

[Instant API Claim](./instant-api-claim.md)

---

## Recommended runtime

Recommended baseline for this guide:

```text
Node.js 24
OpenClaw latest stable
```

OpenClaw also supports Node 22.19+, but Node 24 is the recommended baseline for this guide.

Check:

```bash
node -v
openclaw --version
```

---

## Step A1 — Install OpenClaw

### Windows PowerShell

```powershell
iwr -useb https://openclaw.ai/install.ps1 | iex
```

### Linux / macOS / WSL2

```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```

Restart terminal after installation.

---

## Step A2 — Run onboarding

OpenClaw onboarding asks for a model provider and API key.

You need an API key from a provider such as OpenAI, Anthropic, Google, Groq, OpenRouter, or another supported provider.

Run:

```bash
openclaw onboard --install-daemon
```

Then verify:

```bash
openclaw gateway status
openclaw dashboard
```

The dashboard should open in the browser.

If the dashboard opens and the agent can answer a message, the runtime is working.

---

## Step A3 — Create a new OpenClaw agent

Use a simple unique agent id.

Do not use:

- spaces;
- private information;
- seed words;
- wallet names;
- the same id for multiple people;
- `main` if you want a separate new agent.

Create agent:

```bash
openclaw agents add my-agent
```

Replace `my-agent` with your own agent id.

Examples:

```bash
openclaw agents add movie-agent
openclaw agents add x402-helper
openclaw agents add research-agent
```

Verify:

```bash
openclaw agents list --bindings
```

Restart and check gateway:

```bash
openclaw gateway restart
openclaw gateway status
```

---

## Step A4 — Find the agent workspace

OpenClaw agents have their own workspace and state.

Do not reuse one agent folder for many unrelated agents.

Do not copy identity files between agents.

If you are using OpenClaw's default layout, agent workspaces may be under your OpenClaw home folder.

Use:

```bash
openclaw agents list --bindings
```

Then open the workspace shown for your agent.

If you are not sure which folder is the correct agent workspace, stop and ask for help before installing identity skill.

---

## Step A5 — Continue to OS guide

After the agent exists and OpenClaw runtime works, continue:

- [Windows Guide](./windows.md)
- [Linux Guide](./linux.md)
- [macOS Guide](./macos.md)

Then install Billions Verified Agent Identity skill, create DID, link human, and claim Tiles safely.

---

## Stop conditions

Stop if:

- OpenClaw onboarding did not complete;
- you do not have a model provider API key;
- `openclaw gateway status` fails;
- dashboard does not open;
- you are not sure which agent workspace belongs to your agent;
- you are about to reuse another agent's identity;
- any command asks for seed phrase or private key.

When unsure:

**STOP and ask for help.**

---

## After creating the agent

After your new OpenClaw agent exists and Gateway/Dashboard work, do not jump directly to claim.

Continue here:

[Existing Agent Status Check](./existing-agent-status.md)

That page will guide you through:

```text
verify skill
create/check DID
link/check human account
prepare instant free Tile claim
```

If you are only testing agent creation, stop after Gateway/Dashboard and do not claim Tiles.

## What to choose in OpenClaw onboard

OpenClaw onboarding can show different questions depending on your operating system, existing OpenClaw config, and OpenClaw version.

If you are a beginner, do not guess. Use the safe choices below.

### Safe beginner choices

| OpenClaw onboard question | Recommended choice for this guide |
|---|---|
| Install daemon / install background service | Choose Yes or the default option. This helps OpenClaw keep the local Gateway running. |
| Gateway mode | Choose local or default. Do not configure a remote Gateway unless you understand it. |
| Gateway port | Keep the default unless OpenClaw says the port is already busy. |
| Workspace path | Keep the default unless you intentionally use a separate workspace. |
| Agent name | Use your own unique name, for example my-agent-name. Do not use main because main can be reserved/default. |
| Model provider | Choose a provider where you already have a valid API key. |
| API key | Paste only the model-provider API key. Never paste seed phrases, wallet private keys, kms.json, wallet keys, or crypto secrets. |
| Model | Choose the default model or a cheap/stable model from your provider. The Tile safety flow does not require an expensive model. |
| Web search | Skip it, keep default, or choose a key-free option. Web search is not required for the Tile claim flow. |
| Browser/web tools | Skip unless you know why you need them. Browser tools are not required for this guide. |
| Channels like Telegram, Discord, Slack, WhatsApp | Skip unless you specifically want to chat with the agent there. Channels are not required for the Tile claim flow. |
| Extra skills/tools | Do not enable random skills. For this guide, install only the verified-agent-identity skill needed for the Billions/x402 flow. |
| Anything asking for crypto secrets | Stop. Do not enter seed phrases, wallet private keys, kms.json, or wallet recovery data. |

### Simple rule

Keep defaults, skip optional integrations, use only a model-provider API key, and never paste crypto secrets.

### After onboard finishes

Do not run claim commands yet.

Run Windows Agent Doctor again and follow only the route it prints.

Finishing OpenClaw onboard does not mean the agent is ready to claim a Tile.

The agent is claim-ready only when Windows Agent Doctor confirms all of these:

- verified-agent-identity exists
- buildX402Payment.js exists
- DID / default identity exists
- READY TO CLAIM

If Doctor says identity is missing, do not claim. Open the existing-agent troubleshooting route first.

### If OpenClaw asks something not listed here

Choose the safest option:

- keep the default
- skip optional integrations
- do not enable unrelated tools
- do not enter crypto secrets
- finish setup
- run Windows Agent Doctor again

If the menu is unclear, stop and ask the community before running any claim command.

## Beginner naming example

When creating a new agent, use your own unique agent name.

Example:

    openclaw agents add my-agent-name

Replace my-agent-name with your real unique agent name.

## Pairing reminder

After creating the agent, pair it with your Billions/OpenClaw account only through the official pairing flow shown by your local setup.
Do not share private keys, seed phrases, kms.json, or sensitive identity files while pairing.
