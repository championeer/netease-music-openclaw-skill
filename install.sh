#!/usr/bin/env bash
set -euo pipefail

REPO_URL_DEFAULT="https://github.com/championeer/netease-music-openclaw-skill.git"
SKILL_NAME="netease-music"

usage() {
  cat <<'USAGE'
Install the OpenClaw NetEase Music skill by copying the `netease-music/` folder
into an OpenClaw skills directory.

Usage:
  ./install.sh [--global] [--workspace <dir>] [--skills-dir <dir>] [--repo <git-url>] [--yes]

Options:
  --global            Install to ~/.openclaw/skills (shared across agents)
  --workspace <dir>   Install to <dir>/skills (per-workspace). If omitted, uses CWD.
  --skills-dir <dir>  Install to an explicit skills directory (overrides --workspace/--global)
  --repo <git-url>    Override repo URL
  --yes               Overwrite existing skill without prompting

Examples:
  # Install into the current directory's skills/ (run this inside your OpenClaw workspace)
  ./install.sh

  # Install globally
  ./install.sh --global

  # Install into a specific workspace
  ./install.sh --workspace "$HOME/.openclaw/workspace"

One-liner (optional):
  curl -fsSL https://raw.githubusercontent.com/championeer/netease-music-openclaw-skill/main/install.sh | bash -s -- --global
USAGE
}

YES=0
GLOBAL=0
WORKSPACE=""
SKILLS_DIR=""
REPO_URL="$REPO_URL_DEFAULT"

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) usage; exit 0;;
    --yes) YES=1; shift;;
    --global) GLOBAL=1; shift;;
    --workspace) WORKSPACE="$2"; shift 2;;
    --skills-dir) SKILLS_DIR="$2"; shift 2;;
    --repo) REPO_URL="$2"; shift 2;;
    *) echo "Unknown arg: $1"; echo; usage; exit 2;;
  esac
done

if [[ -n "$SKILLS_DIR" ]]; then
  TARGET_SKILLS_DIR="$SKILLS_DIR"
elif [[ "$GLOBAL" == "1" ]]; then
  TARGET_SKILLS_DIR="$HOME/.openclaw/skills"
else
  # Default: per-workspace install into CWD/skills
  TARGET_WORKSPACE="${WORKSPACE:-"$(pwd)"}"
  TARGET_SKILLS_DIR="$TARGET_WORKSPACE/skills"
fi

mkdir -p "$TARGET_SKILLS_DIR"

if ! command -v git >/dev/null 2>&1; then
  echo "ERROR: git is required." >&2
  exit 1
fi

TMP_DIR="$(mktemp -d)"
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

echo "Cloning repo..."
git clone --depth 1 "$REPO_URL" "$TMP_DIR/repo" >/dev/null

if [[ ! -f "$TMP_DIR/repo/$SKILL_NAME/SKILL.md" ]]; then
  echo "ERROR: expected $SKILL_NAME/SKILL.md in repo. Repo layout changed?" >&2
  exit 1
fi

DEST="$TARGET_SKILLS_DIR/$SKILL_NAME"

if [[ -e "$DEST" && "$YES" != "1" ]]; then
  echo "Skill already exists at: $DEST"
  read -r -p "Overwrite it? (y/N) " ans
  case "${ans:-}" in
    y|Y|yes|YES) : ;;
    *) echo "Aborted."; exit 1;;
  esac
fi

rm -rf "$DEST"
cp -R "$TMP_DIR/repo/$SKILL_NAME" "$DEST"

echo "Installed: $DEST"
echo "Next: start a NEW OpenClaw session so it reloads skills."