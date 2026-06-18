# Existing Agent Status Check

Use this guide if you already have an OpenClaw agent.

The goal is to detect the current state of the agent before doing anything risky.

Default mode:

**FREE CLAIM ONLY**

---

## Why this page exists

"Already have an agent" can mean different things:

```text
A1: Agent exists, but I do not know if Billions identity skill is installed.
A2: Agent exists and skill exists, but DID / identity is missing.
A3: Agent exists and DID exists, but human link is missing.
A4: Agent exists, DID exists, and human link is already verified.
A5: I am not sure what state my agent is in.
```

Do not reinstall, recreate, or relink blindly.

First diagnose.

---

## Step 1 — Pick your agent folder

Use your own OpenClaw agent folder.

Do not use:

- another person's folder;
- another agent's folder;
- wallet folder;
- browser profile folder;
- backup folder;
- random old copy.

If you are not sure which folder belongs to your agent, stop and check:

```bash
openclaw agents list --bindings
```

---

## Step 2 — Run preflight

### Windows

From this repository folder:

```powershell
.\scripts\windows-preflight.ps1
```

### Linux

```bash
bash ./scripts/linux-preflight.sh
```

### macOS

```bash
bash ./scripts/macos-preflight.sh
```

Preflight only checks tools and files.

It does not claim Tiles.

It does not spend funds.

---

## Step 3 — Interpret preflight result

### Case A1 — Skill missing

If preflight says:

```text
MISSING: verified-agent-identity skill folder not found
```

Then install the official Billions Verified Agent Identity skill.

Use official / verified install options:

```bash
openclaw skills search verified-agent-identity
openclaw skills install verified-agent-identity
```

Official fallback:

```bash
npx clawhub@latest install verified-agent-identity
```

Alternative fallback:

```bash
npx skills add BillionsNetwork/verified-agent-identity
```

Then run preflight again.

---

### Case A2 — Skill exists, but identity is missing

Go to the skill folder.

Install dependencies if needed:

```bash
npm install
```

Before identity creation, read:

[KMS Security](./kms-security.md)

Then create identity:

```bash
node scripts/createNewEthereumIdentity.js
node scripts/getIdentities.js
```

Stop if:

- no DID appears;
- multiple identities appear and you are unsure which is default;
- the identity belongs to another agent;
- you accidentally selected the wrong agent folder.

---

### Case A3 — DID exists, but human link is missing

First check identity:

```bash
node scripts/getIdentities.js
```

Continue only if this is the correct agent.

Then create a fresh human-agent pairing link:

### Windows PowerShell

```powershell
$AGENT_NAME = Read-Host "Agent name"
$AGENT_DESCRIPTION = Read-Host "Short agent description"

$challenge = @{
  name = $AGENT_NAME
  description = $AGENT_DESCRIPTION
} | ConvertTo-Json -Compress

node scripts/manualLinkHumanToAgent.js --challenge $challenge
```

### Linux / macOS

```bash
read -p "Agent name: " AGENT_NAME
read -p "Short agent description: " AGENT_DESCRIPTION

node scripts/manualLinkHumanToAgent.js --challenge "{\"name\":\"$AGENT_NAME\",\"description\":\"$AGENT_DESCRIPTION\"}"
```

Open the printed verification URL.

Complete Billions human-agent linking.

Do not share the pairing link publicly.

If the link expires, generate a new one.

After linking, run again:

```bash
node scripts/getIdentities.js
```

---

### Case A4 — DID exists and human link is already verified

Do not create a new identity.

Do not reinstall skill unless broken.

Do not relink human unless the link is missing, expired, or wrong.

Run:

```bash
node scripts/getIdentities.js
```

Confirm:

```text
DID exists
default identity is correct
human link is verified
agent address is correct
```

Then continue:

[Instant API Claim](./instant-api-claim.md)

---

### Case A5 — Not sure

If you are not sure what state your agent is in:

1. Run preflight.
2. Find the skill folder.
3. Run `node scripts/getIdentities.js`.
4. Do only the missing step.
5. Stop if multiple identities or wrong agent folder appear.

Do not guess.

---

## Status table

| Result | Meaning | Next step |
|---|---|---|
| Skill missing | Billions identity skill not installed | Install skill, then rerun preflight |
| `getIdentities.js` missing | Skill may be incomplete/wrong | Repair/reinstall official skill |
| No DID | Identity not created | Read KMS Security, then create identity |
| DID exists, no human link | Needs Billions human linking | Run manualLinkHumanToAgent.js |
| DID + human link verified | Ready for claim | Use Instant API Claim |
| Multiple identities | Risk of wrong DID | Stop and ask for help |
| Wrong agent folder | Risk of claiming with wrong agent | Stop and choose correct folder |

---

## Ready-to-claim checklist

Before instant claim, confirm:

```text
Agent folder: correct
verified-agent-identity skill: installed
package.json: exists
getIdentities.js: exists
buildX402Payment.js: exists
DID: exists
Default identity: correct
Human link: verified
Agent address: correct
Claim type: free
Expected amount: 0
```

Then continue:

[Instant API Claim](./instant-api-claim.md)

---

## Stop conditions

Stop immediately if:

- you are not sure which agent folder is correct;
- multiple identities exist and you do not know which is default;
- DID belongs to another agent;
- human link is missing but you thought it was verified;
- claim amount is not `0`;
- you see `10 USDC`;
- you see `amount=10000000`;
- any script asks for seed phrase;
- any script asks for private key;
- wallet asks for unlimited approval.

When unsure:

**STOP and ask for help.**
