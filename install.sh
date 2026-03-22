#!/bin/bash
set -e

REPO_RAW="https://raw.githubusercontent.com/ClankerGuru/git-hooks/main"
HOOKS_DIR="config/hooks"
CONFIG_DIR="config"

# Make sure we're in a git repo
if [ ! -d ".git" ]; then
    echo "❌ Not a Git repository. Run this from your project root."
    exit 1
fi

# Create hooks dir
mkdir -p "$HOOKS_DIR"

# Download hooks
echo "⬇️  Downloading hooks..."
curl -fsSL "$REPO_RAW/hooks/pre-commit" -o "$HOOKS_DIR/pre-commit"
curl -fsSL "$REPO_RAW/hooks/pre-push" -o "$HOOKS_DIR/pre-push"

# Make them executable
chmod +x "$HOOKS_DIR/pre-commit"
chmod +x "$HOOKS_DIR/pre-push"

# Download config files
echo "⬇️  Downloading detekt + ktlint configs..."
curl -fsSL "$REPO_RAW/config/detekt.yml" -o "$CONFIG_DIR/detekt.yml"
curl -fsSL "$REPO_RAW/config/.editorconfig" -o ".editorconfig"

# Point git at the hooks dir
git config core.hooksPath "$HOOKS_DIR"

# Add to .gitignore if not already there
add_to_gitignore() {
    if ! grep -q "^$1$" .gitignore 2>/dev/null; then
        echo "$1" >> .gitignore
    fi
}

add_to_gitignore "config/hooks/"
add_to_gitignore "config/detekt.yml"
add_to_gitignore ".editorconfig"

# Unstage the files we just added
git reset HEAD config/hooks/ config/detekt.yml .editorconfig .gitignore 2>/dev/null || true

echo "🎉 Hooks + config installed!"
echo ""
echo "📁 Files added (gitignored):"
echo "   config/hooks/"
echo "   config/detekt.yml"
echo "   .editorconfig"
echo ""
echo "💡 If using OpenSpec (https://github.com/ClankerGuru/openspec-gradle),"
echo "   plugins are applied automatically."
echo "   Otherwise, add to build.gradle.kts:"
echo '   id("io.gitlab.arturbosch.detekt") version "1.23.7"'
echo '   id("org.jlleitschuh.gradle.ktlint") version "12.1.2"'
echo ""
echo "   To skip hooks: git commit --no-verify"
echo "   To undo: git config --unset core.hooksPath"
