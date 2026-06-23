# Paid Claim Safety

Safety rules for optional paid tile claim.

Default guide mode is:

```text
FREE CLAIM ONLY
```

Paid claim is optional and spends real funds.

---

## Paid claim requires explicit confirmation

An AI agent must not continue unless the human writes exactly:

```text
I understand this is a paid claim and I want to spend 10 USDC.
```

Without this exact confirmation:

```text
STOP.
```

---

## Treat these as paid claim signals

```text
10 USDC
amount=10000000
any amount greater than 0
```

If the user wanted free claim, stop.

---

## Pre-check before paid claim

Confirm:

```text
Claim type: paid
Expected amount: 10 USDC
Token: USDC
Network: shown by official flow
Official claim page: confirmed
Agent address: correct
DID: correct
Human link: verified
Wallet: separate wallet, not main wallet
```

---

## Stop conditions

Stop if:

- user wanted free claim;
- amount is not expected;
- token is not USDC;
- network looks wrong;
- website looks unofficial;
- wallet asks for seed phrase;
- wallet asks for private key;
- wallet asks for unlimited approval;
- DID is wrong;
- agent address is wrong;
- human link is not verified;
- user did not explicitly confirm paid claim.

---

## After paid claim

Save:

```text
Agent name:
Agent address:
DID:
Tile ID:
Tx hash:
Human field:
Attestation:
Canvas ID:
X:
Y:
Placed at:
Explorer link:
Claim type: paid
Amount: 10 USDC
Date:
```

Paid claim does not guarantee FAIAR rewards, airdrop allocation, leaderboard rewards, or profit.
