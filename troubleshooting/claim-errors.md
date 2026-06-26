# Claim Errors

Use this page when the free claim route stops, crashes, or does not print `SUBMIT OK`.

## Golden rule

A claim is successful only if the output shows:

- `SUBMIT OK`
- `Paid=false`
- `amount=0`
- `Proof saved to:`

If these lines are missing, do not treat it as success.

---

## Case: node.exe Assertion failed / NativeCommandError

Symptoms:

- `node.exe : Assertion failed`
- `NativeCommandError`
- `buildX402Payment.js` crashes
- the script stops during Phase1 or Phase2
- no `SUBMIT OK`
- no proof file

Meaning:

The Node/x402 helper crashed before the claim was submitted successfully.

This is not a successful claim.

Do not continue manually with partial output.

Fix:

1. Stop.
2. Save the terminal output.
3. Check Node version with `node -v`.
4. Re-run Windows Agent Doctor for the same exact `AgentRoot`.
5. Confirm `scripts/package.json` and `scripts/node_modules` exist.
6. If needed, run safe skill repair/update again.
7. Try again only after Doctor says `READY TO CLAIM`.

If the same crash repeats, try a stable Node LTS version supported by OpenClaw and reinstall dependencies inside the skill `scripts` folder.

---

## Case: Cannot find module

Example:

- `Cannot find module '@0xpolygonid/js-sdk'`
- `MODULE_NOT_FOUND`

Meaning:

The skill code exists, but dependencies are missing.

Fix:

Run `npm install` inside the skill `scripts` folder.

Do not run `npm install` only in the skill root.

Expected dependency folder:

- `<agent>\.agents\skills\verified-agent-identity\scripts\node_modules`

After installing dependencies, run Windows Agent Doctor again.

---

## Case: No free amount=0 option found

Meaning:

The flow did not find a safe free Tile option.

If a paid option exists, stop.

Do not continue unless you intentionally want a paid Tile.

Stop if you see:

- `10 USDC`
- `amount=10000000`
- `amount > 0`
- `Paid=true`

---

## Case: Submit failed

Meaning:

The claim was generated, but the final Tile submit failed.

Do not reuse old claims manually.

Run a fresh flow only after checking the reason.

Common causes:

- claim expired
- free claim already used
- eligibility limit
- wrong agent
- wrong identity
- API/network issue

---

## Case: output says success but no proof

Treat this as not proven.

Success requires:

- `SUBMIT OK`
- `Proof saved to:`
- visible proof JSON path

## Case: Node cleanup assertion after valid JSON

Symptoms:

- Phase1 prints valid JSON.
- The JSON contains a free option with `amount=0`.
- stderr prints `Assertion failed`.
- stderr mentions `UV_HANDLE_CLOSING` or `async.c`.

Meaning:

On some Windows/Node setups, the helper may produce valid JSON and then crash during Node cleanup.

The guide script may continue only if the JSON is valid and all safety checks pass.

This is not success by itself.

Success still requires:

- `SUBMIT OK`
- `Paid=false`
- `amount=0`
- `Proof saved to:`

If valid JSON is missing, stop.

If `claim_id` is missing, stop.

If submit fails, stop.

Do not treat Phase1 JSON as a claimed Tile.
