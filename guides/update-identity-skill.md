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

## Safe Git upgrade for old skill without x402

Use this route when Windows Agent Doctor says one of these:

- OUTDATED / NOT X402 READY
- buildX402Payment.js missing
- old verified-agent-identity skill
- multiple verified-agent-identity folders found
- scripts/package.json missing
- skill exists, but it is not x402-ready

Do not run claim commands in this state.

The goal is to safely replace the old skill code with the current official BillionsNetwork/verified-agent-identity code, while backing up the old skill folders first.

### What this route does

This route:

- asks for your agent folder
- finds all verified-agent-identity folders inside that agent
- backs up every old skill folder
- clones the official BillionsNetwork/verified-agent-identity repository
- verifies that the fresh copy contains scripts/buildX402Payment.js
- installs the fresh skill into .agents/skills/verified-agent-identity
- runs npm install inside the scripts folder if scripts/package.json exists
- runs scripts/getIdentities.js after upgrade
- tells you to run Windows Agent Doctor again

This route does not claim Tiles.

This route does not submit anything to Billions.

This route does not spend funds.

### Important identity warning

Do not mix identities between agents.

Restore only this same agent's own identity backup.

Never copy identity files from another agent.

If getIdentities.js says No identities found after the upgrade, do not claim. Create or restore the correct identity, link/pair it with the correct Billions human account, and then run Windows Agent Doctor again.

### What local folders this command creates

This command creates local folders on your own PC only.

Nothing from the backup step is uploaded to gn1y, GitHub, Billions, OpenClaw, or any server.

The command uses these local folders:

- Backup folder inside your Windows user profile:
  - `$env:USERPROFILE\billions-tile-guide-backups\...`
  - This stores copies of old `verified-agent-identity` folders before replacement.
  - Do not share this folder publicly. It may contain identity-related local files.

- Temporary folder inside your Windows temp folder:
  - `$env:TEMP\billions-verified-agent-identity-...`
  - This stores a temporary Git clone of the official `BillionsNetwork/verified-agent-identity` repository.

- Project skill folder inside your selected agent:
  - `<your-agent-folder>\.agents\skills\verified-agent-identity`
  - This is where the fresh skill copy is installed.

Important:

- Backup folders are local only.
- Backup folders may contain sensitive identity-related data.
- Do not upload backup folders.
- Do not post screenshots of backup contents.
- Do not send backup folders to support unless you fully understand what is inside and have redacted sensitive data.

### Windows safe Git upgrade command

Run this only for the agent that Doctor says has an old or non-x402 skill.

