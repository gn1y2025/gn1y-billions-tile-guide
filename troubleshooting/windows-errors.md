# Windows Errors

Common Windows / PowerShell issues while preparing an OpenClaw agent for Billions AI Agentic Movie Tiles.

---

## `git` is not recognized

### Meaning

Git is not installed or PowerShell cannot find it.

### Fix

```powershell
winget install --id Git.Git -e --source winget
```

Close PowerShell, open it again, then run:

```powershell
git --version
```

Expected result:

```text
git version ...
```

---

## `node`, `npm`, or `npx` is not recognized

### Meaning

Node.js is not installed or the terminal was not restarted after installation.

### Fix

Install OpenClaw using the official installer because it can install the required Node environment:

```powershell
iwr -useb https://openclaw.ai/install.ps1 | iex
```

Close PowerShell, open it again, then run:

```powershell
node -v
npm -v
npx -v
```

Expected result:

```text
Each command should return a version number.
```

---

## `openclaw` is not recognized

### Meaning

OpenClaw is not installed or not available in PATH.

### Fix

```powershell
iwr -useb https://openclaw.ai/install.ps1 | iex
```

Close PowerShell, open it again, then run:

```powershell
openclaw --version
```

If it still does not work, run:

```powershell
openclaw onboard --install-daemon
```

---

## PowerShell shows `>>` and looks stuck

### Meaning

PowerShell is waiting for you to finish a multi-line command or text block.

### Fix

Press:

```text
Ctrl + C
```

Then check your current folder:

```powershell
Get-Location
git status
```

Do not continue pasting random commands until you are back at the normal prompt:

```text
PS C:\...\>
```

---

## `LF will be replaced by CRLF`

### Meaning

Git is warning about Windows line endings.

### Fix

Usually no action is needed.

This warning is normal on Windows and does not break the guide.

---

## Permission denied / access denied

### Possible causes

- PowerShell does not have permission.
- Antivirus blocked the command.
- You are writing to a protected folder.
- You opened PowerShell without enough permissions for installation.

### Fix

First, try running PowerShell normally from a user-owned folder.

If an official installer requires it, run PowerShell as Administrator.

Do not bypass security warnings for unknown scripts.

---

## `npm install` fails

### Possible causes

- wrong folder;
- no `package.json`;
- internet issue;
- Node.js issue;
- npm cache issue;
- permissions issue.

### Fix

Make sure you are inside the `verified-agent-identity` skill folder:

```powershell
Get-Location
Get-ChildItem
```

You should see:

```text
package.json
scripts
```

Then run:

```powershell
npm install
```

If it still fails:

```powershell
npm cache verify
npm install
```

Do not run `npm install` from:

- disk root;
- wallet folder;
- browser profile folder;
- backup folder;
- wrong agent folder.

---

## Agent folder not found

### Meaning

The path you pasted does not exist.

### Fix

Check the folder manually in File Explorer.

Then paste the full path again:

```powershell
$AGENT_ROOT = Read-Host "Paste the full path to your OpenClaw agent folder"

if (!(Test-Path $AGENT_ROOT)) {
  throw "Agent folder not found. Check the path and try again."
}

Set-Location $AGENT_ROOT
```

Do not use somebody else’s local path from a guide.
