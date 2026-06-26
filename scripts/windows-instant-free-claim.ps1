param(
  [string]$AgentRoot,
  [string]$Intent = "AI agent movie tile claim"
)

$ErrorActionPreference = "Stop"

function Stop-Guide([string]$Message) {
  Write-Host ""
  Write-Host "STOP: $Message" -ForegroundColor Red
  Write-Host ""
  exit 1
}

function Info([string]$Message) {
  Write-Host "[INFO] $Message"
}

function Good([string]$Message) {
  Write-Host "[OK] $Message"
}

function Warn([string]$Message) {
  Write-Host "[CHECK] $Message" -ForegroundColor Yellow
}

function ConvertFrom-MixedJsonText {
  param([string]$Text)

  if ([string]::IsNullOrWhiteSpace($Text)) {
    return $null
  }

  try {
    return ($Text | ConvertFrom-Json -ErrorAction Stop)
  } catch {}

  $first = $Text.IndexOf("{")
  $last = $Text.LastIndexOf("}")

  if ($first -ge 0 -and $last -gt $first) {
    $jsonText = $Text.Substring($first, $last - $first + 1)

    try {
      return ($jsonText | ConvertFrom-Json -ErrorAction Stop)
    } catch {}
  }

  return $null
}

function Find-ObjectsRecursive {
  param(
    [Parameter(Mandatory=$true)]$Node,
    [Parameter(Mandatory=$true)][scriptblock]$Predicate
  )

  $results = @()

  if ($null -eq $Node) {
    return $results
  }

  try {
    if (& $Predicate $Node) {
      $results += $Node
    }
  } catch {}

  if ($Node -is [System.Collections.IEnumerable] -and -not ($Node -is [string])) {
    foreach ($item in $Node) {
      $results += Find-ObjectsRecursive -Node $item -Predicate $Predicate
    }
  } elseif ($Node.PSObject -and $Node.PSObject.Properties) {
    foreach ($prop in $Node.PSObject.Properties) {
      $results += Find-ObjectsRecursive -Node $prop.Value -Predicate $Predicate
    }
  }

  return $results
}

function Get-PropValue {
  param(
    [Parameter(Mandatory=$true)]$Object,
    [Parameter(Mandatory=$true)][string[]]$Names
  )

  foreach ($name in $Names) {
    $p = $Object.PSObject.Properties[$name]

    if ($p -and $null -ne $p.Value -and "$($p.Value)" -ne "") {
      return $p.Value
    }
  }

  return $null
}

function Get-AgentHome([string]$Root) {
  $candidates = @(
    (Join-Path $Root "openclaw-home"),
    (Join-Path $Root ".openclaw"),
    $env:HOME,
    $env:USERPROFILE
  )

  foreach ($c in $candidates) {
    if (![string]::IsNullOrWhiteSpace($c) -and (Test-Path $c)) {
      return (Resolve-Path $c).Path
    }
  }

  return $env:USERPROFILE
}