Review the output before continuing.

    $ErrorActionPreference = "Stop"

    Write-Host "=== Safe Git upgrade for verified-agent-identity ==="
    Write-Host "This does NOT claim Tiles."
    Write-Host "This does NOT submit anything."
    Write-Host "This does NOT spend funds."
    Write-Host "This backs up old skill folders before replacing the project skill."
    Write-Host "Backup folders are local only."
    Write-Host "Nothing from the backup step is uploaded anywhere."
    Write-Host "Do not share backup folder contents publicly."
    Write-Host ""

    $AgentRoot = Read-Host "Paste the full path to your OpenClaw agent folder"

    if (!(Test-Path $AgentRoot)) {
      throw "STOP: Agent folder not found: $AgentRoot"
    }

    $AgentRoot = (Resolve-Path $AgentRoot).Path
    $AgentName = Split-Path $AgentRoot -Leaf
    $Stamp = Get-Date -Format "yyyyMMdd-HHmmss"

    $BackupRoot = Join-Path $env:USERPROFILE "billions-tile-guide-backups\$AgentName-$Stamp"
    $TempRoot = Join-Path $env:TEMP "billions-verified-agent-identity-$Stamp"
    $FreshClone = Join-Path $TempRoot "verified-agent-identity"
    $ProjectSkillsRoot = Join-Path $AgentRoot ".agents\skills"
    $ProjectSkill = Join-Path $ProjectSkillsRoot "verified-agent-identity"
    $StableHome = Join-Path $AgentRoot "openclaw-home"

    New-Item -ItemType Directory -Force -Path $BackupRoot | Out-Null
    New-Item -ItemType Directory -Force -Path $ProjectSkillsRoot | Out-Null
    New-Item -ItemType Directory -Force -Path $TempRoot | Out-Null

    Write-Host ""
    Write-Host "AgentRoot:"
    Write-Host $AgentRoot
    Write-Host ""
    Write-Host "BackupRoot:"
    Write-Host $BackupRoot
    Write-Host ""
    Write-Host "FreshClone:"
    Write-Host $FreshClone
    Write-Host ""

    Write-Host "=== Find existing verified-agent-identity folders ==="

    $OldSkills = @(Get-ChildItem -Path $AgentRoot -Recurse -Directory -Filter "verified-agent-identity" -ErrorAction SilentlyContinue)

    if ($OldSkills.Count -eq 0) {
      Write-Host "No old verified-agent-identity folders found inside this agent."
    } else {
      foreach ($skill in $OldSkills) {
        Write-Host ""
        Write-Host "FOUND:"
        Write-Host $skill.FullName

        $safeName = ($skill.FullName -replace '[:\\\/]', '_')
        $dest = Join-Path $BackupRoot $safeName

        New-Item -ItemType Directory -Force -Path $dest | Out-Null

        Write-Host "Backing up old skill folder without node_modules/.git:"
        Write-Host $dest

        robocopy $skill.FullName $dest /E /XD node_modules .git /NFL /NDL /NJH /NJS /NP | Out-Null

        if ($LASTEXITCODE -gt 7) {
          throw "STOP: robocopy backup failed for $($skill.FullName)"
        }
      }
    }

    Write-Host ""
    Write-Host "=== Clone official BillionsNetwork/verified-agent-identity ==="

    if (!(Get-Command git -ErrorAction SilentlyContinue)) {
      throw "STOP: Git not found. Install Git first."
    }

    git clone https://github.com/BillionsNetwork/verified-agent-identity.git $FreshClone

    if ($LASTEXITCODE -ne 0) {
      throw "STOP: git clone failed."
    }

    $RequiredFreshFiles = @(
      "scripts\package.json",
      "scripts\getIdentities.js",
      "scripts\createNewEthereumIdentity.js",
      "scripts\manualLinkHumanToAgent.js",
      "scripts\buildX402Payment.js"
    )

    foreach ($rel in $RequiredFreshFiles) {
      $p = Join-Path $FreshClone $rel

      if (!(Test-Path $p)) {
        throw "STOP: Fresh official skill is missing required file: $rel"
      }

      Write-Host "OK fresh file:" $rel
    }

    Write-Host ""
    Write-Host "=== Replace project skill safely ==="

    if (Test-Path $ProjectSkill) {
      $backupProject = Join-Path $BackupRoot "previous-project-skill"

      Move-Item -Path $ProjectSkill -Destination $backupProject -Force

      Write-Host "Moved old project skill to:"
      Write-Host $backupProject
    }

    Copy-Item -Path $FreshClone -Destination $ProjectSkill -Recurse -Force

    $gitFolder = Join-Path $ProjectSkill ".git"

    if (Test-Path $gitFolder) {
      Remove-Item $gitFolder -Recurse -Force
    }

    Write-Host "Fresh project skill installed at:"
    Write-Host $ProjectSkill

    Write-Host ""
    Write-Host "=== npm install inside scripts folder ==="

    $ScriptsRoot = Join-Path $ProjectSkill "scripts"

    if (!(Test-Path (Join-Path $ScriptsRoot "package.json"))) {
      throw "STOP: scripts/package.json missing in fresh skill. Official skill structure is incomplete."
    }

    Push-Location $ScriptsRoot

    npm install

    if ($LASTEXITCODE -ne 0) {
      Pop-Location
      throw "STOP: npm install failed inside scripts folder."
    }

    Pop-Location

    Write-Host "OK: npm install completed inside scripts folder."

    Write-Host ""
    Write-Host "=== Check identities after upgrade ==="

    if (Test-Path $StableHome) {
      $OldHome = $env:HOME
      $env:HOME = $StableHome

      Write-Host "Using HOME for this check:"
      Write-Host $env:HOME
    } else {
      $OldHome = $null
      Write-Host "WARN: openclaw-home not found. Using current HOME:"
      Write-Host $env:HOME
    }

    Push-Location $ProjectSkill

    node .\scripts\getIdentities.js

    $IdentityExit = $LASTEXITCODE

    Pop-Location

    if (![string]::IsNullOrWhiteSpace($OldHome)) {
      $env:HOME = $OldHome
    }

    Write-Host ""
    Write-Host "=== Upgrade completed ==="
    Write-Host "Now run Windows Agent Doctor again for this exact AgentRoot:"
    Write-Host $AgentRoot
    Write-Host ""
    Write-Host "Use targeted mode. Doctor should check only this agent:"
    Write-Host "powershell -NoProfile -ExecutionPolicy Bypass -File <doctor-file> -AgentRoot `"$AgentRoot`""
    Write-Host ""
    Write-Host "Do not claim unless Doctor says READY TO CLAIM."
    Write-Host "If getIdentities.js says No identities found, do not claim."
    Write-Host "Create or restore this agent's identity and pair/link it first."
    Write-Host ""
    Write-Host "This command does not restore or move identity files automatically."

### Optional workspace note

Some older OpenClaw agents also have a workspace skill folder:

    openclaw-home/.openclaw/workspace/skills/verified-agent-identity

If Doctor still reports the old workspace skill after the project skill upgrade, do not claim.

Back up the workspace skill first, then either replace it with the fresh skill or create a junction to the fresh project skill.

Do this only if you understand which folder Doctor is using.

### After the upgrade

Run Windows Agent Doctor again.

Continue only if Doctor confirms:

- verified-agent-identity exists
- scripts/buildX402Payment.js exists
- getIdentities.js returns a DID/default identity
- READY TO CLAIM

If any check fails, stop and use the troubleshooting page.
