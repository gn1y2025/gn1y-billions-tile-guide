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

If PowerShell cannot download the file, open the live guide again and copy the recommended command from: https://guide-by-gn1y.vercel.app

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

## Final command safety reminder

Do not run claim commands until Windows Agent Doctor says READY TO CLAIM and the guide tells you to open the free claim route.

## OpenClaw onboard menu help

If you are creating a new agent and OpenClaw shows an onboard menu, open this file:

    guides/create-agent.md

Then read this section:

    What to choose in OpenClaw onboard

Beginner rule:

    Keep defaults, skip optional channels/search/tools, use only a model-provider API key, and never paste crypto secrets.

After onboard finishes, run Windows Agent Doctor again. Do not run claim commands until Doctor says READY TO CLAIM.

## Route: old identity skill without x402

Use this route if Windows Agent Doctor says:

- OUTDATED / NOT X402 READY
- buildX402Payment.js missing
- old verified-agent-identity skill
- package.json missing
- multiple verified-agent-identity folders found

Do not run claim commands.

Open:

    guides/update-identity-skill.md

Then read:

    Safe Git upgrade for old skill without x402

After the upgrade, run Windows Agent Doctor again. Continue to the free claim route only if Doctor says READY TO CLAIM.

## Doctor targeted mode for multi-agent PCs

If you have many agents, do not rely on broad auto-discovery when troubleshooting one agent.

Run Windows Agent Doctor with the exact agent folder.

Example:

    powershell -NoProfile -ExecutionPolicy Bypass -File <doctor-file> -AgentRoot "D:\agents\snus"

Expected behavior:

- Doctor checks only that agent.
- Doctor does not scan every folder in `D:\agents`.
- Doctor prints one final result for the selected agent.

## Claim crash / Node error route

If the free claim command shows:

- `node.exe Assertion failed`
- `NativeCommandError`
- `Cannot find module`
- `MODULE_NOT_FOUND`
- no `SUBMIT OK`
- no `Proof saved to:`

then the claim is not successful.

Open:

    troubleshooting/claim-errors.md

Do not treat PowerShell finishing as success unless the claim script printed `SUBMIT OK` and `Proof saved to:`.

## Node cleanup assertion route

If Windows prints a Node cleanup assertion after Phase1 or Phase2, check the final result.

Allowed to continue only when the script itself confirms valid JSON and continues safely.

Never treat this as success unless the final output prints:

- `SUBMIT OK`
- `Paid=false`
- `amount=0`
- `Proof saved to:`

If the script stops, open:

    troubleshooting/claim-errors.md

## Phase1 paymentRequiredFilePath route

If Phase1 shows `amount=0` but the script stops at:

    paymentRequiredFilePath not found

open:

    troubleshooting/claim-errors.md

Then use the latest claim script from the live guide website.

Do not manually reuse old Phase1 data. Run a fresh claim flow.

## Phase2 null parser route

If Phase2 starts but the script stops with:

    Cannot bind argument to parameter 'Node' because it is null

open:

    troubleshooting/claim-errors.md

Then use the latest live claim script and run a fresh claim flow.

Do not reuse old Phase1 or Phase2 data.

## Phase2 consumed free allowance route

If an agent shows `claim_id` in old Phase2 logs but no `SUBMIT OK`, no proof, and no NFT, its free allowance may be consumed.

If later attempts return:

    maxExceeded=true
    Payment has exceeded its maximum allowed uses

stop that agent.

Do not retry blindly.

Open:

    troubleshooting/claim-errors.md

For the next test, use a different eligible agent and only the latest live claim script.

## Skill update with identity restore route

If an agent already has `verified-agent-identity`, but after updating the skill Doctor says:

```text
No identities found
```

open:

```text
guides/update-identity-skill.md
```

Use:

```text
Recommended Windows command: safe skill update + identity restore
```

Do not claim until Doctor says READY TO CLAIM.

## Existing agent route

Use this route if you already have an existing agent and you only want to check whether it is ready for the free Tile claim.

For an existing agent:

1. Run Windows Agent Doctor for that exact agent folder.
2. If Doctor says the skill is old or not x402-ready, update the skill with identity restore.
3. If Doctor says `No identities found`, restore the same agent identity first.
4. Claim only when Doctor says READY TO CLAIM.
5. Treat success only as:

```text
SUBMIT OK
Paid=false
amount=0
Proof saved to:
```

If you see `maxExceeded=true` or `Payment has exceeded`, stop.

Do not switch to paid.