function Invoke-NodeChecked {
  param(
    [Parameter(Mandatory=$true)][string[]]$Arguments,
    [Parameter(Mandatory=$true)][string]$WorkingDirectory,
    [Parameter(Mandatory=$true)][string]$Label,
    [switch]$AllowValidJsonAfterCleanupAssertion
  )

  $nodeCmd = Get-Command node -ErrorAction SilentlyContinue

  if (!$nodeCmd) {
    Stop-Guide "Node.js not found in PATH."
  }

  $safeLabel = ($Label -replace '[^A-Za-z0-9_-]', '_')
  $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
  $stdoutPath = Join-Path $WorkingDirectory "$safeLabel-stdout-$stamp.txt"
  $stderrPath = Join-Path $WorkingDirectory "$safeLabel-stderr-$stamp.txt"

  Write-Host ""
  Info "Running node step: $Label"
  Info "WorkingDirectory: $WorkingDirectory"
  Info "stdout log: $stdoutPath"
  Info "stderr log: $stderrPath"

  $process = Start-Process `
    -FilePath $nodeCmd.Source `
    -ArgumentList $Arguments `
    -WorkingDirectory $WorkingDirectory `
    -RedirectStandardOutput $stdoutPath `
    -RedirectStandardError $stderrPath `
    -Wait `
    -PassThru

  $stdout = ""
  $stderr = ""

  if (Test-Path $stdoutPath) {
    $stdout = Get-Content $stdoutPath -Raw -ErrorAction SilentlyContinue
  }

  if (Test-Path $stderrPath) {
    $stderr = Get-Content $stderrPath -Raw -ErrorAction SilentlyContinue
  }

  $combined = ($stdout + "`n" + $stderr).Trim()
  $stdoutJson = ConvertFrom-MixedJsonText -Text $stdout

  $cleanupAssertion =
    ($stderr -match "Assertion failed") -and
    (
      $stderr -match "UV_HANDLE_CLOSING" -or
      $stderr -match "uv_close" -or
      $stderr -match "async\.c"
    )

  $hardFatalPatterns = @(
    "Cannot find module",
    "MODULE_NOT_FOUND",
    "UnhandledPromiseRejection",
    "TypeError:",
    "ReferenceError:",
    "SyntaxError:",
    "ERR_MODULE_NOT_FOUND",
    "ERR_REQUIRE_ESM"
  )

  $hardFatalHit = $false

  foreach ($pat in $hardFatalPatterns) {
    if ($combined -match [regex]::Escape($pat)) {
      $hardFatalHit = $true
    }
  }

  if ($hardFatalHit) {
    Write-Host ""
    Write-Host "=== NODE STEP HARD FAILED: $Label ===" -ForegroundColor Red
    Write-Host "ExitCode: $($process.ExitCode)"
    Write-Host ""
    Write-Host "--- stdout ---"
    Write-Host $stdout
    Write-Host ""
    Write-Host "--- stderr ---"
    Write-Host $stderr
    Write-Host ""
    Write-Host "Raw logs saved:"
    Write-Host $stdoutPath
    Write-Host $stderrPath
    Stop-Guide "Node dependency/runtime error. This is NOT a successful claim."
  }

  if ($process.ExitCode -ne 0) {
    if ($AllowValidJsonAfterCleanupAssertion -and $cleanupAssertion -and $null -ne $stdoutJson) {
      Write-Host ""
      Warn "Node exited with a cleanup assertion after producing valid JSON."
      Warn "The script will continue using stdout JSON, but this is still guarded."
      Warn "If amount=0 / Paid=false / claim_id / SUBMIT OK are not confirmed, it will stop."
      Write-Host ""
    } else {
      Write-Host ""
      Write-Host "=== NODE STEP FAILED: $Label ===" -ForegroundColor Red
      Write-Host "ExitCode: $($process.ExitCode)"
      Write-Host ""
      Write-Host "--- stdout ---"
      Write-Host $stdout
      Write-Host ""
      Write-Host "--- stderr ---"
      Write-Host $stderr
      Write-Host ""
      Write-Host "Raw logs saved:"
      Write-Host $stdoutPath
      Write-Host $stderrPath
      Stop-Guide "Node/buildX402Payment step failed. This is NOT a successful claim. Do not continue."
    }
  }

  return [pscustomobject]@{
    Stdout = $stdout
    Stderr = $stderr
    Combined = $combined
    StdoutJson = $stdoutJson
    StdoutPath = $stdoutPath
    StderrPath = $stderrPath
    ExitCode = $process.ExitCode
    CleanupAssertionAccepted = ($process.ExitCode -ne 0 -and $AllowValidJsonAfterCleanupAssertion -and $cleanupAssertion -and $null -ne $stdoutJson)
  }
}

Write-Host ""
Write-Host "gn1y Billions Tile Guide - Instant Free API Claim"
Write-Host "Mode: FREE CLAIM ONLY"
Write-Host "This script calls the x402 flow and immediately submits a fresh claim."
Write-Host "It must stop if only paid options are available."
Write-Host "Claim success requires SUBMIT OK and Proof saved to:"
Write-Host ""

if (!$AgentRoot) {
  $AgentRoot = Read-Host "Paste the full path to your OpenClaw agent folder"
}

if (!(Test-Path $AgentRoot)) {
  Stop-Guide "Agent folder not found: $AgentRoot"
}

$AgentRoot = (Resolve-Path $AgentRoot).Path

Write-Host "Agent folder:"
Write-Host $AgentRoot
Write-Host ""

$buildScripts = @(Get-ChildItem -Path $AgentRoot -Recurse -File -Filter "buildX402Payment.js" -ErrorAction SilentlyContinue)

if ($buildScripts.Count -eq 0) {
  Stop-Guide "buildX402Payment.js not found. Install or repair the official Billions Verified Agent Identity skill first."
}

if ($buildScripts.Count -gt 1) {
  Write-Host "Multiple buildX402Payment.js files found:"
  $buildScripts | ForEach-Object { Write-Host "- $($_.FullName)" }
  Write-Host ""
  Write-Host "Using the first one:"
}

$buildScript = $buildScripts[0].FullName
$buildDir = Split-Path $buildScript -Parent
$skillRoot = Split-Path $buildDir -Parent

Write-Host "Using buildX402Payment.js:"
Write-Host $buildScript
Write-Host ""

if (!(Test-Path (Join-Path $buildDir "getIdentities.js"))) {
  Stop-Guide "getIdentities.js not found. Official guardrail requires identity check before buildX402Payment.js."
}

