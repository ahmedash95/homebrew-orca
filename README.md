# homebrew-orca

Homebrew tap and download host for **Orca** — a terminal workspace for AI coding
agents. Run Cursor CLI, Claude Code, and plain shells side by side: one window,
one layout, per project. macOS 12+.

```bash
brew install --cask ahmedash95/orca/orca
```

Updating:

```bash
brew upgrade --cask orca
```

Uninstalling:

```bash
brew uninstall --cask orca        # add --zap to also remove ~/.orca
```

## Why a tap instead of homebrew-cask?

Orca is ad-hoc signed but not notarized by Apple, and the official
`homebrew/cask` repository only accepts notarized apps. This tap clears the
Gatekeeper quarantine flag in a `postflight` block, so no manual `xattr` step is
needed.

## Where the downloads come from

Orca's source repository is private. Release assets on a private repository
require authentication, and a Homebrew cask needs a URL anyone can fetch — so the
build publishes its artifacts as a **release on this repository**, which is
public. Those releases carry the `.dmg` and its `SHA256SUMS` and nothing else: no
release notes, since the changelog is generated from private history.

[`.github/workflows/bump.yml`](.github/workflows/bump.yml) reacts to a release
being published here, reads the checksum from `SHA256SUMS`, re-downloads the
`.dmg` to confirm it matches, then rewrites `version` and `sha256` in the cask and
commits — using this repository's own `GITHUB_TOKEN`. An hourly schedule acts as a
safety net if a release event is ever missed.
