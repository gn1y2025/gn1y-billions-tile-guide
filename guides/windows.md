# Windows PowerShell Guide

Safety-first Windows guide for preparing an OpenClaw agent for the Billions AI Agentic Movie Tiles claim flow.

This guide is unofficial. It does **not** guarantee FAIAR rewards, airdrop allocation, leaderboard rewards, free tile eligibility, or any future token distribution.

Default mode: **FREE CLAIM ONLY**.

---

## Before you start

You need:

- Windows PowerShell;
- Git;
- Node.js;
- npm;
- npx;
- OpenClaw;
- an OpenClaw agent folder;
- official Billions Verified Agent Identity skill;
- verified Billions human account;
- access to the official Billions AI Agentic Movie / x402 claim flow.

Important:

- do not use a main wallet with valuable assets;
- do not paste seed phrases;
- do not paste private keys;
- do not upload `kms.json`;
- do not copy identity from another agent;
- stop if any paid amount appears while you wanted a free claim.

---

<details>
<summary><strong>Step W1 — Check required tools</strong></summary>

Run in PowerShell:

```powershell
git --version
node -v
npm -v
npx -v
openclaw --version
```

Expected result:

```text
Each command should return a version number.
```

If one command is not recognized, install the missing tool before continuing.

</details>

---

<details>
<summary><strong>Step W2 — Install Git if missing</strong></summary>

If `git --version` fails, run:

```powershell
winget install --id Git.Git -e --source winget
```

Then close PowerShell, open it again, and check:

```powershell
git --version
```

</details>

---

<details>
<summary><strong>Step W3 — Install OpenClaw</strong></summary>

Use the official OpenClaw Windows installer:

```powershell
iwr -useb https://openclaw.ai/install.ps1 | iex
```

After installation, close PowerShell, open it again, and check:

```powershell
openclaw --version
node -v
npm -v
npx -v
```

If OpenClaw onboarding did not run automatically:

```powershell
openclaw onboard --install-daemon
```

</details>

---

<details>
<summary><strong>Step W4 — Choose your OpenClaw agent folder</strong></summary>

This guide does not use fixed local paths.

Paste your own OpenClaw agent folder path when asked:

```powershell
$AGENT_ROOT = Read-Host "Paste the full path to your OpenClaw agent folder"

if (!(Test-Path $AGENT_ROOT)) {
  throw "Agent folder not found. Check the path and try again."
}

Set-Location $AGENT_ROOT

Write-Host ""
Write-Host "Using agent folder:"
Write-Host $AGENT_ROOT
Write-Host ""
```

Stop if:

- the folder does not exist;
- you are not sure this is the correct agent folder;
- this is another agent’s folder;
- you are inside a wallet/backup/browser profile folder instead of an agent folder.

</details>

---

<details>
<summary><strong>Step W5 — Create a safety backup</strong></summary>

Before changing anything, create a backup folder:

```powershell
$BACKUP_ROOT = Join-Path $AGENT_ROOT ("backup-before-tile-claim-" + (Get-Date -Format "yyyyMMdd-HHmmss"))

New-Item -ItemType Directory -Force -Path $BACKUP_ROOT | Out-Null

Write-Host "Backup folder created:"
Write-Host $BACKUP_ROOT
```

Do not upload this backup publicly.

Do not share identity files, wallet files, or `kms.json`.

</details>

---

<details>
<summary><strong>Step W6 — Install official Billions Verified Agent Identity skill</strong></summary>

From your agent folder, try:

```powershell
openclaw skills install verified-agent-identity
```

If that does not work, try:

```powershell
npx skills add BillionsNetwork/verified-agent-identity
```

Use only official Billions/OpenClaw sources.

Do not install random forks, Discord DM files, or unknown scripts.

If both commands fail, go to:

```text
troubleshooting/identity-errors.md
```

</details>

---

<details>
<summary><strong>Step W7 — Find the installed skill folder</strong></summary>

Run:

```powershell
$SKILL_DIR = Get-ChildItem -Path $AGENT_ROOT -Recurse -Directory -Filter "verified-agent-identity" -ErrorAction SilentlyContinue |
  Select-Object -First 1 -ExpandProperty FullName

if (!$SKILL_DIR) {
  throw "verified-agent-identity skill folder not found. The skill may not be installed correctly."
}

Set-Location $SKILL_DIR

Write-Host "Using skill folder:"
Write-Host $SKILL_DIR
```

Stop if the folder is not found.

Possible causes:

