# Update Identity Skill

Use this page only if Agent Doctor says:

```text
UPDATE_SKILL_FIRST
BROKEN_SKILL
OUTDATED / NOT X402 READY
buildX402Payment.js missing
```

For Tiles claim, the skill must be x402-ready.

Minimum expected files:

```text
package.json
scripts/getIdentities.js
scripts/createNewEthereumIdentity.js
scripts/manualLinkHumanToAgent.js
scripts/buildX402Payment.js
```

The key marker is:

```text
scripts/buildX402Payment.js
```

---

## Important safety rule

Do not update blindly.

Do not copy identity from another agent.

Do not delete `$HOME/.openclaw/billions`.

Do not upload or share:

```text
kms.json
identities.json
defaultDid.json
credentials.json
private key
seed phrase
```

---

## Step 1 — Confirm the correct agent

Run Agent Doctor first:

```powershell
irm https://raw.githubusercontent.com/gn1y2025/gn1y-billions-tile-guide/main/scripts/windows-agent-doctor.ps1 | iex
```

Copy the exact agent folder path it found.

---

## Step 2 — Backup current skill folder

PowerShell:

```powershell
$AGENT_ROOT = Read-Host "Paste full path to your OpenClaw agent folder"

$SKILL_DIR = Get-ChildItem -Path $AGENT_ROOT -Directory -Recurse -Filter "verified-agent-identity" |
  Select-Object -First 1 -ExpandProperty FullName

if (!$SKILL_DIR) {
  throw "verified-agent-identity folder not found"
}

$BACKUP = "$SKILL_DIR.backup-$(Get-Date -Format yyyyMMdd-HHmmss)"

Copy-Item -Path $SKILL_DIR -Destination $BACKUP -Recurse -Force

Write-Host "Backup created:"
Write-Host $BACKUP
```

---

## Step 3 — Install / repair from official source

Use one official / verified method.

Preferred:

```bash
npx clawhub@latest install verified-agent-identity
```

Alternative:

```bash
npx skills add BillionsNetwork/verified-agent-identity
```

If your OpenClaw supports the skill by canonical name:

```bash
openclaw skills install verified-agent-identity
```

---

## Step 4 — Install dependencies

Inside the new `verified-agent-identity` folder:

```bash
npm install
```

---

## Step 5 — Check identity

```bash
node scripts/getIdentities.js
```

Continue only if the DID/default identity is still correct.

---

## Step 6 — Check x402 readiness

Confirm this exists:

```text
scripts/buildX402Payment.js
```

Then rerun Agent Doctor.

If Doctor says ready, continue:

[Free Claim Copy-Paste Windows](./free-claim-copy-paste-windows.md)
