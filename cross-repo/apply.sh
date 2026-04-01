#!/usr/bin/env bash
# apply.sh — Create branches, apply changes, push, and open draft PRs
#
# Prerequisites:
#   - gh CLI authenticated (`gh auth login`)
#   - git configured with push access to zalchemist/* repos
#   - Run from the root of the Cursor repo
#
# Usage:
#   ./cross-repo/apply.sh              # Execute all steps
#   ./cross-repo/apply.sh --dry-run    # Preview without making changes

set -euo pipefail

BRANCH="cursor/pregled-github-strukture-8e12"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DRY_RUN=false

if [ "${1:-}" = "--dry-run" ]; then
    DRY_RUN=true
    echo "[dry-run] No changes will be made."
fi

run() {
    if [ "$DRY_RUN" = true ]; then
        echo "[dry-run] $*"
    else
        "$@"
    fi
}

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

# ─────────────────────────────────────────────────────────────────────
# 1. abacus-skill-creator — canonical skill source
# ─────────────────────────────────────────────────────────────────────
echo ""
echo "=== abacus-skill-creator: canonical skill source ==="

REPO1="$TMPDIR/abacus-skill-creator"
run git clone https://github.com/zalchemist/abacus-skill-creator.git "$REPO1"
if [ "$DRY_RUN" = false ]; then
    cd "$REPO1"
    git checkout -b "$BRANCH" origin/main
    cp "$SCRIPT_DIR/abacus-skill-creator/SKILL-INDEX.md" SKILL-INDEX.md
    git add SKILL-INDEX.md
    git commit -m "feat: oznaci repo kao kanonski izvor skills-a, dodaj deep-agent-chatbot-protocol u indeks"
    git push -u origin "$BRANCH"
    gh pr create --repo zalchemist/abacus-skill-creator \
        --base main --head "$BRANCH" \
        --title "Canonical skill source" \
        --body "Oznacen repo kao kanonski izvor svih skills-a. Dodat deep-agent-chatbot-protocol u SKILL-INDEX.md." \
        --draft
fi

# ─────────────────────────────────────────────────────────────────────
# 2. abacus-skills — registry alignment
# ─────────────────────────────────────────────────────────────────────
echo ""
echo "=== abacus-skills: registry alignment ==="

REPO2="$TMPDIR/abacus-skills"
run git clone https://github.com/zalchemist/abacus-skills.git "$REPO2"
if [ "$DRY_RUN" = false ]; then
    cd "$REPO2"
    git checkout -b "$BRANCH" origin/main
    cp "$SCRIPT_DIR/abacus-skills/skills-registry.json" skills-registry.json
    cp "$SCRIPT_DIR/abacus-skills/SKILL-INDEX.md" SKILL-INDEX.md
    git add skills-registry.json SKILL-INDEX.md
    git commit -m "feat: uskladi registar sa kanonskim izvorom, dodaj deep-agent-chatbot-protocol"
    git push -u origin "$BRANCH"
    gh pr create --repo zalchemist/abacus-skills \
        --base main --head "$BRANCH" \
        --title "Registry alignment" \
        --body "Uskladjen skills-registry.json i SKILL-INDEX.md sa kanonskim izvorom (abacus-skill-creator). Dodat deep-agent-chatbot-protocol." \
        --draft
fi

# ─────────────────────────────────────────────────────────────────────
# 3. abacus-workspace — secret cleanup
# ─────────────────────────────────────────────────────────────────────
echo ""
echo "=== abacus-workspace: secret cleanup ==="

REPO3="$TMPDIR/abacus-workspace"
run git clone https://github.com/zalchemist/abacus-workspace.git "$REPO3"
if [ "$DRY_RUN" = false ]; then
    cd "$REPO3"
    git checkout -b "$BRANCH" origin/main
    cp "$SCRIPT_DIR/abacus-workspace/chatbots/registry.json" chatbots/registry.json
    cp "$SCRIPT_DIR/abacus-workspace/chatbots/abacus-knowledge-brain/README.md" chatbots/abacus-knowledge-brain/README.md
    cp "$SCRIPT_DIR/abacus-workspace/chatbots/github-workspace-assistant/README.md" chatbots/github-workspace-assistant/README.md
    git add chatbots/
    git commit -m "fix: ukloni hardkodovane deployment tokene, koristi env varijable"
    git push -u origin "$BRANCH"
    gh pr create --repo zalchemist/abacus-workspace \
        --base main --head "$BRANCH" \
        --title "Secret cleanup" \
        --body "Uklonjeni hardkodovani deployment_token i deployment_id iz registry.json i README fajlova. Zamenjeni referencama na environment varijable." \
        --draft
fi

echo ""
echo "=== Gotovo ==="
echo "Branch: $BRANCH"
echo "PRs kreirani kao draft u sva tri repozitorijuma."
