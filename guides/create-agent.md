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
