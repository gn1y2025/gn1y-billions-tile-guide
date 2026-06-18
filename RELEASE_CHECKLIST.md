# Release Checklist

Use this checklist before making the repository public or sharing it in Discord/X.

---

## 1. Git status

```powershell
git status
git log --oneline --decorate -n 10
git ls-tree -r --name-only HEAD
```

Expected:

```text
nothing to commit, working tree clean
```

---

## 2. Secret scan

Windows PowerShell:

```powershell
Select-String -Path *.md,guides\*.md,troubleshooting\*.md,templates\*.md,scripts\*.ps1,scripts\*.sh -Pattern "andriylenyk|gmail.com|C:\\Users|D:\\agents|BEGIN .*PRIVATE KEY|PRIVATE KEY-----|seed phrase:|private key:|mnemonic:|BILLIONS_NETWORK_MASTER_KMS_KEY\s*=\s*['""][^'""]+['""]|0x[a-fA-F0-9]{64}" -AllMatches -ErrorAction SilentlyContinue
```

Expected:

```text
No real secrets. Replace placeholder scan markers with your own local sensitive patterns before release.
Only warning text is acceptable.
```

---

## 3. Required files

Check that these files exist:

```text
README.md
START_HERE.md
QUICK_START.md
SECURITY.md
DISCLAIMER.md
FAQ.md
RELEASE_CHECKLIST.md
.nvmrc

guides/existing-agent-status.md
guides/create-agent.md
guides/kms-security.md
guides/windows.md
guides/linux.md
guides/macos.md
guides/agent-chat-mode.md
guides/paid-tile.md
guides/instant-api-claim.md

scripts/windows-preflight.ps1
scripts/linux-preflight.sh
scripts/macos-preflight.sh
scripts/windows-instant-free-claim.ps1

troubleshooting/windows-errors.md
troubleshooting/identity-errors.md
troubleshooting/pairing-errors.md
troubleshooting/claim-errors.md
troubleshooting/paid-claim-safety.md

templates/proof-template.md
templates/feedback-template.md
templates/support-question-template.md
```

---

## 4. Manual GitHub visual check

Open GitHub and check:

- README renders correctly;
- links work;
- `<details>` sections expand/collapse;
- code blocks are readable;
- old redirect files lead to new guide files;
- no private screenshots are published.

---

## 5. API claim safety check

Before recommending instant API claim publicly, test on one safe agent.

Expected safety behavior:

- script runs `getIdentities.js` first;
- script finds only `amount=0`;
- script stops on `10 USDC`;
- script stops on `amount=10000000`;
- script does not ask for seed phrase;
- script does not ask for private key;
- script immediately submits fresh `claim_id`;
- proof JSON is saved locally;
- result shows `paid: false` if field exists.

---

## 6. Scope check

README must clearly say:

- unofficial community guide;
- no reward guarantee;
- free claim only by default;
- paid claim optional and risky;
- does not bypass Billions rules;
- not for farming identities;
- does not guarantee FAIAR;
- does not replace official Billions/OpenClaw docs.

---

## 7. Final release decision

Release only when:

```text
working tree clean
secret scan clean
links work
README looks good
create-agent guide exists
KMS security guide exists
getIdentities check documented
instant claim script tested or clearly marked as experimental
```


