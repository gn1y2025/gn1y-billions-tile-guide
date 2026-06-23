# Identity Errors

Common errors related to Billions Verified Agent Identity skill, DID, and agent identity.

---

## `verified-agent-identity` skill folder not found

### Meaning

The official Billions Verified Agent Identity skill is not installed in the selected agent folder.

### Fix

From your agent folder, try:

```powershell
openclaw skills install verified-agent-identity
```

If that fails, try:

```powershell
npx skills add BillionsNetwork/verified-agent-identity
```

Then search again:

```powershell
$SKILL_DIR = Get-ChildItem -Path $AGENT_ROOT -Recurse -Directory -Filter "verified-agent-identity" -ErrorAction SilentlyContinue |
  Select-Object -First 1 -ExpandProperty FullName

$SKILL_DIR
```

Stop if the skill folder is still missing.

---

## `package.json` not found inside skill folder

### Meaning

You are probably in the wrong folder or the skill installation is incomplete.

### Fix

Find the exact skill folder:

```powershell
Get-ChildItem -Path $AGENT_ROOT -Recurse -Directory -Filter "verified-agent-identity"
```

Go into the folder that contains `package.json`.

Then run:

```powershell
npm install
```

---

## `createNewEthereumIdentity.js` not found

### Meaning

The installed skill may be incomplete, outdated, or not the expected Billions skill.

### Fix

Check:

```powershell
Get-ChildItem scripts
```

If the script is missing, reinstall the official skill.

Do not download random files from Discord DMs.

---

## Identity creation fails

### Possible causes

- you are in the wrong folder;
- dependencies are not installed;
- Node.js version issue;
- skill installation is broken.

### Fix

Inside the skill folder:

```powershell
npm install
node scripts/createNewEthereumIdentity.js
```

If it still fails, save the exact error text and ask official support.

Do not share private keys, seed phrases, wallet files, or `kms.json`.

---

## DID is missing

### Meaning

The agent identity was not created or the wrong identity is active.

### Fix

Run identity creation again only if you are sure this is the correct agent:

```powershell
node scripts/createNewEthereumIdentity.js
```

Then check the skill output again.

Do not copy DID or identity files from another agent.

---

## Wrong DID or wrong agent address

### Meaning

You may be using the wrong agent folder, wrong skill folder, or wrong identity.

### Fix

Stop.

Do not claim a tile.

Check:

```powershell
Write-Host $AGENT_ROOT
Write-Host $SKILL_DIR
```

Confirm that:

- this is the intended agent folder;
- this is the intended skill folder;
- the identity belongs to this agent;
- the DID and agent address match the intended agent.

---

## Multiple identities found

### Meaning

The agent may have more than one identity.

### Fix

Do not guess.

Use the identity marked as default only if you are sure.

If unsure, stop and ask official support.

Do not delete identity files unless you have a safe backup and understand the consequences.

---

## Accidentally copied identity from another agent

### Meaning

This can link the wrong agent, wrong DID, or wrong owner.

### Fix

Stop.

Do not claim.

Restore from a backup if available.

Create a fresh identity only for the intended agent.

Never copy identity between different agents.

---

## KMS secret missing or misunderstood

### Meaning

Billions identity storage can use `BILLIONS_NETWORK_MASTER_KMS_KEY` to encrypt private key values inside `kms.json`.

If the variable is not set, storage may use plaintext mode.

### Fix

Read:

```text
guides/kms-security.md
```

Set the KMS secret before creating/importing identity.

Do not use seed phrase or wallet private key as KMS secret.

If you lose the KMS secret, encrypted keys may become unusable.

---

## `getIdentities.js` missing

### Meaning

The installed skill may be incomplete, outdated, or not the official `verified-agent-identity` skill.

### Fix

Stop.

Repair or reinstall the official skill.

Do not continue to `manualLinkHumanToAgent.js` or `buildX402Payment.js` without identity check.
