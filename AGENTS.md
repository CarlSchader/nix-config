# AGENTS.md

## Architecture

- Nix flake using `flake-utils.lib.meld` to compose outputs from subdirectories
- Each subdir's `default.nix` returns a partial flake attrset; `meld` merges them all — **do not add outputs directly to `flake.nix`**
- Two meld roots in `flake.nix`: `./nix` and `./wezterm`
- Platforms: `aarch64-darwin` (multiple MacBooks), `x86_64-linux` (ml-pc NixOS)
- Tracks `nixpkgs-unstable`

## Commands

```sh
# Validate without applying
nix flake check
nix flake show

# Apply system config
darwin-rebuild switch --flake .#<machine-name>   # macOS
nixos-rebuild switch --flake .#ml-pc              # NixOS

# Apply home-manager config (name pattern: <system>-<username>)
home-manager switch --flake .#x86_64-linux-carl
home-manager switch --flake .#aarch64-darwin-carl

# Format nix files (no formatter output in flake; run manually)
nixfmt <file>
```

## Directory layout

| Path | Purpose |
|------|---------|
| `nix/common/` | Platform-specific package lists (`common.<system>.user-packages`, `common.<system>.system-packages`) |
| `nix/darwin-configurations/` | macOS machine definitions (nix-darwin) |
| `nix/nixos-configurations/` | NixOS machine definitions (only `ml-pc`) |
| `nix/nixos-modules/` | Reusable NixOS modules, split into `all-systems/`, `x86_64-linux/`, `aarch64-darwin/` |
| `nix/home-manager/` | Home-manager modules and per-platform user configurations |
| `nix/lib/` | SSH keys (`keys.nix`), nvidia driver helpers |
| `wezterm/` | WezTerm config; separate meld root wired directly in `flake.nix` |

## Conventions

- **Adding a module:** create the `.nix` file, then add it to the parent `default.nix` meld list — this is the only way it gets included in flake outputs
- **NixOS modules** are exported as `nixosModules.<name>` (e.g., `self.nixosModules.bluetooth`)
- **Home modules** are exported as `homeModules.<name>` (e.g., `self.homeModules.shell`)
- **User modules** follow `"<system>-<username>-user"` naming (e.g., `x86_64-linux-carl-user`)
- **Home-manager configs** follow `"<system>-<username>"` naming (e.g., `x86_64-linux-carl`)
- Machine configs compose modules by referencing `self.nixosModules.*` and `self.homeModules.*`

## Gotchas

- **No CI** — validate locally with `nix flake check` before committing
- **Determinate Nix on Darwin** — `darwin.nix` sets `nix.enable = false`; the system Nix is managed outside nix-darwin
- **`experimental-featurs.nix`** — the missing 'e' is a known filename typo; do not rename without updating all references in the meld list
- **Secrets** — API keys (Anthropic, OpenAI, Gemini) are loaded at shell init from `~/.secrets/` on the host; they are not in this repo
- **`allowUnfree = true`** is set in multiple places (darwin.nix, common packages, ml-pc configuration); new package sets should also set it if needed
