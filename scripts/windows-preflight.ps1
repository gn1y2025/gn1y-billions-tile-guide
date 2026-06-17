param(
  [string]$AgentRoot
)

Write-Host ""
Write-Host "gn1y Billions Tile Guide — Windows Preflight"
Write-Host "This script checks tools and folders only. It does not claim tiles and does not spend funds."
Write-Host ""

function Test-CommandExists {
  param([string]$CommandName)

  $cmd = Get-Command $CommandName -ErrorAction SilentlyContinue
  if ($cmd) {
    Write-Host "OK: $CommandName found"
    return $true
  } else {
    Write-Host "MISSING: $CommandName not found"
    return $false
  }
}

$ok = $true

if (!(Test-CommandExists "git")) { $ok = $false }
if (!(Test-CommandExists "node")) { $ok = $false }
if (!(Test-CommandExists "npm")) { $ok = $false }
if (!(Test-CommandExists "npx")) { $ok = $false }
if (!(Test-CommandExists "openclaw")) { $ok = $false }

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

$skillDirs = Get-ChildItem -Path $AgentRoot -Recurse -Directory -Filter "verified-agent-identity" -ErrorAction SilentlyContinue

if (!$skillDirs -or $skillDirs.Count -eq 0) {
  Write-Host "MISSING: verified-agent-identity skill folder not found"
  Write-Host "Next step: install official Billions Verified Agent Identity skill"
  exit 1
}

$skillDir = $skillDirs[0].FullName
Write-Host "OK: verified-agent-identity skill found"
Write-Host "Skill folder: $skillDir"

$packageJson = Join-Path $skillDir "package.json"
if (Test-Path $packageJson) {
  Write-Host "OK: package.json found"
} else {
  Write-Host "MISSING: package.json not found in skill folder"
  exit 1
}

$createIdentity = Join-Path $skillDir "scripts\createNewEthereumIdentity.js"
$linkHuman = Join-Path $skillDir "scripts\manualLinkHumanToAgent.js"

if (Test-Path $createIdentity) {
  Write-Host "OK: createNewEthereumIdentity.js found"
} else {
  Write-Host "MISSING: createNewEthereumIdentity.js not found"
  $ok = $false
}

if (Test-Path $linkHuman) {
  Write-Host "OK: manualLinkHumanToAgent.js found"
} else {
  Write-Host "MISSING: manualLinkHumanToAgent.js not found"
  $ok = $false
}

Write-Host ""

if ($ok) {
  Write-Host "Preflight completed. Basic setup looks ready."
  Write-Host "This script did not claim a tile and did not spend funds."
  exit 0
} else {
  Write-Host "Preflight found issues. Fix them before continuing."
  exit 1
}
