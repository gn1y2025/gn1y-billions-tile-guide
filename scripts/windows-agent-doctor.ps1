param(
  [string]$AgentRoot = "",
  [string[]]$SearchRoots = @()
)

$ErrorActionPreference = "SilentlyContinue"

function Line {
  Write-Host "------------------------------------------------------------"
}

function Title([string]$Text) {
  Write-Host ""
  Line
  Write-Host $Text
  Line
}

function Good([string]$Text) {
  Write-Host "[OK] $Text"
}

function Bad([string]$Text) {
  Write-Host "[MISSING] $Text"
}

function Warn([string]$Text) {
  Write-Host "[CHECK] $Text"
}

function Info([string]$Text) {
  Write-Host "[INFO] $Text"
}

function Test-ExistingFile([string]$Path, [string]$Label) {
  if (Test-Path $Path) {
    Good $Label
    return $true
  }

  Bad $Label
  return $false
}

function Find-SkillFolders([string]$Root) {
  if (!(Test-Path $Root)) {
    return @()
  }

  try {
    return @(Get-ChildItem -Path $Root -Directory -Filter "verified-agent-identity" -Recurse -Depth 8 -ErrorAction SilentlyContinue)
  } catch {
    return @(Get-ChildItem -Path $Root -Directory -Filter "verified-agent-identity" -Recurse -ErrorAction SilentlyContinue)
  }
}

function Guess-AgentRootFromSkill([string]$SkillPath) {
  $markers = @(
    "\.agents\skills\verified-agent-identity",
    "\openclaw-home\.openclaw\workspace\skills\verified-agent-identity",
    "\skills\verified-agent-identity"
  )

  foreach ($m in $markers) {
    $idx = $SkillPath.IndexOf($m, [System.StringComparison]::OrdinalIgnoreCase)
    if ($idx -gt 0) {
      return $SkillPath.Substring(0, $idx)
    }
  }

  return (Split-Path (Split-Path $SkillPath -Parent) -Parent)
}

function Add-UniquePath([System.Collections.Generic.List[string]]$List, [string]$Path) {
  if ([string]::IsNullOrWhiteSpace($Path)) {
    return
  }

  try {
    $resolved = (Resolve-Path $Path -ErrorAction SilentlyContinue).Path
  } catch {
    $resolved = $Path
  }

  if ([string]::IsNullOrWhiteSpace($resolved)) {
    return
  }

  if ($List -notcontains $resolved) {
    [void]$List.Add($resolved)
  }
}

