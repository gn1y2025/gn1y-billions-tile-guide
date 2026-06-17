# Linux Guide

Safety-first Linux Terminal guide for preparing an OpenClaw agent for the Billions AI Agentic Movie Tiles claim flow.

This guide is unofficial. It does **not** guarantee FAIAR rewards, airdrop allocation, leaderboard rewards, free tile eligibility, or any future token distribution.

Default mode: **FREE CLAIM ONLY**.

---

## Before you start

You need:

- Linux terminal;
- Git;
- curl;
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
<summary><strong>Step L1 — Check required tools</strong></summary>

Run in Terminal:

```bash
git --version
curl --version
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
<summary><strong>Step L2 — Install Git and curl if missing</strong></summary>

Ubuntu / Debian:

```bash
sudo apt update
sudo apt install -y git curl ca-certificates
```

Fedora:

```bash
sudo dnf install -y git curl ca-certificates
```

Arch:

```bash
sudo pacman -Syu git curl ca-certificates
```

After installation, check:

```bash
git --version
curl --version
```

</details>

---

<details>
<summary><strong>Step L3 — Install OpenClaw</strong></summary>

Use the official OpenClaw Linux/macOS installer:

```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```

Restart your terminal, then check:

```bash
openclaw --version
node -v
npm -v
npx -v
```

If OpenClaw onboarding did not run automatically:

```bash
openclaw onboard --install-daemon
```

</details>

---

<details>
<summary><strong>Step L4 — Choose your OpenClaw agent folder</strong></summary>

This guide does not use fixed local paths.

Paste your own OpenClaw agent folder path when asked:

```bash
read -p "Paste the full path to your OpenClaw agent folder: " AGENT_ROOT

cd "$AGENT_ROOT" || {
  echo "Agent folder not found. Check the path and try again."
  exit 1
}

echo ""
echo "Using agent folder:"
pwd
echo ""
```

Stop if:

- the folder does not exist;
- you are not sure this is the correct agent folder;
- this is another agent’s folder;
- you are inside a wallet/backup/browser profile folder instead of an agent folder.

</details>

---

<details>
<summary><strong>Step L5 — Create a safety backup</strong></summary>

Before changing anything, create a backup folder:

```bash
BACKUP_ROOT="$AGENT_ROOT/backup-before-tile-claim-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_ROOT"

echo "Backup folder created:"
echo "$BACKUP_ROOT"
```

Do not upload this backup publicly.

Do not share identity files, wallet files, or `kms.json`.

</details>

---

<details>
<summary><strong>Step L6 — Install official Billions Verified Agent Identity skill</strong></summary>

From your agent folder, try:

```bash
npx openclaw skills install identity
```

If that does not work, try:

```bash
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
<summary><strong>Step L7 — Find the installed skill folder</strong></summary>

Run:

```bash
SKILL_DIR=$(find "$AGENT_ROOT" -type d -name "verified-agent-identity" -print -quit)

if [ -z "$SKILL_DIR" ]; then
  echo "verified-agent-identity skill folder not found. The skill may not be installed correctly."
  exit 1
fi

cd "$SKILL_DIR" || exit 1

echo "Using skill folder:"
pwd
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
<summary><strong>Step L8 — Install skill dependencies</strong></summary>

Inside the skill folder, run:

```bash
if [ -f "package.json" ]; then
  npm install
else
  echo "package.json not found inside skill folder. Check if this is the correct skill folder."
  exit 1
fi
```

Stop if `package.json` is missing.

Do not run `npm install` from a disk root, wrong folder, wallet folder, backup folder, or browser profile folder.

</details>

---

<details>
<summary><strong>Step L9 — Create a new agent identity</strong></summary>

Default safe method:

```bash
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
<summary><strong>Step L10 — Link agent to verified human</strong></summary>

Set your agent name and description:

```bash
read -p "Agent name: " AGENT_NAME
read -p "Short agent description: " AGENT_DESCRIPTION

node scripts/manualLinkHumanToAgent.js --challenge "{\"name\":\"$AGENT_NAME\",\"description\":\"$AGENT_DESCRIPTION\"}"
```

Open the printed verification URL in your browser.

Complete the Billions human-agent linking flow.

Do not share the pairing link publicly.

If the pairing link expired, run this step again and open the new link.

</details>

---

<details>
<summary><strong>Step L11 — Verify identity status</strong></summary>

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
<summary><strong>Step L12 — Prepare for free tile claim</strong></summary>

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
<summary><strong>Step L13 — Claim the free tile</strong></summary>

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
<summary><strong>Step L14 — Save proof after success</strong></summary>

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
