# KMS Security

Security hardening for Billions Verified Agent Identity.

This guide is unofficial.

---

## Why this matters

Billions Verified Agent Identity stores sensitive identity data locally.

The important storage location is:

```text
$HOME/.openclaw/billions
```

This is outside the normal agent workspace.

That means backing up only the agent folder may **not** back up the real identity storage.

---

## Sensitive files

The Billions identity storage may include:

```text
kms.json
identities.json
defaultDid.json
challenges.json
credentials.json
profiles.json
```

The most sensitive file is:

```text
kms.json
```

Never upload it.

Never commit it to GitHub.

Never send it in Discord, Telegram, GitHub issues, Google Forms, or AI chats.

---

## KMS encryption

The Billions skill supports:

```text
BILLIONS_NETWORK_MASTER_KMS_KEY
```

When this environment variable is set, private key values inside `kms.json` can be encrypted at rest.

When it is not set, the storage may use plaintext mode.

The KMS secret is **not** a seed phrase and **not** a wallet private key.

Use a strong unique secret and store it safely.

If you lose the KMS secret, encrypted identity keys may become unusable.

---

## Windows PowerShell one-session setup

Run this in the same PowerShell session before creating identity:

```powershell
$secure = Read-Host "Enter a strong local Billions KMS secret. Do not use seed phrase or wallet key" -AsSecureString
$ptr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
$env:BILLIONS_NETWORK_MASTER_KMS_KEY = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($ptr)
[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr)

node scripts/createNewEthereumIdentity.js
node scripts/getIdentities.js
```

This sets the variable only for the current PowerShell session.

---

## Linux / macOS one-session setup

Run this in the same Terminal session before creating identity:

```bash
read -s -p "Enter a strong local Billions KMS secret. Do not use seed phrase or wallet key: " BILLIONS_NETWORK_MASTER_KMS_KEY
export BILLIONS_NETWORK_MASTER_KMS_KEY
echo ""

node scripts/createNewEthereumIdentity.js
node scripts/getIdentities.js
```

After first run, restrict local storage permissions:

```bash
mkdir -p ~/.openclaw/billions
chmod 700 ~/.openclaw/billions
```

---

## Important backup note

Do not upload backups publicly.

Do not put backups inside Git.

Do not rely only on the agent workspace backup.

The identity storage may live here:

```text
$HOME/.openclaw/billions
```

If you back it up, keep the backup encrypted and offline.

---

## Stop conditions

Stop if:

- you do not understand what KMS secret means;
- you are about to use a seed phrase or wallet key as KMS secret;
- you are about to upload `kms.json`;
- you are about to copy identity from another agent;
- you lost the KMS secret and cannot decrypt old identity data.

When unsure:

**STOP and ask for help.**

