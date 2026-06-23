# Free Claim Copy-Paste — Windows

Use this only after Windows Agent Doctor says your agent is ready.

Start from:

[../COMMAND_CENTER.md](../COMMAND_CENTER.md)

---

## Ready gate

Continue only if all are true:

```text
agent folder is correct
verified-agent-identity exists
scripts/buildX402Payment.js exists
getIdentities.js works
DID / identity looks correct
human link is verified / confirmed
```

Stop if anything is unclear.

---

## Safety stop

Stop immediately if you see:

```text
10 USDC
amount=10000000
amount > 0
wrong agent
wrong DID
wrong human link
```

The free Tile claim must use:

```text
amount=0
Paid: false
```

---

## Recommended command

Use this from the public website.

Before copying commands, check that you are using the official guide website: https://guide-by-gn1y.vercel.app

Do not run this command before Doctor says READY TO CLAIM.

Open PowerShell and paste:

```powershell
$AgentRoot = Read-Host "Paste the FULL path to your OpenClaw agent folder"
if (!(Test-Path $AgentRoot)) {
  throw "STOP: Agent folder does not exist: $AgentRoot"
}

$ClaimUrl = "https://guide-by-gn1y.vercel.app/scripts/windows-instant-free-claim.ps1"
$ClaimFile = Join-Path $env:TEMP "gn1y-windows-instant-free-claim.ps1"

Invoke-WebRequest -UseBasicParsing -Uri $ClaimUrl -OutFile $ClaimFile

Write-Host ""
Write-Host "Claim script downloaded to:"
Write-Host $ClaimFile
Write-Host ""

notepad $ClaimFile

Read-Host "Review the script in Notepad. Press Enter to run FREE Tile claim"

powershell -NoProfile -ExecutionPolicy Bypass -File $ClaimFile -AgentRoot $AgentRoot -Intent "AI agent movie tile claim"

if ($?) {
  Write-Host ""
  Write-Host "------------------------------------------------------------"
  Write-Host "Claim command finished without a PowerShell error."
  Write-Host "If the output above shows Tile claimed / Paid false / amount 0:"
  Write-Host ""
  Write-Host "SUCCESS: Free Tile claim flow completed."
  Write-Host "Community guide by gn1y."
  Write-Host "Feedback is welcome:"
  Write-Host "https://github.com/gn1y2025/gn1y-billions-tile-guide"
  Write-Host "------------------------------------------------------------"
}
```

---
## After success

Open:

[after-claim-proof.md](./after-claim-proof.md)

Save proof.

Optional feedback:

[../templates/feedback-template.md](../templates/feedback-template.md)
