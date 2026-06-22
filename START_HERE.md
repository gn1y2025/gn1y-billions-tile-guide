# Start Here

The easiest path is:

```text
COMMAND_CENTER.md
```

Open:

[Command Center](./COMMAND_CENTER.md)

Run Windows Agent Doctor first.

---

## Why Agent Doctor first?

Because users can be in different states:

```text
No agent
Agent exists but no identity skill
Agent has old identity skill
Agent has skill but no DID
Agent has DID but human link is missing
Agent is ready to claim free Tile
```

Agent Doctor checks this and prints the next file to open.

---

## Routes

### Route A — I already have an agent

Run:

[Windows Agent Doctor](./guides/windows-agent-doctor.md)

Then follow terminal output.

---

### Route B — I do not have an agent

Open:

[Create an OpenClaw Agent](./guides/create-agent.md)

After creation, run Agent Doctor.

---

### Route C — Doctor says ready

Open:

[Free Claim Copy-Paste Windows](./guides/free-claim-copy-paste-windows.md)

---

## Stop signs

```text
10 USDC
amount=10000000
any amount greater than 0
wrong DID
wrong agent address
unverified human link
private key request
seed phrase request
```