function Assess-Agent([string]$Root) {
  Title "AGENT CHECK: $Root"

  $result = [ordered]@{
    AgentRoot = $Root
    SkillFound = $false
    SkillPath = ""
    HasPackageJson = $false
    HasGetIdentities = $false
    HasCreateIdentity = $false
    HasManualLink = $false
    HasBuildX402 = $false
    DidDetected = $false
    HumanLinkHint = $false
    Status = "UNKNOWN"
    NextFile = ""
  }

  if (!(Test-Path $Root)) {
    Bad "Agent folder does not exist"
    $result.Status = "AGENT_FOLDER_MISSING"
    $result.NextFile = "START_HERE.md -> Route B -> guides/create-agent.md"
    return [PSCustomObject]$result
  }

  Good "Agent folder exists"

  $skillFolders = @(Find-SkillFolders $Root)

  if ($skillFolders.Count -eq 0) {
    Bad "verified-agent-identity skill folder not found"
    $result.Status = "NO_IDENTITY_SKILL"
    $result.NextFile = "guides/existing-agent-status.md -> Case A1 - Skill missing"
    return [PSCustomObject]$result
  }

  if ($skillFolders.Count -gt 1) {
    Warn "Multiple verified-agent-identity folders found. Using the first x402-ready looking one if possible."
    foreach ($s in $skillFolders) {
      Info $s.FullName
    }
  }

  $skill = $skillFolders | Where-Object {
    Test-Path (Join-Path $_.FullName "scripts\buildX402Payment.js")
  } | Select-Object -First 1

  if (!$skill) {
    $skill = $skillFolders | Select-Object -First 1
  }

  $result.SkillFound = $true
  $result.SkillPath = $skill.FullName

  Good "verified-agent-identity found:"
  Write-Host $skill.FullName

  $pkg = Join-Path $skill.FullName "package.json"
  $getIds = Join-Path $skill.FullName "scripts\getIdentities.js"
  $createId = Join-Path $skill.FullName "scripts\createNewEthereumIdentity.js"
  $manualLink = Join-Path $skill.FullName "scripts\manualLinkHumanToAgent.js"
  $buildX402 = Join-Path $skill.FullName "scripts\buildX402Payment.js"

  $result.HasPackageJson = Test-ExistingFile $pkg "package.json"
  $result.HasGetIdentities = Test-ExistingFile $getIds "scripts/getIdentities.js"
  $result.HasCreateIdentity = Test-ExistingFile $createId "scripts/createNewEthereumIdentity.js"
  $result.HasManualLink = Test-ExistingFile $manualLink "scripts/manualLinkHumanToAgent.js"
  $result.HasBuildX402 = Test-ExistingFile $buildX402 "scripts/buildX402Payment.js"

  if (!$result.HasBuildX402) {
    Bad "Skill status: OUTDATED / NOT X402 READY"
    $result.Status = "UPDATE_SKILL_FIRST"
    $result.NextFile = "guides/update-identity-skill.md"
    return [PSCustomObject]$result
  }

  Good "Skill status: X402 READY marker found"

  if (!$result.HasGetIdentities) {
    Bad "Cannot check identity because getIdentities.js is missing"
    $result.Status = "BROKEN_SKILL"
    $result.NextFile = "guides/update-identity-skill.md"
    return [PSCustomObject]$result
  }

  $node = Get-Command node -ErrorAction SilentlyContinue

  if (!$node) {
    Bad "Node.js not found"
    $result.Status = "NODE_MISSING"
    $result.NextFile = "guides/create-agent.md -> Node/OpenClaw prerequisites"
    return [PSCustomObject]$result
  }

  Title "RUNNING IDENTITY CHECK"

  Push-Location $skill.FullName
  $identityRaw = & node "scripts\getIdentities.js" 2>&1
  $exitCode = $LASTEXITCODE
  Pop-Location

  $identityText = ($identityRaw | Out-String)

  if ($exitCode -ne 0) {
    Bad "getIdentities.js failed"
    Write-Host $identityText
    $result.Status = "IDENTITY_CHECK_FAILED"
    $result.NextFile = "guides/existing-agent-status.md -> Case A5 / troubleshooting"
    return [PSCustomObject]$result
  }

  Write-Host $identityText

  $result.DidDetected = ($identityText -match "did:" -or $identityText -match '"did"\s*:')

  if (!$result.DidDetected) {
    Bad "No DID detected"
    $result.Status = "NO_DID"
    $result.NextFile = "guides/existing-agent-status.md -> Case A2 - identity missing"
    return [PSCustomObject]$result
  }

  Good "DID detected"

  $result.HumanLinkHint = ($identityText -match "human|linked|verified|credential|success|isDefault")

  if ($result.HumanLinkHint) {
    Warn "Human link / default identity hint detected. Still verify manually in output and Billions app."
  } else {
    Warn "Human link was not clearly detected from output. This may be normal, but verify manually."
  }

  $result.Status = "READY_FOR_FREE_CLAIM_AFTER_MANUAL_CHECK"
  $result.NextFile = "guides/free-claim-copy-paste-windows.md"

  return [PSCustomObject]$result
}

Title "gn1y Windows Agent Doctor"

Info "This is read-only."
Info "It does not claim Tiles."
Info "It does not install or update anything."
Info "It does not spend funds."
Info "It only searches and tells you what to do next."

$candidateRoots = New-Object System.Collections.Generic.List[string]

if (![string]::IsNullOrWhiteSpace($AgentRoot)) {
  Add-UniquePath $candidateRoots $AgentRoot
}

foreach ($sr in $SearchRoots) {
  Add-UniquePath $candidateRoots $sr
}

$commonRoots = @(
  "D:\agents",
  "C:\agents",
  "$env:USERPROFILE\agents",
  "$env:USERPROFILE\Desktop",
  "$env:USERPROFILE\.openclaw"
)

foreach ($cr in $commonRoots) {
  if (Test-Path $cr) {
    Info "Search root exists: $cr"

    $skills = @(Find-SkillFolders $cr)

    foreach ($s in $skills) {
      $guess = Guess-AgentRootFromSkill $s.FullName
      Add-UniquePath $candidateRoots $guess
    }

    try {
      $configs = @(Get-ChildItem -Path $cr -Filter "openclaw.json" -Recurse -Depth 6 -ErrorAction SilentlyContinue | Where-Object {
        $_.FullName -match "\\config\\openclaw\.json$"
      })

      foreach ($cfg in $configs) {
        $rootGuess = Split-Path (Split-Path $cfg.FullName -Parent) -Parent
        Add-UniquePath $candidateRoots $rootGuess
      }
    } catch {}
  }
}

$openclaw = Get-Command openclaw -ErrorAction SilentlyContinue

if ($openclaw) {
  Title "OPENCLAW CLI CHECK"
  $bindings = & openclaw agents list --bindings 2>&1
  Write-Host ($bindings | Out-String)

  $text = ($bindings | Out-String)
  $pathMatches = [regex]::Matches($text, '[A-Za-z]:\\[^\r\n\|"]+')

  foreach ($m in $pathMatches) {
    $p = $m.Value.Trim()
    if (Test-Path $p) {
      Add-UniquePath $candidateRoots $p
    }
  }
} else {
  Warn "OpenClaw CLI not found in PATH. Doctor will continue with folder search."
}

