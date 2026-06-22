# Command Center

Start here if you are on Windows and want the shortest safe path.

The goal is simple:

```text
run one audit command
-> terminal checks your PC
-> terminal tells you the next exact file to open
```

---

## Step 1 — Run Windows Agent Doctor

Windows Agent Doctor checks your PC and tells you what to do next.

It does **not**:

```text
claim Tiles
send funds
install anything
update anything
delete anything
touch private keys manually
```

It only checks and prints a result.

---

## Copy-paste command — recommended

Use this from the public website.

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

If PowerShell cannot download the file, the repo may still be private. Use local testing mode below.

---


---

## Step 2 — Read the terminal result

Doctor will end with a `NEXT STEP`.

Follow only that result.

---

## Possible results

### Result 1 — no agent found

Open:

[guides/create-agent.md](./guides/create-agent.md)

Use this if you need to create an OpenClaw agent from zero.

---

### Result 2 — agent found, but identity skill missing

Open:

[guides/existing-agent-status.md](./guides/existing-agent-status.md)

Go to the case where the agent exists but `verified-agent-identity` is missing.

---

### Result 3 — skill found, but outdated / not x402-ready

Open:

[guides/update-identity-skill.md](./guides/update-identity-skill.md)

Do **not** claim Tiles yet.

The most important x402-ready marker is:

```text
scripts/buildX402Payment.js
```

If this file is missing, update or repair the identity skill first.

---

### Result 4 — identity missing

Open:

[guides/existing-agent-status.md](./guides/existing-agent-status.md)

Go to the case where the skill exists but DID / identity is missing.

---

### Result 5 — human link missing or unclear

Open:

[guides/existing-agent-status.md](./guides/existing-agent-status.md)

Go to the human link / pairing section.

Do not claim until the correct human account is linked.

---

### Result 6 — ready to claim

Open:

[guides/free-claim-copy-paste-windows.md](./guides/free-claim-copy-paste-windows.md)

Continue only if:

```text
agent folder is correct
DID looks correct
human link is verified / confirmed
buildX402Payment.js exists
free amount is exactly 0
```

Stop if you see:

```text
10 USDC
amount=10000000
amount > 0
```

---

## Privacy before sharing logs

Before posting Doctor output in Discord, GitHub, Telegram, or X, read:

[PRIVACY.md](./PRIVACY.md)

Redact anything you do not want public.