if (!(Test-Path (Join-Path $buildDir "package.json"))) {
  Stop-Guide "scripts/package.json not found. Run safe skill upgrade/repair first."
}

if (!(Test-Path (Join-Path $buildDir "node_modules"))) {
  Stop-Guide "scripts/node_modules not found. Run npm install inside the skill scripts folder first."
}

$agentHome = Get-AgentHome $AgentRoot
$oldHome = $env:HOME
$env:HOME = $agentHome

Write-Host "Using HOME for this claim flow:"
Write-Host $env:HOME
Write-Host ""

Write-Host "Identity check before x402..."
$identityResult = Invoke-NodeChecked -Arguments @(".\getIdentities.js") -WorkingDirectory $buildDir -Label "identity-check"
$identityText = $identityResult.Stdout

Write-Host ""
Write-Host $identityText
Write-Host ""

if ($identityText -notmatch "did:" -and $identityText -notmatch '"did"\s*:') {
  Stop-Guide "No DID/default identity detected. Do not claim."
}

Write-Host "Continue only if DID/default identity/human link are correct for this agent."
Write-Host ""

$resource = "https://x402.billions.network/api/v1/canvas/current"
$submitUrl = "https://x402.billions.network/api/v1/tiles"

Write-Host "Phase1: requesting x402 challenge..."
Write-Host $resource

$phase1Result = Invoke-NodeChecked -Arguments @(".\buildX402Payment.js", "--resource", $resource) -WorkingDirectory $buildDir -Label "phase1-build-x402-payment" -AllowValidJsonAfterCleanupAssertion
$phase1Text = $phase1Result.Stdout

$phase1Path = Join-Path $buildDir ("phase1-stdout-" + (Get-Date -Format "yyyyMMdd-HHmmss") + ".txt")
$phase1Text | Set-Content -Encoding UTF8 $phase1Path

$phase1 = ConvertFrom-MixedJsonText -Text $phase1Text

if ($null -eq $phase1) {
  Write-Host $phase1Text
  Stop-Guide "Could not parse Phase1 stdout as JSON. Saved raw output to: $phase1Path"
}

$allPaymentCandidates = Find-ObjectsRecursive -Node $phase1 -Predicate {
  param($o)

  $amount = Get-PropValue -Object $o -Names @("amount", "maxAmountRequired", "value")
  $hash = Get-PropValue -Object $o -Names @("paymentHash", "hash")

  return ($null -ne $amount -and $null -ne $hash)
}

$paidCandidates = @()
$freeCandidates = @()

foreach ($candidate in $allPaymentCandidates) {
  $amount = Get-PropValue -Object $candidate -Names @("amount", "maxAmountRequired", "value")

  if ("$amount" -eq "0") {
    $freeCandidates += $candidate
  }

  $parsedAmount = 0
  $isNumber = [decimal]::TryParse("$amount", [ref]$parsedAmount)

  if ("$amount" -eq "10000000" -or ($isNumber -and $parsedAmount -gt 0)) {
    $paidCandidates += $candidate
  }
}

if ($freeCandidates.Count -eq 0) {
  if ($paidCandidates.Count -gt 0) {
    Stop-Guide "No free amount=0 option found. Paid option exists. Do not continue unless intentionally doing paid claim."
  }

  Write-Host $phase1Text
  Stop-Guide "No free amount=0 option found in Phase1 output."
}

$free = $freeCandidates[0]
$freeAmount = Get-PropValue -Object $free -Names @("amount", "maxAmountRequired", "value")
$freePaymentHash = Get-PropValue -Object $free -Names @("paymentHash", "hash")

if ("$freeAmount" -ne "0") {
  Stop-Guide "Selected option is not free. Amount: $freeAmount"
}

$paymentRequiredFileObjects = Find-ObjectsRecursive -Node $phase1 -Predicate {
  param($o)

  $file = Get-PropValue -Object $o -Names @("paymentRequiredFilePath", "paymentRequirementsFilePath", "paymentFilePath")

  return ($null -ne $file)
}

$paymentRequiredFilePath = $null

if ($paymentRequiredFileObjects.Count -gt 0) {
  $paymentRequiredFilePath = Get-PropValue -Object $paymentRequiredFileObjects[0] -Names @("paymentRequiredFilePath", "paymentRequirementsFilePath", "paymentFilePath")
}

if (!$freePaymentHash) {
  Write-Host $phase1Text
  Stop-Guide "Free paymentHash not found."
}

if (!$paymentRequiredFilePath) {
  Write-Host $phase1Text
  Stop-Guide "paymentRequiredFilePath not found."
}

if (!(Test-Path $paymentRequiredFilePath)) {
  Stop-Guide "paymentRequiredFilePath does not exist on disk: $paymentRequiredFilePath"
}

