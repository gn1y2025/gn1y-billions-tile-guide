# Security

Safety is the most important part of this guide.

Default mode:

**FREE CLAIM ONLY**

## Never share

Never share:

- seed phrase;
- private key;
- wallet export;
- `kms.json`;
- identity backup files;
- browser profile data;
- full screenshots with sensitive wallet/account data.

## Wallet safety

Use a separate wallet or identity key for agent activity.

Do not use your main wallet with valuable assets.

Do not paste seed phrases or private keys into:

- terminal;
- website;
- Discord;
- Telegram;
- AI agent chat;
- GitHub issue;
- Google form;
- unknown script.

## Billions identity storage

Billions Verified Agent Identity may store sensitive data in:

```text
$HOME/.openclaw/billions
```

This can include:

```text
kms.json
identities.json
defaultDid.json
credentials.json
challenges.json
profiles.json
```

Do not upload this directory publicly.

Do not commit it to GitHub.

Do not send it to anyone.

Read:

[KMS Security](./guides/kms-security.md)

## KMS encryption

Use `BILLIONS_NETWORK_MASTER_KMS_KEY` before identity creation if you want encrypted key storage.

Do not use seed phrase or wallet private key as KMS secret.

If you lose the KMS secret, encrypted identity keys may become unusable.

## Identity safety

Do not copy identity files from another agent.

Do not publish identity backups.

Do not upload `kms.json`.

Do not delete identity files unless you have a backup and understand the consequences.

Before link/sign/x402 actions, check identity first:

```bash
node scripts/getIdentities.js
```

Stop if:

- DID is missing;
- agent address is wrong;
- human link is not verified;
- identity belongs to another agent.

## Paid claim safety

Stop immediately if you wanted a free claim but see:

```text
10 USDC
amount=10000000
any amount greater than 0
```

Paid claim is allowed only if the human intentionally confirms it.

An AI agent must not perform paid claims automatically.

## Support safety

When asking for help, do not share:

- seed phrase;
- private key;
- wallet files;
- `kms.json`;
- identity backup files;
- full sensitive screenshots.

Use:

[Support question template](./templates/support-question-template.md)

## Final rule

If you are unsure what a command, website, wallet popup, or AI agent action does:

**STOP.**
