#!/usr/bin/env bash
set -e

echo ""
echo "gn1y Billions Tile Guide — Linux Preflight"
echo "This script checks tools and folders only. It does not claim tiles and does not spend funds."
echo ""

missing=0

check_command() {
  if command -v "$1" >/dev/null 2>&1; then
    echo "OK: $1 found"
  else
    echo "MISSING: $1 not found"
    missing=1
  fi
}

check_command git
check_command curl
check_command node
check_command npm
check_command npx
check_command openclaw

echo ""

echo "OpenClaw gateway status:"
openclaw gateway status || echo "WARNING: openclaw gateway status failed. Run onboarding or start the gateway before full agent work."

echo ""

if [ -z "$AGENT_ROOT" ]; then
  read -p "Paste the full path to your OpenClaw agent folder: " AGENT_ROOT
fi

if [ ! -d "$AGENT_ROOT" ]; then
  echo "MISSING: Agent folder not found"
  echo "Path: $AGENT_ROOT"
  exit 1
fi

echo "OK: Agent folder exists"
echo "Agent folder: $AGENT_ROOT"

SKILL_DIRS=$(find "$AGENT_ROOT" -type d -name "verified-agent-identity" 2>/dev/null || true)
SKILL_COUNT=$(echo "$SKILL_DIRS" | sed '/^$/d' | wc -l | tr -d ' ')

if [ "$SKILL_COUNT" = "0" ]; then
  echo "MISSING: verified-agent-identity skill folder not found"
  echo "Next step: install official Billions Verified Agent Identity skill"
  exit 1
fi

if [ "$SKILL_COUNT" != "1" ]; then
  echo "WARNING: Multiple verified-agent-identity folders found. Confirm the correct one before continuing."
  echo "$SKILL_DIRS"
fi

SKILL_DIR=$(echo "$SKILL_DIRS" | sed '/^$/d' | head -n 1)

echo "OK: verified-agent-identity skill found"
echo "Skill folder: $SKILL_DIR"

for rel in \
  "package.json" \
  "scripts/createNewEthereumIdentity.js" \
  "scripts/manualLinkHumanToAgent.js" \
  "scripts/getIdentities.js" \
  "scripts/buildX402Payment.js"
do
  if [ -f "$SKILL_DIR/$rel" ]; then
    echo "OK: $rel found"
  else
    echo "MISSING: $rel not found"
    missing=1
  fi
done

echo ""

if [ "$missing" -eq 0 ]; then
  echo "Preflight completed. Basic setup looks ready."
  echo "Next recommended check:"
  echo "  cd \"$SKILL_DIR\""
  echo "  node scripts/getIdentities.js"
  echo ""
  echo "This script did not claim a tile and did not spend funds."
  exit 0
else
  echo "Preflight found issues. Fix them before continuing."
  exit 1
fi