- wrong agent folder;
- skill was not installed;
- skill was installed in another workspace;
- OpenClaw layout is different;
- install command failed silently.

</details>

---

<details>
<summary><strong>Step W8 — Install skill dependencies</strong></summary>

Inside the skill folder, run:

```powershell
if (Test-Path "package.json") {
  npm install
} else {
  throw "package.json not found inside skill folder. Check if this is the correct skill folder."
}
```

Stop if `package.json` is missing.

Do not run `npm install` from a disk root, wrong folder, wallet folder, backup folder, or browser profile folder.

</details>

---

<details>
<summary><strong>Step W9 — Create a new agent identity</strong></summary>

Default safe method:

```powershell
node scripts/createNewEthereumIdentity.js
```

Important:

- do not use your main wallet private key;
- do not paste seed phrases;
- do not upload generated identity files;
- keep identity files private;
- back up identity files safely;
- never copy identity from another agent.

If identity creation fails, go to:

```text
troubleshooting/identity-errors.md
```

</details>

---

<details>
<summary><strong>Step W10 — Link agent to verified human</strong></summary>

Set your agent name and description:

```powershell
$AGENT_NAME = Read-Host "Agent name"
$AGENT_DESCRIPTION = Read-Host "Short agent description"

$challenge = @{
  name = $AGENT_NAME
  description = $AGENT_DESCRIPTION
} | ConvertTo-Json -Compress

node scripts/manualLinkHumanToAgent.js --challenge $challenge
```

Open the printed verification URL in your browser.

Complete the Billions human-agent linking flow.

Do not share the pairing link publicly.

If the pairing link expired, run this step again and open the new link.

</details>

---

<details>
<summary><strong>Step W11 — Verify identity status</strong></summary>

After linking, confirm:

```text
Agent identity: exists
DID: visible
Human link: verified
Agent address: visible
```

If the skill includes an identity listing script, run it and check the output.

Stop if:

- DID is missing;
- agent address is missing;
- human link is not verified;
- the identity belongs to another agent;
- you are not sure which identity is active.

</details>

---

<details>
<summary><strong>Step W12 — Prepare for free tile claim</strong></summary>

Open the official Billions AI Agentic Movie / x402 claim flow.

Before claim, check:

```text
Agent identity: correct
DID: correct
Human link: verified
Claim type: free
Expected amount: 0
```

Stop immediately if you see:

```text
10 USDC
amount=10000000
any amount greater than 0
```

That is not a free claim.

</details>

---

<details>
<summary><strong>Step W13 — Claim the free tile</strong></summary>

Use the official claim flow.

The agent may prepare the action, but the human must review before continuing.

Before final claim, check:

```text
Agent name:
Agent address:
DID:
Claim type:
Expected amount:
Canvas:
Tile coordinates if available:
```

Do not continue if:

- claim amount is not `0`;
- displayed agent address is wrong;
- displayed DID is wrong;
- website looks unofficial;
- wallet asks for seed phrase;
- wallet asks for private key;
- wallet asks for unlimited approval.

</details>

---

<details>
<summary><strong>Step W14 — Save proof after success</strong></summary>

After successful claim, save:

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
Claim type: free / paid
Date:
```

Do not share private keys, seed phrases, wallet files, or identity backup files.

</details>

---

<details>
<summary><strong>Step W15 — Final message</strong></summary>

After success, you can show:

```text
✅ Tile claim flow completed.

Save your proof:
- Tile ID
- Tx hash
- Agent address
- DID
- Canvas ID
- X/Y coordinates
- Claim date

If the gn1y guide helped you, you can optionally leave feedback or a comment in Discord/X/GitHub.

Never share seed phrases, private keys, wallet keys, or sensitive identity data.
```

</details>

---

## Stop conditions

Stop immediately if:

- a script asks for seed phrase;
- a script asks for private key;
- wallet asks for unlimited approval;
- claim amount is not `0` but you wanted free claim;
- DID does not match the intended agent;
- agent address does not match the intended agent;
- website looks unofficial;
- pairing link came from an unknown person;
- you are not sure what the next action does.

When unsure:

**STOP and ask for help.**

---

## Quick reference

Use the live website route first if you are a beginner.

Recommended beginner route:

    Open the website
    Run Windows Agent Doctor
    Follow only the route printed by Doctor

Local repo route is only for maintainers or advanced users who cloned this repository and opened a terminal in the repository root.

    .\scripts\windows-preflight.ps1

Do not copy random commands from this page unless Doctor sent you to this route.
