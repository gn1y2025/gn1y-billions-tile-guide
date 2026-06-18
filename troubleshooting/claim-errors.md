# Claim Errors

Common errors during Billions AI Agentic Movie Tiles claim flow.

---

## Claim shows `10 USDC` but you wanted free

### Meaning

This is not a free claim.

### Fix

Stop immediately.

Do not approve payment.

Go to the paid tile guide only if you intentionally want a paid claim:

```text
guides/paid-tile.md
```

---

## `amount=10000000` appears

### Meaning

This may represent 10 USDC using 6 decimals.

### Fix

If you wanted free claim:

```text
STOP.
```

Do not continue.

Only continue if you intentionally want paid claim and you understand it spends real funds.

---

## `maxUseExceeded`

### Meaning

The free claim may already be used or the campaign limit/rule blocked this claim.

### Fix

Do not try to bypass the rule.

Based on support clarification:

```text
One verified human = one agent = one free tile.
```

If you believe this is an error, ask official support.

---

## Free claim unavailable

### Possible causes

- free claim already used by this verified human;
- wrong agent identity;
- human link not verified;
- campaign rule changed;
- claim flow issue.

### Fix

Check:

```text
Agent identity: correct
DID: correct
Human link: verified
Claim type: free
Expected amount: 0
```

If amount is not `0`, stop.

---

## NFT does not appear immediately

### Meaning

Explorer indexing may be delayed.

### Fix

Save the transaction hash.

Check later.

Save:

```text
Tile ID:
Tx hash:
Agent address:
DID:
Canvas ID:
X/Y:
Date:
Explorer link:
```

---

## Transaction failed

### Possible causes

- network issue;
- wrong claim flow;
- expired claim payload;
- free claim already used;
- paid claim payment issue;
- wallet rejected.

### Fix

Do not repeat blindly.

Check the transaction hash if available.

If no funds were spent and claim failed, retry only after understanding the error.

---

## Wrong coordinates / wrong tile area

### Meaning

The official flow may assign tile coordinates automatically.

### Fix

Do not force coordinates manually unless the official UI explicitly allows it.

After success, save:

```text
X:
Y:
Canvas ID:
Tile ID:
Role:
```

---

## Website looks unofficial

### Fix

Stop.

Do not connect wallet.

Do not approve anything.

Only use official Billions / x402 claim flow.

---

## Wallet asks for seed phrase or private key

### Fix

Stop immediately.

This is unsafe.

No legitimate claim flow should ask for seed phrase or private key.

---

## Instant API claim script fails

### Possible causes

- `buildX402Payment.js` is missing;
- `getIdentities.js` failed;
- no free `amount=0` option exists;
- only paid `amount=10000000` option exists;
- claim expired;
- API response shape changed;
- wrong agent folder selected.

### Fix

Do not reuse old `claim_id`.

Run a fresh flow only after fixing the issue.

If the script shows `10 USDC`, `amount=10000000`, or any amount greater than `0`, stop.

---

## Claim expired

### Meaning

The fresh claim has a short expiry window.

During previous successful terminal claims, the remaining time was around 5 minutes.

### Fix

Do not manually reuse the old claim.

Run the full flow again:

```text
Phase1 -> free amount=0 -> Phase2 -> fresh claim_id -> immediate submit
```
