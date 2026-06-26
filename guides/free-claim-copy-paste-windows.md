# Free Claim Copy-Paste — Windows

Use this only after Windows Agent Doctor says your agent is ready.

Start from:

- `COMMAND_CENTER.md`
- `guides/windows-agent-doctor.md`

---

## Ready gate

Continue only if all are true:

- agent folder is correct
- `verified-agent-identity` exists
- `scripts/buildX402Payment.js` exists
- `scripts/package.json` exists
- `scripts/node_modules` exists
- `getIdentities.js` works
- DID / identity looks correct
- human link is verified / confirmed
- Windows Agent Doctor says `READY TO CLAIM`

Stop if anything is unclear.

---

## Safety stop

Stop immediately if you see:

- `10 USDC`
- `amount=10000000`
- `amount > 0`
- `Paid=true`
- wrong agent
- wrong DID
- wrong human link
- `node.exe Assertion failed`
- `NativeCommandError`
- `Cannot find module`
- `buildX402Payment.js failed`

The free Tile claim must show:

- `amount=0`
- `Paid=false`

Claim success requires both:

- `SUBMIT OK`
- `Proof saved to:`

If these lines do not appear, the claim is not proven successful.

---

## Recommended command

Use this from the public website.

Before copying commands, check that you are using the official guide website:

`https://guide-by-gn1y.vercel.app`

Do not run this command before Doctor says `READY TO CLAIM`.

Open PowerShell and paste:

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

    $ClaimExitCode = $LASTEXITCODE

    Write-Host ""
    Write-Host "Claim script exit code:"
    Write-Host $ClaimExitCode

    if ($ClaimExitCode -ne 0) {
      Write-Host ""
      Write-Host "STOP: Claim script stopped or failed."
      Write-Host "This is NOT a successful claim."
      Write-Host "Read the error above and open troubleshooting/claim-errors.md."
      throw "Claim script failed."
    }

    Write-Host ""
    Write-Host "Claim script exited with code 0."
    Write-Host "Now manually verify the output above contains:"
    Write-Host "- SUBMIT OK"
    Write-Host "- Paid=false"
    Write-Host "- amount=0"
    Write-Host "- Proof saved to:"
    Write-Host ""
    Write-Host "If any of these lines are missing, do NOT treat it as success."

---

## After success

Open:

- `guides/after-claim-proof.md`

Save proof.

Optional feedback:

- `templates/feedback-template.md`

## Final free-claim safety marker

Continue only when the free claim clearly shows:

- `amount=0`
- `Paid=false`
- `SUBMIT OK`
- `Proof saved to:`

Do not run this command before Doctor says `READY TO CLAIM`.