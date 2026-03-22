#!/bin/bash
set -e

echo "🗑️  Uninstalling git-hooks..."

# Reset git hooks path
git config --unset core.hooksPath 2>/dev/null || true

# Remove files
rm -rf config/hooks config/detekt.yml .editorconfig

echo "✅ Uninstalled!"
echo "   Hooks and config files removed."