Title "CANDIDATE AGENT FOLDERS"

if ($candidateRoots.Count -eq 0) {
  Bad "No agent folders found automatically."
  Write-Host ""
  Write-Host "WHAT TO DO NEXT:"
  Write-Host "1. If you already have an agent, rerun Doctor and pass -AgentRoot if running local script."
  Write-Host "2. If you do not have an agent, open START_HERE.md -> Route B -> guides/create-agent.md"
  Write-Host ""
  Write-Host "NEXT STEP: Open START_HERE.md and follow the matching route." -ForegroundColor Cyan
  exit 0
}

foreach ($r in $candidateRoots) {
  Write-Host $r
}

$results = @()

foreach ($root in $candidateRoots) {
  $results += Assess-Agent $root
}

Title "FINAL DOCTOR SUMMARY"

$ready = @($results | Where-Object { $_.Status -eq "READY_FOR_FREE_CLAIM_AFTER_MANUAL_CHECK" })
$update = @($results | Where-Object { $_.Status -eq "UPDATE_SKILL_FIRST" -or $_.Status -eq "BROKEN_SKILL" })
$noDid = @($results | Where-Object { $_.Status -eq "NO_DID" })
$noSkill = @($results | Where-Object { $_.Status -eq "NO_IDENTITY_SKILL" })

foreach ($r in $results) {
  Write-Host ""
  Write-Host "AgentRoot: $($r.AgentRoot)"
  Write-Host "Status: $($r.Status)"
  Write-Host "Next file: $($r.NextFile)"
}

Write-Host ""
Line
Write-Host "WHAT TO DO NEXT"
Line

if ($ready.Count -gt 0) {
  Write-Host "READY CANDIDATE FOUND."
  Write-Host ""
  Write-Host "Before claiming, manually confirm in the output above:"
  Write-Host "- correct agent folder"
  Write-Host "- correct DID/default identity"
  Write-Host "- human link is verified"
  Write-Host "- buildX402Payment.js exists"
  Write-Host ""
  Write-Host "Next:"
  Write-Host "1. Open GitHub repo."
  Write-Host "2. Open: guides/free-claim-copy-paste-windows.md"
  Write-Host "3. Copy the FREE claim command."
  Write-Host "4. Use this AgentRoot:"
  Write-Host "   $($ready[0].AgentRoot)"
  Write-Host ""
  Write-Host "STOP if you see:"
  Write-Host "- 10 USDC"
  Write-Host "- amount=10000000"
  Write-Host "- any amount greater than 0"
  Write-Host ""
  Write-Host "NEXT STEP: Open guides/free-claim-copy-paste-windows.md only after manual verification." -ForegroundColor Cyan
  exit 0
}

if ($update.Count -gt 0) {
  Write-Host "AGENT FOUND, BUT IDENTITY SKILL IS OUTDATED OR BROKEN."
  Write-Host ""
  Write-Host "Next:"
  Write-Host "Open: guides/update-identity-skill.md"
  Write-Host ""
  Write-Host "Do not claim Tiles yet."
  Write-Host ""
  Write-Host "NEXT STEP: Open guides/update-identity-skill.md" -ForegroundColor Cyan
  exit 0
}

if ($noDid.Count -gt 0) {
  Write-Host "AGENT FOUND, SKILL IS X402-READY, BUT DID WAS NOT DETECTED."
  Write-Host ""
  Write-Host "Next:"
  Write-Host "Open: guides/existing-agent-status.md"
  Write-Host "Go to Case A2 - Skill exists, identity missing."
  Write-Host ""
  Write-Host "NEXT STEP: Open guides/existing-agent-status.md" -ForegroundColor Cyan
  exit 0
}

if ($noSkill.Count -gt 0) {
  Write-Host "AGENT FOUND, BUT verified-agent-identity SKILL IS MISSING."
  Write-Host ""
  Write-Host "Next:"
  Write-Host "Open: guides/existing-agent-status.md"
  Write-Host "Go to Case A1 - Skill missing."
  Write-Host ""
  Write-Host "NEXT STEP: Open guides/existing-agent-status.md" -ForegroundColor Cyan
  exit 0
}

Write-Host "No ready agent found."
Write-Host ""
Write-Host "Next:"
Write-Host "Open START_HERE.md and follow the route printed above."
Write-Host ""
Write-Host "NEXT STEP: Read the result above and open the guide file shown by Windows Agent Doctor." -ForegroundColor Cyan
Write-Host "If the result is unclear, open COMMAND_CENTER.md and follow the matching route." -ForegroundColor Cyan