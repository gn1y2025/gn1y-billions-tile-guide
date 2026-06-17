# \# Windows PowerShell Guide

# 

# Safety-first Windows guide for preparing an OpenClaw agent for the Billions AI Agentic Movie Tiles claim flow.

# 

# This guide is unofficial. It does not guarantee FAIAR rewards, airdrop allocation, leaderboard rewards, or free tile eligibility.

# 

# Default mode: \*\*FREE CLAIM ONLY\*\*.

# 

# \---

# 

# \## 0. Security First

# 

# Never share:

# 

# \* seed phrase;

# \* private key;

# \* wallet export;

# \* `kms.json`;

# \* identity backup files;

# \* browser profile data;

# \* full screenshots with sensitive wallet/account data.

# 

# Use a separate wallet or identity key for agent activity.

# 

# Do not use your main wallet with valuable assets.

# 

# If any command, website, Discord DM, script, or AI agent asks for a seed phrase or private key:

# 

# \*\*STOP immediately.\*\*

# 

# \---

# 

# \## 1. Open PowerShell

# 

# Open \*\*PowerShell\*\*.

# 

# Normal user mode is recommended.

# 

# Do not use Administrator mode unless a specific installer asks for it.

# 

# \---

# 

# \## 2. Check required tools

# 

# Run:

# 

# ```powershell

# Write-Host "Checking Git..."

# git --version

# 

# Write-Host "Checking Node.js..."

# node -v

# 

# Write-Host "Checking npm..."

# npm -v

# 

# Write-Host "Checking npx..."

# npx -v

# 

# Write-Host "Checking OpenClaw..."

# openclaw --version

# ```

# 

# If all commands return versions, continue.

# 

# If something is not recognized, install the missing tool.

# 

# \---

# 

# \## 3. Install Git if missing

# 

# If `git --version` fails, run:

# 

# ```powershell

# winget install --id Git.Git -e --source winget

# ```

# 

# Close PowerShell, open it again, then check:

# 

# ```powershell

# git --version

# ```

# 

# \---

# 

# \## 4. Install OpenClaw

# 

# Use the official OpenClaw Windows installer:

# 

# ```powershell

# iwr -useb https://openclaw.ai/install.ps1 | iex

# ```

# 

# After installation, close PowerShell and open it again.

# 

# Check:

# 

# ```powershell

# openclaw --version

# node -v

# npm -v

# npx -v

# ```

# 

# If OpenClaw onboarding did not run automatically, run:

# 

# ```powershell

# openclaw onboard --install-daemon

# ```

# 

# \---

# 

# \## 5. Choose your OpenClaw agent folder

# 

# This guide does not use fixed local paths.

# 

# Paste your own OpenClaw agent folder path when asked.

# 

# ```powershell

# $AGENT\_ROOT = Read-Host "Paste the full path to your OpenClaw agent folder"

# 

# if (!(Test-Path $AGENT\_ROOT)) {

# &#x20; throw "Agent folder not found. Check the path and try again."

# }

# 

# Set-Location $AGENT\_ROOT

# 

# Write-Host ""

# Write-Host "Using agent folder:"

# Write-Host $AGENT\_ROOT

# Write-Host ""

# ```

# 

# If this fails, check that:

# 

# \* the folder exists;

# \* you pasted the full path;

# \* you selected the intended agent folder;

# \* you are not inside another agent folder.

# 

# \---

# 

# \## 6. Create a safety backup

# 

# Before changing anything, create a backup folder.

# 

# ```powershell

# $BACKUP\_ROOT = Join-Path $AGENT\_ROOT ("backup-before-tile-claim-" + (Get-Date -Format "yyyyMMdd-HHmmss"))

# 

# New-Item -ItemType Directory -Force -Path $BACKUP\_ROOT | Out-Null

# 

# Write-Host "Backup folder created:"

# Write-Host $BACKUP\_ROOT

# ```

# 

# Do not upload this backup publicly.

# 

# Do not share identity files, wallet files, or `kms.json`.

# 

# \---

# 

# \## 7. Install or verify the official Billions Verified Agent Identity skill

# 

# From your agent folder, try:

# 

# ```powershell

# npx openclaw skills install identity

# ```

# 

# If that does not work, try:

# 

# ```powershell

# npx skills add BillionsNetwork/verified-agent-identity

# ```

# 

# Use only the official Billions source.

# 

# Do not install random forks, Discord DM files, or unknown scripts.

# 

# If both commands fail, stop and check `TROUBLESHOOTING.md`.

# 

# \---

# 

# \## 8. Find the installed skill folder

# 

# Run:

# 

# ```powershell

# $SKILL\_DIR = Get-ChildItem -Path $AGENT\_ROOT -Recurse -Directory -Filter "verified-agent-identity" -ErrorAction SilentlyContinue |

# &#x20; Select-Object -First 1 -ExpandProperty FullName

# 

# if (!$SKILL\_DIR) {

# &#x20; throw "verified-agent-identity skill folder not found. The skill may not be installed correctly."

# }

# 

# Set-Location $SKILL\_DIR

# 

# Write-Host "Using skill folder:"

# Write-Host $SKILL\_DIR

# ```

# 

# If the folder is not found:

# 

# \* check that you selected the correct agent folder;

# \* reinstall the skill from the correct folder;

# \* do not copy identity from another agent.

# 

# \---

# 

# \## 9. Install skill dependencies

# 

# Inside the skill folder, run:

# 

# ```powershell

# if (Test-Path "package.json") {

# &#x20; npm install

# } else {

