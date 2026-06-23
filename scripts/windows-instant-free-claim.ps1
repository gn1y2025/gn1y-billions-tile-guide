param(
  [string]$AgentRoot,
  [string]$Intent = "AI agent movie tile claim"
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "gn1y Billions Tile Guide - Instant Free API Claim"
Write-Host "Mode: FREE CLAIM ONLY"
Write-Host "This script calls the x402 flow and immediately submits a fresh claim."
Write-Host "It must stop if only paid options are available."
Write-Host ""

function Stop-Guide([string]$Message) {
  Write-Host ""
  Write-Host "STOP: $Message"
  Write-Host ""
  exit 1
}

function ConvertFrom-MixedJsonText {
  param([string]$Text)

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

if (!$AgentRoot) {
  $AgentRoot = Read-Host "Paste the full path to your OpenClaw agent folder"
}

if (!(Test-Path $AgentRoot)) {
  Stop-Guide "Agent folder not found: $AgentRoot"
}

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

Write-Host "Using buildX402Payment.js:"
Write-Host $buildScript
Write-Host ""

$node = Get-Command node -ErrorAction SilentlyContinue

if (!$node) {
  Stop-Guide "Node.js not found."
}

$proofDir = Join-Path $env:USERPROFILE "gn1y-tile-proofs"
New-Item -ItemType Directory -Force -Path $proofDir | Out-Null

Push-Location $buildDir

try {
  Write-Host "Identity check before x402..."
  Write-Host ""

  if (!(Test-Path ".\getIdentities.js")) {
    Stop-Guide "getIdentities.js not found. Official guardrail requires identity check before buildX402Payment.js."
  }

  $identityRaw = & node ".\getIdentities.js" 2>&1
  $identityText = ($identityRaw | Out-String)

  if ($LASTEXITCODE -ne 0) {
    Write-Host $identityText
    Stop-Guide "getIdentities.js failed. Do not continue."
  }

  Write-Host $identityText
  Write-Host ""
  Write-Host "Continue only if DID/default identity/human link are correct for this agent."
  Write-Host ""

  $resource = "https://x402.billions.network/api/v1/canvas/current"
  $submitUrl = "https://x402.billions.network/api/v1/tiles"

  Write-Host "Phase1: requesting x402 challenge..."
  Write-Host $resource
  Write-Host ""

  $phase1Raw = & node ".\buildX402Payment.js" --resource $resource 2>&1
  $phase1Text = ($phase1Raw | Out-String)
  $phase1Path = Join-Path $proofDir ("phase1-" + (Get-Date -Format "yyyyMMdd-HHmmss") + ".txt")
  $phase1Text | Set-Content -Encoding UTF8 $phase1Path

  $phase1 = ConvertFrom-MixedJsonText -Text $phase1Text

  if ($null -eq $phase1) {
    Write-Host $phase1Text
    Stop-Guide "Could not parse Phase1 output as JSON. Saved raw output to: $phase1Path"
  }

  $allPaymentCandidates = Find-ObjectsRecursive -Node $phase1 -Predicate {
    param($o)

    $amount = Get-PropValue -Object $o -Names @("amount", "maxAmountRequired", "value")
    $hash = Get-PropValue -Object $o -Names @("paymentHash", "hash")
    $file = Get-PropValue -Object $o -Names @("paymentRequiredFilePath", "paymentRequirementsFilePath", "paymentFilePath")

    return ($null -ne $amount -and ($null -ne $hash -or $null -ne $file))
  }

  $paidCandidates = @()
  $freeCandidates = @()

  foreach ($candidate in $allPaymentCandidates) {
    $amount = Get-PropValue -Object $candidate -Names @("amount", "maxAmountRequired", "value")

    if ("$amount" -eq "0") {
      $freeCandidates += $candidate
    }

    $parsedAmount = [decimal]0
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
  $paymentRequiredFilePath = Get-PropValue -Object $free -Names @("paymentRequiredFilePath", "paymentRequirementsFilePath", "paymentFilePath")

  if ("$freeAmount" -ne "0") {
    Stop-Guide "Selected option is not free. Amount: $freeAmount"
  }

  if (!$freePaymentHash) {
    $freePaymentHash = Get-PropValue -Object $phase1 -Names @("paymentHash", "hash")
  }

  if (!$paymentRequiredFilePath) {
    $paymentRequiredFilePath = Get-PropValue -Object $phase1 -Names @("paymentRequiredFilePath", "paymentRequirementsFilePath", "paymentFilePath")
  }

  if (!$freePaymentHash) {
    Write-Host $phase1Text
    Stop-Guide "Free paymentHash not found."
  }

  if (!$paymentRequiredFilePath) {
    Write-Host $phase1Text
    Stop-Guide "paymentRequiredFilePath not found."
  }

  Write-Host "Free option selected:"
  Write-Host "amount=0"
  Write-Host "paymentHash=$freePaymentHash"
  Write-Host "paymentRequiredFilePath=$paymentRequiredFilePath"
  Write-Host ""

  Write-Host "Phase2: building fresh claim..."
  Write-Host ""

  $phase2Raw = & node ".\buildX402Payment.js" --paymentRequiredFilePath "$paymentRequiredFilePath" --paymentHash "$freePaymentHash" 2>&1
  $phase2Text = ($phase2Raw | Out-String)
  $phase2Path = Join-Path $proofDir ("phase2-" + (Get-Date -Format "yyyyMMdd-HHmmss") + ".txt")
  $phase2Text | Set-Content -Encoding UTF8 $phase2Path

  $phase2 = ConvertFrom-MixedJsonText -Text $phase2Text

  if ($null -eq $phase2) {
    Write-Host $phase2Text
    Stop-Guide "Could not parse Phase2 output as JSON. Saved raw output to: $phase2Path"
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
  Write-Host ""

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

  $proofPath = Join-Path $proofDir ("tile-proof-" + (Get-Date -Format "yyyyMMdd-HHmmss") + ".json")
  $submitResult | ConvertTo-Json -Depth 20 | Set-Content -Encoding UTF8 $proofPath

  Write-Host ""
  Write-Host "SUBMIT OK"
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
}
finally {
  Pop-Location
}