$ErrorActionPreference = "SilentlyContinue"

Write-Host ""
Write-Host "gn1y Billions Tile Guide - Windows Preflight"
Write-Host ""

function Check-Cmd([string]$Name, [string]$Command) {
  $cmd = Get-Command $Command -ErrorAction SilentlyContinue

  if ($cmd) {
    Write-Host "[OK] $Name found: $($cmd.Source)"
    return $true
  }

  Write-Host "[MISSING] $Name not found."
  return $false
}

$ok = $true

if (!(Check-Cmd "Git" "git")) {
  $ok = $false
}

if (!(Check-Cmd "Node.js" "node")) {
  $ok = $false
}

if (!(Check-Cmd "npm" "npm")) {
  $ok = $false
}

if (!(Check-Cmd "npx" "npx")) {
  $ok = $false
}

if (Get-Command node -ErrorAction SilentlyContinue) {
  Write-Host ""
  Write-Host "Node version:"
  node --version
}

if (Get-Command npm -ErrorAction SilentlyContinue) {
  Write-Host ""
  Write-Host "npm version:"
  npm --version
}

if (Get-Command git -ErrorAction SilentlyContinue) {
  Write-Host ""
  Write-Host "Git version:"
  git --version
}

$openclaw = Get-Command openclaw -ErrorAction SilentlyContinue

if ($openclaw) {
  Write-Host ""
  Write-Host "[OK] OpenClaw found: $($openclaw.Source)"
  Write-Host ""
  Write-Host "OpenClaw version/status:"
  openclaw --version
  openclaw gateway status
} else {
  Write-Host ""
  Write-Host "[MISSING] OpenClaw CLI not found."
  Write-Host "Install it from the official docs before continuing."
  $ok = $false
}

Write-Host ""

if ($ok) {
  Write-Host "PRECHECK OK"
  Write-Host "NEXT STEP: Run Windows Agent Doctor from the guide website."
} else {
  Write-Host "PRECHECK NEEDS FIXES"
  Write-Host "NEXT STEP: Install missing prerequisites, then rerun this preflight."
  exit 1
}