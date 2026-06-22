# Command Center

Start here if you are on Windows and want the shortest path.

This page gives you the main audit command.

The audit command is called:

```text
Windows Agent Doctor
```

It checks your PC and tells you what to do next.

---

## What Agent Doctor does

Agent Doctor searches for OpenClaw agent folders and checks:

```text
OpenClaw CLI
agent folder
verified-agent-identity skill
package.json
scripts/getIdentities.js
scripts/createNewEthereumIdentity.js
scripts/manualLinkHumanToAgent.js
scripts/buildX402Payment.js
DID / identity output
x402-ready status
```

It does **not**:

```text
claim Tiles
spend funds
install anything
update anything
delete anything
touch private keys manually
```

---

## Run this first

Open **PowerShell** and paste:

```powershell
irm https://raw.githubusercontent.com/gn1y2025/gn1y-billions-tile-guide/main/scripts/windows-agent-doctor.ps1 | iex
```

If you already know your exact agent folder, use the local script version after cloning, or open `scripts/windows-agent-doctor.ps1` and pass:

```powershell
-AgentRoot "FULL_PATH_TO_YOUR_AGENT_FOLDER"
```

---

## What the terminal will tell you

At the end, Agent Doctor prints one of these outcomes:

### 1. Ready for free claim

```text
READY CANDIDATE FOUND
Next file: guides/free-claim-copy-paste-windows.md
```

Then open:

[Free Claim Copy-Paste Windows](./guides/free-claim-copy-paste-windows.md)

---

### 2. Skill missing

```text
NO_IDENTITY_SKILL
Next file: guides/existing-agent-status.md
Case A1 — Skill missing
```

Then open:

[Existing Agent Status Check](./guides/existing-agent-status.md)

---

### 3. Skill outdated / not x402-ready

```text
UPDATE_SKILL_FIRST
Next file: guides/update-identity-skill.md
```

Then open:

[Update Identity Skill](./guides/update-identity-skill.md)

---

### 4. DID missing

```text
NO_DID
Next file: guides/existing-agent-status.md
Case A2 — identity missing
```

Then open:

[Existing Agent Status Check](./guides/existing-agent-status.md)

---

### 5. No agent found

Then open:

[Create an OpenClaw Agent](./guides/create-agent.md)

---

## Main rule

Do not guess.

Run Agent Doctor first, then follow the file it prints in the terminal.
