param(
  [string]$AgentRoot
)

Write-Host ""
Write-Host "gn1y Billions Tile Guide — Windows Preflight"
Write-Host "This script checks tools and folders only. It does not claim tiles and does not spend funds."
Write-Host ""

$ErrorActionPreference = "Stop"
$missing = $false

function Check-Command($Name) {
  $cmd = Get-Command $Name -ErrorAction SilentlyContinue
  if ($cmd) {
    Write-Host "OK: $Name found"
  } else {
    Write-Host "MISSING: $Name not found"
    $script:missing = $true
  }
}

Check-Command git
Check-Command node
Check-Command npm
Check-Command npx
Check-Command openclaw

Write-Host ""

try {
  Write-Host "OpenClaw gateway status:"
  openclaw gateway status
} catch {
  Write-Host "WARNING: openclaw gateway status failed. Run onboarding or start the gateway before full agent work."
}

Write-Host ""

if (!$AgentRoot) {
  $AgentRoot = Read-Host "Paste the full path to your OpenClaw agent folder"
}

if (!(Test-Path $AgentRoot)) {
  Write-Host "MISSING: Agent folder not found"
  Write-Host "Path: $AgentRoot"
  exit 1
}

Write-Host "OK: Agent folder exists"
Write-Host "Agent folder: $AgentRoot"

$skillDirs = @(Get-ChildItem -Path $AgentRoot -Recurse -Directory -Filter "verified-agent-identity" -ErrorAction SilentlyContinue)

if ($skillDirs.Count -eq 0) {
  Write-Host "MISSING: verified-agent-identity skill folder not found"
  Write-Host "Next step: install official Billions Verified Agent Identity skill"
  exit 1
}

if ($skillDirs.Count -gt 1) {
  Write-Host "WARNING: Multiple verified-agent-identity folders found. Confirm the correct one before continuing."
  $skillDirs | ForEach-Object { Write-Host "- $($_.FullName)" }
}

$SkillDir = $skillDirs[0].FullName

Write-Host "OK: verified-agent-identity skill found"
Write-Host "Skill folder: $SkillDir"

$requiredFiles = @(
  "package.json",
  "scripts\createNewEthereumIdentity.js",
  "scripts\manualLinkHumanToAgent.js",
  "scripts\getIdentities.js",
  "scripts\buildX402Payment.js"
)

foreach ($rel in $requiredFiles) {
  $full = Join-Path $SkillDir $rel
  if (Test-Path $full) {
    Write-Host "OK: $rel found"
  } else {
    Write-Host "MISSING: $rel not found"
    $missing = $true
  }
}

Write-Host ""

if (!$missing) {
  Write-Host "Preflight completed. Basic setup looks ready."
  Write-Host "Next recommended check:"
  Write-Host "  cd `"$SkillDir`""
  Write-Host "  node scripts/getIdentities.js"
  Write-Host ""
  Write-Host "This script did not claim a tile and did not spend funds."
  exit 0
} else {
  Write-Host "Preflight found issues. Fix them before continuing."
  exit 1
}
