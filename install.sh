#!/usr/bin/env bash
# One-liner installer for rpow-cli-miner OpenClaw skill.
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/buffmaxx65/rpow-cli-miner-skill/main/install.sh | bash
#
# Optional env vars:
#   SKILL_DIR   — override target directory (default: ~/.openclaw/skills/rpow-cli-miner)
#   SCOPE       — "shared" (default, ~/.openclaw/skills) or "agent" (~/.agents/skills)

set -euo pipefail

REPO_URL="https://github.com/buffmaxx65/rpow-cli-miner-skill.git"
SKILL_NAME="rpow-cli-miner"
SCOPE="${SCOPE:-shared}"

if [[ -z "${SKILL_DIR:-}" ]]; then
  case "$SCOPE" in
    shared) SKILL_DIR="$HOME/.openclaw/skills/$SKILL_NAME" ;;
    agent)  SKILL_DIR="$HOME/.agents/skills/$SKILL_NAME" ;;
    *)
      echo "Unknown SCOPE='$SCOPE'. Use 'shared' or 'agent'." >&2
      exit 1
      ;;
  esac
fi

echo "==> Installing OpenClaw skill: $SKILL_NAME"
echo "==> Target: $SKILL_DIR"

if ! command -v git >/dev/null 2>&1; then
  echo "ERROR: git is not installed. Please install git first." >&2
  exit 1
fi

mkdir -p "$(dirname "$SKILL_DIR")"

if [[ -d "$SKILL_DIR/.git" ]]; then
  echo "==> Skill directory already exists. Pulling latest..."
  git -C "$SKILL_DIR" pull --ff-only
else
  if [[ -e "$SKILL_DIR" ]]; then
    echo "ERROR: $SKILL_DIR exists but is not a git repo. Aborting." >&2
    exit 1
  fi
  git clone --depth=1 "$REPO_URL" "$SKILL_DIR"
fi

echo
echo "==> Installation complete."
echo
echo "Next steps:"
echo "  1. Restart the OpenClaw gateway:"
echo "       openclaw gateway restart"
echo "  2. Verify the skill loaded:"
echo "       openclaw skills list | grep $SKILL_NAME"
echo "  3. Clone the RPOW CLI miner itself:"
echo "       git clone https://github.com/stablemarkk/rpow_cli_miner.git"
echo "       cd rpow_cli_miner"
echo "       bash build-native.sh"
echo "  4. Try it:"
echo "       openclaw agent --message \"Setup RPOW CLI miner dan mine 1 token\""
echo
