Homebrew packaging
==================

Install (from a tap)
--------------------
```bash
brew tap hpcd-dev/hpcd
brew install hpc
```

Start the daemon with Homebrew services (macOS + Linux):
```bash
brew services start hpc
```

Configuration
-------------
`hpcd` reads its config from the standard config directory:
- macOS: `~/Library/Application Support/hpcd/hpcd.toml`
- Linux: `~/.config/hpcd/hpcd.toml`

If `database_path` is not set, it defaults to:
- macOS: `~/Library/Application Support/hpcd/hpcd.sqlite`
- Linux: `~/.local/share/hpcd/hpcd.sqlite`

You can also run the daemon directly and point at a custom config:
```bash
hpcd --config /path/to/hpcd.toml
```
