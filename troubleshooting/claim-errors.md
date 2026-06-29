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

## Case: paymentRequiredFilePath not found

Symptoms:

- Phase1 shows a valid JSON response.
- You can see `amount=0`.
- You can see `paymentRequiredFilePath` in the terminal.
- The script still stops with `paymentRequiredFilePath not found`.

Meaning:

The parser failed to extract the temp payment requirements file path from Phase1.

The safe script must stop before Phase2 if it cannot resolve this file path.

Fix:

Update to the latest `windows-instant-free-claim.ps1` from the guide website and run the claim command again.

Expected behavior after the fix:

- script prints `paymentRequiredFilePath resolved:`
- script checks that the local temp JSON file exists
- script continues to Phase2 only after that

Do not manually copy old claim data. Run a fresh flow.

## Case: Cannot bind argument to parameter Node because it is null

Symptoms:

- Phase1 works
- `paymentRequiredFilePath resolved` appears
- free option shows `amount=0`
- Phase2 starts
- PowerShell stops with:
  - `Find-ObjectsRecursive`
  - `Cannot bind argument to parameter 'Node' because it is null`

Meaning:

The Phase2 JSON contains a null field and the old parser did not skip null values.

Fix:

Update to the latest `windows-instant-free-claim.ps1` from the live guide website and run a fresh claim flow.

Do not manually reuse old claim data.

Success still requires:

- `SUBMIT OK`
- `Paid=false`
- `amount=0`
- `Proof saved to:`

## Case: maxExceeded=true / Payment has exceeded maximum allowed uses

Symptoms:

- Phase1 works.
- Free option exists with `amount=0`.
- Phase2 returns:
  - `maxExceeded: true`
  - `Payment has exceeded its maximum allowed uses`
  - HTTP `402 Payment Required`

Meaning:

The agent and identity may be working, but the free allowance for this payment/human/identity/resource is no longer available.

This can happen even if no NFT appears, especially if an earlier Phase2 run created a `claim_id` but failed before final submit.

Do not switch to paid.

Do not retry blindly.

Do not treat this as success.

Success still requires:

- `SUBMIT OK`
- `Paid=false`
- `amount=0`
- `Proof saved to:`

Next:

- Stop this agent.
- Check old logs for `claim_id`.
- Use a different eligible agent only with the latest live guide script.

## Case: Phase2 created claim_id but no NFT appeared

Symptoms:

- Phase2 output contains `claim_id` / `clm_...`.
- There is no `SUBMIT OK`.
- There is no `Proof saved to:`.
- There is no `tile_id`.
- Later attempts return `maxExceeded=true`.

Meaning:

The script may have created or consumed a fresh claim, but failed before final Tile submit.

This may consume the free allowance without minting a Tile NFT.

Do not manually reuse old claim data.

Do not repeatedly test Phase2 on the same real eligible agent.

Use the latest live claim script and a different eligible agent.
