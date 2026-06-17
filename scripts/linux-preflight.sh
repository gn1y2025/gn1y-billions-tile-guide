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

SKILL_DIR=$(find "$AGENT_ROOT" -type d -name "verified-agent-identity" -print -quit)

if [ -z "$SKILL_DIR" ]; then
  echo "MISSING: verified-agent-identity skill folder not found"
  echo "Next step: install official Billions Verified Agent Identity skill"
  exit 1
fi

echo "OK: verified-agent-identity skill found"
echo "Skill folder: $SKILL_DIR"

if [ -f "$SKILL_DIR/package.json" ]; then
  echo "OK: package.json found"
else
  echo "MISSING: package.json not found in skill folder"
  exit 1
fi

if [ -f "$SKILL_DIR/scripts/createNewEthereumIdentity.js" ]; then
  echo "OK: createNewEthereumIdentity.js found"
else
  echo "MISSING: createNewEthereumIdentity.js not found"
  missing=1
fi

if [ -f "$SKILL_DIR/scripts/manualLinkHumanToAgent.js" ]; then
  echo "OK: manualLinkHumanToAgent.js found"
else
  echo "MISSING: manualLinkHumanToAgent.js not found"
  missing=1
fi

echo ""

if [ "$missing" -eq 0 ]; then
  echo "Preflight completed. Basic setup looks ready."
  echo "This script did not claim a tile and did not spend funds."
  exit 0
else
  echo "Preflight found issues. Fix them before continuing."
  exit 1
fi
