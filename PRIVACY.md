# Privacy and Redaction

Before sharing terminal logs publicly, remove anything you do not want connected to you.

This guide is public. Your logs may contain personal or linkable information.

---

## Never share

Never share:

```text
seed phrase
private key
kms.json
.env files
API keys
full secrets
```

---

## Redact before posting logs

Redact or partially hide:

```text
local Windows username
local folder paths
wallet addresses if you want privacy
DID values if you want privacy
publicKeyHex
agent IDs
tx hashes if you want privacy
email addresses
personal names
```

Example:

```text
Before:
C:\Users\Andrii\Desktop\agent
DID: did:iden3:...
publicKeyHex: 0xabc123...
wallet: 0x1234567890abcdef...

After:
C:\Users\<REDACTED>\Desktop\<AGENT_FOLDER>
DID: <REDACTED_DID>
publicKeyHex: <REDACTED_PUBLIC_KEY>
wallet: 0x1234...abcd
```

---

## Safe information to share

Usually safe to share:

```text
which guide step failed
which file was missing
whether buildX402Payment.js exists
whether amount was 0 or not
general error message
```

---

## If asking for help

Use this style:

```text
I ran Windows Agent Doctor.
Result: SKILL OUTDATED.
Missing: scripts/buildX402Payment.js.
Next step shown: guides/update-identity-skill.md.
I need help with the update step.
```

Do not paste full raw logs unless you redacted them first.
