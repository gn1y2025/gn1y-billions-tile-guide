# Windows Agent Doctor

This is the first command most Windows users should run.

It audits your PC and tells you where to go next in this repository.

---

## Fast run

Open PowerShell and paste:

```powershell
irm https://raw.githubusercontent.com/gn1y2025/gn1y-billions-tile-guide/main/scripts/windows-agent-doctor.ps1 | iex
```

---

## What it checks

```text
agent folder
verified-agent-identity skill
x402-ready files
getIdentities.js
buildX402Payment.js
DID output
human link hints
```

---

## What it does not do

```text
It does not claim Tiles.
It does not spend funds.
It does not update skill.
It does not delete files.
```

---

## If you know your agent folder

Clone/download mode is optional.

If running the script locally:

```powershell
.\scripts\windows-agent-doctor.ps1 -AgentRoot "FULL_PATH_TO_YOUR_AGENT_FOLDER"
```

---

## After it finishes

Read the final section:

```text
WHAT TO DO NEXT
```

Then open the exact file it prints.