# &#x20; throw "package.json not found inside skill folder. Check if this is the correct skill folder."

# }

# ```

# 

# If `npm install` fails:

# 

# \* check Node.js version;

# \* check internet connection;

# \* check that you are inside the correct skill folder;

# \* do not run `npm install` from a disk root or wrong folder.

# 

# \---

# 

# \## 10. Create a new agent identity

# 

# Default safe method:

# 

# ```powershell

# node scripts/createNewEthereumIdentity.js

# ```

# 

# Important:

# 

# \* do not use your main wallet private key;

# \* do not paste seed phrases;

# \* do not upload generated identity files;

# \* keep identity files private and backed up.

# 

# If identity creation fails, check `TROUBLESHOOTING.md`.

# 

# \---

# 

# \## 11. Link agent to verified human

# 

# Set your agent name and description:

# 

# ```powershell

# $AGENT\_NAME = Read-Host "Agent name"

# $AGENT\_DESCRIPTION = Read-Host "Short agent description"

# 

# $challenge = @{

# &#x20; name = $AGENT\_NAME

# &#x20; description = $AGENT\_DESCRIPTION

# } | ConvertTo-Json -Compress

# 

# node scripts/manualLinkHumanToAgent.js --challenge $challenge

# ```

# 

# Open the printed verification URL in your browser.

# 

# Complete the Billions human-agent linking flow.

# 

# If the link expired, run this step again and open the new link.

# 

# Do not share the pairing link publicly.

# 

# \---

# 

# \## 12. Verify identity status

# 

# After linking, check your agent identity again using the scripts available in the skill folder.

# 

# If the skill includes an identity listing script, run it and confirm:

# 

# ```text

# Agent identity: exists

# DID: visible

# Human link: verified

# Agent address: visible

# ```

# 

# If DID or agent address is wrong:

# 

# \*\*STOP.\*\*

# 

# You may be using the wrong agent folder or wrong identity.

# 

# \---

# 

# \## 13. Prepare for free tile claim

# 

# Open the official Billions AI Agentic Movie / x402 claim flow.

# 

# Before claiming, check:

# 

# ```text

# Agent identity: correct

# DID: correct

# Human link: verified

# Claim type: free

# Expected amount: 0

# ```

# 

# If you see:

# 

# ```text

# 10 USDC

# amount=10000000

# any amount greater than 0

# ```

# 

# then stop.

# 

# This is not a free claim.

# 

# \---

# 

# \## 14. Claim the free tile

# 

# Use the official claim flow.

# 

# The agent may prepare the action, but the human must review the summary before continuing.

# 

# Before final claim, check:

# 

# ```text

# Agent name:

# Agent address:

# DID:

# Claim type:

# Expected amount:

# Canvas:

# Tile coordinates if available:

# ```

# 

# Continue only if everything is correct.

# 

# Do not approve paid payment if you only want a free tile.

# 

# Do not approve unlimited token permissions.

# 

# Do not continue if the displayed agent address or DID is wrong.

# 

# \---

# 

# \## 15. Save proof after success

# 

# After successful claim, save:

# 

# ```text

# Agent name:

# Agent address:

# DID:

# Tile ID:

# Tx hash:

# Human field:

# Attestation:

# Canvas ID:

# X:

# Y:

# Placed at:

# Explorer link:

# Claim type: free / paid

# Date:

# ```

# 

# Do not share private keys, seed phrases, wallet files, or identity backup files.

# 

# \---

# 

# \## 16. Final terminal message

# 

# After success, you can show this message:

# 

# ```powershell

# Write-Host ""

# Write-Host "✅ Tile claim flow completed."

# Write-Host ""

# Write-Host "Save your proof:"

# Write-Host "- Tile ID"

# Write-Host "- Tx hash"

# Write-Host "- Agent address"

# Write-Host "- DID"

# Write-Host "- Canvas ID"

# Write-Host "- X/Y coordinates"

# Write-Host "- Claim date"

# Write-Host ""

# Write-Host "If the gn1y guide helped you, you can optionally leave feedback or a comment in Discord/X/GitHub."

# Write-Host ""

# Write-Host "Never share seed phrases, private keys, wallet keys, or sensitive identity data."

# Write-Host ""

# ```

# 

# \---

# 

# \## 17. Windows-specific notes

# 

# \### PowerShell execution policy

# 

# If a trusted official installer is blocked, check execution policy:

# 

# ```powershell

# Get-ExecutionPolicy

# ```

# 

# Do not blindly disable security settings.

# 

# If needed, run only the official installer and restore normal settings after.

# 

# \### CRLF warnings in Git

# 

# Warnings like this are normal on Windows:

# 

# ```text

# LF will be replaced by CRLF

# ```

# 

# They are not critical for this guide.

# 

# \### Administrator mode

# 

# Most steps do not require Administrator mode.

# 

# Use Administrator only if an installer requires it.

# 

# \### Antivirus warnings

# 

# Do not bypass antivirus warnings for unknown scripts.

# 

# Use only official OpenClaw and Billions sources.

# 

# \---

# 

# \## 18. Stop conditions

# 

# Stop immediately if:

# 

# \* a script asks for seed phrase;

# \* a script asks for private key;

# \* wallet asks for unlimited approval;

# \* claim amount is not `0` but you wanted free claim;

# \* DID does not match the intended agent;

# \* agent address does not match the intended agent;

# \* website looks unofficial;

# \* pairing link came from an unknown person;

# \* you are not sure what the next action does.

# 

# When unsure:

# 

# \*\*STOP and ask for help.\*\*



