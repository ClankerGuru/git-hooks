# git-hooks

Shared Git hooks for ClankerGuru projects. One-liner install, consistent quality across all repos.

## Quick Install

Run this from any project root:

```bash
curl -fsSL https://raw.githubusercontent.com/ClankerGuru/git-hooks/main/install.sh | bash
```

## What It Does

### Hooks

| Hook | Description |
|------|-------------|
| `pre-commit` | Runs `./gradlew build` (includes detekt + ktlint via OpenSpec) |
| `pre-push` | Blocks direct pushes to `main` (forces PRs) |

### Config Files (add to .gitignore)

| File | Description |
|------|-------------|
| `config/hooks/` | Git hooks directory |
| `config/detekt.yml` | Static analysis rules |
| `.editorconfig` | ktlint formatting rules |

## Pre-commit Flow

```
🔨 Running Gradle build (includes detekt + ktlint)...
──────────────────────────────────────────
BUILD SUCCESSFUL

✅ All checks passed. Proceeding with commit.
```

## Gradle Setup

**If using [OpenSpec](https://github.com/ClankerGuru/openspec-gradle):** Plugins are applied automatically. No setup needed.

**Otherwise**, add to your `build.gradle.kts`:

```kotlin
plugins {
    id("io.gitlab.arturbosch.detekt") version "1.23.7"
    id("org.jlleitschuh.gradle.ktlint") version "12.1.2"
}

detekt {
    config.setFrom("$rootDir/config/detekt.yml")
}
```

## Skipping Hooks

```bash
# Skip pre-commit
git commit --no-verify -m "wip"

# Skip pre-push (push to main)
git push --no-verify
```

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/ClankerGuru/git-hooks/main/uninstall.sh | bash
```

## License

MIT
