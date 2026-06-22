# Free Claim Copy-Paste Windows

Use this only after Agent Doctor says your agent is ready.

Required before running:

```text
Agent folder: correct
verified-agent-identity: found
scripts/getIdentities.js: found
scripts/buildX402Payment.js: found
DID: detected
Human link: verified manually
Expected claim: free only
```

---

## Stop signs

Stop immediately if you see:

```text
10 USDC
amount=10000000
any amount greater than 0
wrong DID
wrong agent address
unverified human link
claim expired
```

---

## Claim command

This command downloads and runs the helper claim script from this repository.

It does not require cloning the whole repo.

Open PowerShell and paste:

```powershell
$AGENT_ROOT = Read-Host "Paste full path to your OpenClaw agent folder"
$INTENT = Read-Host "Tile intent text"

if ([string]::IsNullOrWhiteSpace($INTENT)) {
  $INTENT = "AI agent movie tile claim"
}

$ScriptUrl = "https://raw.githubusercontent.com/gn1y2025/gn1y-billions-tile-guide/main/scripts/windows-instant-free-claim.ps1"
$LocalScript = Join-Path $env:TEMP "gn1y-windows-instant-free-claim.ps1"

Write-Host "Downloading helper claim script..."
Invoke-WebRequest -UseBasicParsing -Uri $ScriptUrl -OutFile $LocalScript

Write-Host "Running FREE claim helper..."
powershell -ExecutionPolicy Bypass -File $LocalScript -AgentRoot $AGENT_ROOT -Intent $INTENT
```

---

## After success

Save proof using:

[Proof Template](../templates/proof-template.md)

Required proof fields:

```text
Agent name
Agent folder
DID
Agent address
Tile ID
Canvas ID
Coordinates
Transaction hash
Paid: false
Date
Explorer link
```

---

## If it fails

Do not manually reuse old `claim_id`.

Run fresh flow only.

Open:

[Claim Errors](../troubleshooting/claim-errors.md)
