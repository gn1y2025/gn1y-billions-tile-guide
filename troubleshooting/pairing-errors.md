# Pairing Errors

Common errors while linking an OpenClaw agent to a verified Billions human account.

---

## Pairing link expired

### Meaning

The verification/pairing link is no longer valid.

### Fix

Generate a new pairing link:

```powershell
$AGENT_NAME = Read-Host "Agent name"
$AGENT_DESCRIPTION = Read-Host "Short agent description"

$challenge = @{
  name = $AGENT_NAME
  description = $AGENT_DESCRIPTION
} | ConvertTo-Json -Compress

node scripts/manualLinkHumanToAgent.js --challenge $challenge
```

Open the new link immediately.

Do not reuse old pairing links.

---

## Pairing link does not open

### Possible causes

- browser issue;
- expired link;
- copied incomplete link;
- network issue;
- Billions service issue.

### Fix

Copy the full link again.

Try another browser.

Generate a fresh link if needed.

---

## Human verification is not completed

### Meaning

The agent cannot be fully linked to a verified human yet.

### Fix

Complete human verification in the official Billions app/flow.

Then repeat the agent-human linking step.

---

## Pairing shows wrong agent

### Meaning

The challenge may contain wrong agent name/description or you are using the wrong agent folder.

### Fix

Stop.

Do not confirm pairing.

Check:

```powershell
Write-Host $AGENT_ROOT
Write-Host $SKILL_DIR
```

Generate a new pairing link for the correct agent.

---

## Pairing link came from another person

### Meaning

This is unsafe.

### Fix

Stop.

Only use pairing links generated locally from your intended agent setup.

Do not use links from Discord DMs, Telegram, unknown websites, or another user.

---

## Agent linked but claim still does not work

### Possible causes

- explorer/indexing delay;
- claim flow cannot detect identity yet;
- wrong agent folder;
- wrong DID;
- free claim already used;
- campaign rule blocks the claim.

### Fix

Confirm:

```text
Agent identity: exists
DID: visible
Human link: verified
Agent address: visible
```

Then retry the official claim flow later.

If it still fails, ask official support using the support question template.