Write-Host ""
Write-Host "Free option selected:"
Write-Host "amount=0"
Write-Host "Paid=false"
Write-Host "paymentHash=$freePaymentHash"
Write-Host "paymentRequiredFilePath=$paymentRequiredFilePath"
Write-Host ""

Write-Host "Phase2: building fresh claim..."

$phase2Result = Invoke-NodeChecked -Arguments @(".\buildX402Payment.js", "--paymentRequiredFilePath", "$paymentRequiredFilePath", "--paymentHash", "$freePaymentHash") -WorkingDirectory $buildDir -Label "phase2-build-fresh-claim" -AllowValidJsonAfterCleanupAssertion
$phase2Text = $phase2Result.Stdout

$phase2Path = Join-Path $buildDir ("phase2-stdout-" + (Get-Date -Format "yyyyMMdd-HHmmss") + ".txt")
$phase2Text | Set-Content -Encoding UTF8 $phase2Path

$phase2 = ConvertFrom-MixedJsonText -Text $phase2Text

if ($null -eq $phase2) {
  Write-Host $phase2Text
  Stop-Guide "Could not parse Phase2 stdout as JSON. Saved raw output to: $phase2Path"
}

$claimId = $null
$expiresAt = $null

$claimObjects = Find-ObjectsRecursive -Node $phase2 -Predicate {
  param($o)

  $cid = Get-PropValue -Object $o -Names @("claim_id", "claimId", "id")

  return ($cid -and "$cid" -match "^clm_[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
}

if ($claimObjects.Count -gt 0) {
  $claimId = Get-PropValue -Object $claimObjects[0] -Names @("claim_id", "claimId", "id")
  $expiresAt = Get-PropValue -Object $claimObjects[0] -Names @("expires_at", "expiresAt", "expires")
}

if (!$claimId) {
  $m = [regex]::Match($phase2Text, "clm_[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}")

  if ($m.Success) {
    $claimId = $m.Value
  }
}

if (!$claimId) {
  Write-Host $phase2Text
  Stop-Guide "Fresh claim_id not found."
}

Write-Host "Fresh claim_id:"
Write-Host $claimId

if ($expiresAt) {
  Write-Host "Claim expires_at:"
  Write-Host $expiresAt

  try {
    $expiresDate = [DateTimeOffset]::Parse("$expiresAt")
    $secondsLeft = ($expiresDate - [DateTimeOffset]::UtcNow).TotalSeconds
    Write-Host ("Seconds left: {0:N1}" -f $secondsLeft)

    if ($secondsLeft -lt 30) {
      Stop-Guide "Claim is too close to expiry. Run the script again to get a fresh claim."
    }
  } catch {
    Write-Host "Could not parse expires_at, continuing immediately."
  }
}

Write-Host ""
Write-Host "Submitting tile immediately..."

$cleanIntent = ($Intent -replace "[^A-Za-z ]", " ").Trim()

if (!$cleanIntent) {
  $cleanIntent = "AI agent movie tile claim"
}

$body = @{
  claim_id = $claimId
  genome = @{
    intent = $cleanIntent
  }
}

$bodyJson = $body | ConvertTo-Json -Depth 10 -Compress

Write-Host "Submit body:"
Write-Host $bodyJson
Write-Host ""

try {
  $submitResult = Invoke-RestMethod -Uri $submitUrl -Method Post -ContentType "application/json" -Body $bodyJson
} catch {
  Write-Host ""
  Write-Host "Submit failed."
  Write-Host $_.Exception.Message

  if ($_.ErrorDetails -and $_.ErrorDetails.Message) {
    Write-Host $_.ErrorDetails.Message
  }

  Stop-Guide "Tile submit failed. Do not reuse this claim manually if it expired. Run a fresh flow."
}

$proofPath = Join-Path $buildDir ("tile-proof-" + (Get-Date -Format "yyyyMMdd-HHmmss") + ".json")
$submitResult | ConvertTo-Json -Depth 20 | Set-Content -Encoding UTF8 $proofPath

Write-Host ""
Write-Host "SUBMIT OK"
Write-Host "Paid=false"
Write-Host "amount=0"
Write-Host "Proof saved to:"
Write-Host $proofPath
Write-Host ""

$submitResult | ConvertTo-Json -Depth 20

Write-Host ""
Write-Host "Save your proof:"
Write-Host "- Tile ID"
Write-Host "- Tx hash"
Write-Host "- Agent address"
Write-Host "- DID"
Write-Host "- Canvas ID"
Write-Host "- X/Y coordinates"
Write-Host "- Claim date"
Write-Host ""
Write-Host "Never share seed phrases, private keys, wallet keys, kms.json, or sensitive identity data."
Write-Host ""

if (![string]::IsNullOrWhiteSpace($oldHome)) {
  $env:HOME = $oldHome
}

exit 0