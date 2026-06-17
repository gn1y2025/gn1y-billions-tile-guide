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
