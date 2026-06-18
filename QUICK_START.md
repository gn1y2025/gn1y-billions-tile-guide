# Quick Start

Choose your setup and follow the correct guide.

Default mode:

**FREE CLAIM ONLY**

Stop immediately if you see:

- `10 USDC`;
- `amount=10000000`;
- any amount above `0`;
- seed phrase request;
- private key request;
- unlimited approval request;
- wrong DID;
- wrong agent address.

---

<details>
<summary><strong>Step 0 — New user / no agent yet</strong></summary>

Start here:

[Create an OpenClaw Agent](./guides/create-agent.md)

You need:

```text
Node.js 24 recommended
OpenClaw installed
OpenClaw onboarding completed
model provider API key configured
Gateway running
Dashboard opening
one correct OpenClaw agent selected
```

Useful checks:

```bash
node -v
openclaw --version
openclaw gateway status
openclaw dashboard
openclaw agents list --bindings
```

</details>

---

<details>
<summary><strong>Step 1 — KMS security before identity creation</strong></summary>

Read:

[KMS Security](./guides/kms-security.md)

Important:

- Billions identity data may live in `$HOME/.openclaw/billions`;
- `kms.json` is sensitive;
- do not upload `kms.json`;
- do not commit identity backups;
- use `BILLIONS_NETWORK_MASTER_KMS_KEY` before creating/importing identity if you want encrypted key storage.

</details>

---

<details>
<summary><strong>Windows PowerShell</strong></summary>

Use this guide:

[Windows Guide](./guides/windows.md)

Optional preflight script:

```powershell
cd path\to\gn1y-billions-tile-guide
.\scripts\windows-preflight.ps1
```

Quick check:

```powershell
git --version
node -v
npm -v
npx -v
openclaw --version
openclaw gateway status
```

</details>

---

<details>
<summary><strong>Linux Terminal</strong></summary>

Use this guide:

[Linux Guide](./guides/linux.md)

Optional preflight script:

```bash
bash ./scripts/linux-preflight.sh
```

Quick check:

```bash
git --version
curl --version
node -v
npm -v
npx -v
openclaw --version
openclaw gateway status
```

</details>

---

<details>
<summary><strong>macOS Terminal</strong></summary>

Use this guide:

[macOS Guide](./guides/macos.md)

Optional preflight script:

```bash
bash ./scripts/macos-preflight.sh
```

Quick check:

```bash
git --version
curl --version
node -v
npm -v
npx -v
openclaw --version
openclaw gateway status
```

</details>

---

<details>
<summary><strong>AI Agent Chat Mode</strong></summary>

Use this guide:

[AI Agent Chat Mode](./guides/agent-chat-mode.md)

This mode is for humans who want to paste clear safety-first instructions into an AI agent chat.

The agent must stop before:

- any paid claim;
- unclear action;
- wrong DID;
- wrong agent address;
- seed/private key request.

</details>

---

<details>
<summary><strong>Instant API Free Claim</strong></summary>

Use this guide:

[Instant API Claim](./guides/instant-api-claim.md)

This is the one-shot terminal flow:

```text
Phase1 -> select free amount=0 -> Phase2 -> fresh claim_id -> immediate POST /api/v1/tiles
```

Important:

- claim may expire in around 5 minutes;
- do not pause between Phase2 and submit;
- do not reuse old claims;
- stop if you see `10 USDC` or `amount=10000000`;
- run `getIdentities.js` before `buildX402Payment.js`;
- treat this script as experimental until tested on a safe agent.

Windows script:

```powershell
.\scripts\windows-instant-free-claim.ps1
```

</details>

---

<details>
<summary><strong>Paid Tile Claim</strong></summary>

Use this guide:

[Paid Tile Guide](./guides/paid-tile.md)

Paid tile claim is optional and spends real funds.

Paid claims do not guarantee FAIAR rewards, airdrop allocation, leaderboard rewards, or profit.

</details>

---

<details>
<summary><strong>Troubleshooting</strong></summary>

Use this section if something fails:

[Troubleshooting](./TROUBLESHOOTING.md)

Main sections:

- [Windows errors](./troubleshooting/windows-errors.md)
- [Identity errors](./troubleshooting/identity-errors.md)
- [Pairing errors](./troubleshooting/pairing-errors.md)
- [Claim errors](./troubleshooting/claim-errors.md)
- [Paid claim safety](./troubleshooting/paid-claim-safety.md)

</details>
