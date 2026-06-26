# Windows Agent Doctor

Windows Agent Doctor is the first command most Windows users should run.

It checks your PC and tells you what to do next.

---

## What it checks

Doctor searches for OpenClaw agent folders and checks:

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

---

## What it does not do

Doctor does **not** claim Tiles by itself.

Doctor does **not**:

```text
claim Tiles
send funds
install anything
update anything
delete anything
touch private keys manually
```

---

## Copy-paste command — recommended

Use this from the public website.

Before copying commands, check that you are using the official guide website: https://guide-by-gn1y.vercel.app

Open PowerShell and paste:

```powershell
$DoctorUrl = "https://guide-by-gn1y.vercel.app/scripts/windows-agent-doctor.ps1"
$DoctorFile = Join-Path $env:TEMP "gn1y-windows-agent-doctor.ps1"

Invoke-WebRequest -UseBasicParsing -Uri $DoctorUrl -OutFile $DoctorFile

Write-Host ""
Write-Host "Windows Agent Doctor downloaded to:"
Write-Host $DoctorFile
Write-Host ""

notepad $DoctorFile

Read-Host "Review the script in Notepad. Press Enter to run Windows Agent Doctor"

powershell -NoProfile -ExecutionPolicy Bypass -File $DoctorFile
```

---
## How to read the result

At the end, Doctor should print a `NEXT STEP`.

Follow that exact file.

Do not guess.

---

## If Doctor says no agent found

Open:

[create-agent.md](./create-agent.md)

---

## If Doctor says skill missing

Open:

[existing-agent-status.md](./existing-agent-status.md)

---

## If Doctor says skill outdated / not x402-ready

Open:

[update-identity-skill.md](./update-identity-skill.md)

The key missing file is usually:

```text
scripts/buildX402Payment.js
```

---

## If Doctor says identity missing

Open:

[existing-agent-status.md](./existing-agent-status.md)

Create or restore the correct identity before claim.

---

## If Doctor says human link missing or unclear

Open:

[existing-agent-status.md](./existing-agent-status.md)

Complete pairing / human link first.

---

## If Doctor says ready to claim

Open:

[free-claim-copy-paste-windows.md](./free-claim-copy-paste-windows.md)

Claim only if:

```text
amount=0
Paid: false
correct agent
correct identity
correct human link
```

Stop if:

```text
10 USDC
amount=10000000
amount > 0
```

---

## Privacy

Before sharing Doctor output, read:

[../PRIVACY.md](../PRIVACY.md)

## If Doctor says old skill or no x402

If Windows Agent Doctor finds verified-agent-identity but says buildX402Payment.js is missing, the skill is not ready for the Tile flow.

Do not claim.

Open:

    guides/update-identity-skill.md

Then use:

    Safe Git upgrade for old skill without x402

After upgrading, run Doctor again for the same agent folder.
