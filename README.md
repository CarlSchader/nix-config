# nix-config


Personal Nix flake configuration for macOS and NixOS machines.

## Overview

This repository is my personal Nix flake for managing macOS, NixOS, and Home Manager environments from one place. It contains host-level system configurations, user-level Home Manager configurations, and reusable modules for desktop tools and applications.

The flake is composed from several top-level modules using `flake-utils.lib.meld`, with the main entry point in `flake.nix`.

## Repository Layout

- `flake.nix` - main flake inputs and composed outputs.
- `flake.lock` - pinned input revisions.
- `nix/` - core Nix configuration, including NixOS systems, nix-darwin systems, Home Manager configurations, shared modules, and helper libraries.
- `acs/` - ACS-specific Home Manager configurations and packages for non-NixOS Linux machines.
- `aerospace/` - AeroSpace window manager configuration for macOS.
- `librewolf/` - Librewolf Home Manager module, profiles, policies, and bookmarks.
- `sway/` - Sway desktop/session configuration for NixOS and non-NixOS Linux.
- `tmux/` - tmux Home Manager module and configuration.
- `wezterm/` - WezTerm Home Manager modules and configuration.
- `zathura/` - Zathura PDF viewer Home Manager module and configuration.

## Nix Builders
Because this repo is public and on the internet I am hesitant to store sops encrypted secrets in here.

So to allow you to use the nix builders you need to have the appropriate nixbuild ssh key which is private to Carl Schader. If you are given this key by him, configure your machines builders to point to the location of that key. Otherwise you can't use the builders.

## Usage

**macOS (Darwin)**
```sh
darwin-rebuild switch --flake .#<machine-name>
```

**NixOS**
```sh
nixos-rebuild switch --flake .#ml-pc
```

**Home Manager**
```sh
home-manager switch --flake .#<user>
```

## Additional Usage Examples

List available flake outputs:

```sh
nix flake show
```

Check the flake:

```sh
nix flake check
```

Update pinned inputs:

```sh
nix flake update
```

Switch a specific Darwin machine:

```sh
darwin-rebuild switch --flake .#macbook-air-m4
darwin-rebuild switch --flake .#macbook-pro-m1
```

Switch a specific NixOS machine:

```sh
nixos-rebuild switch --flake .#ml-pc
nixos-rebuild switch --flake .#dell-xps
nixos-rebuild switch --flake .#ampere-a1
```

Switch a specific Home Manager profile:

```sh
home-manager switch --flake .#aarch64-darwin-carl
home-manager switch --flake .#x86_64-linux-carl
home-manager switch --flake .#acs-laptop
```

## Flake Outputs

### Darwin Configurations

- `macbook-pro-m1`
- `macbook-air-m4`

### NixOS Configurations

- `ml-pc`
- `dell-xps`
- `ampere-a1`

### Home Manager Configurations

- `x86_64-linux-carl`
- `aarch64-linux-carl`
- `aarch64-darwin-carl`
- `aarch64-darwin-carlschader`
- `acs-laptop`
- `acs-desktop`

## Machines

- `macbook-pro-m1` - Apple Silicon macOS system managed with nix-darwin.
- `macbook-air-m4` - Apple Silicon macOS system managed with nix-darwin.
- `ml-pc` - x86_64 NixOS workstation with Sway, Tailscale, OpenSSH, YubiKey support, git server support, and aarch64 Linux builders enabled.
- `dell-xps` - x86_64 NixOS machine with Sway, Tailscale, OpenSSH, YubiKey support, git server support, and Forgejo configuration.
- `ampere-a1` - aarch64 NixOS host using Disko for disk layout configuration.
- `acs-laptop` - ACS-specific non-NixOS Linux Home Manager profile.
- `acs-desktop` - ACS-specific non-NixOS Linux Home Manager profile with sops-nix Home Manager integration.

## Notable Modules

- Sway desktop configuration for NixOS and non-NixOS Linux.
- Librewolf profiles, bookmarks, policies, and default browser integration.
- tmux configuration with vi-style key mode and `C-a` prefix.
- WezTerm configuration, including a nixGL-aware non-NixOS variant.
- AeroSpace window manager configuration for macOS.
- Zathura PDF viewer configuration.
- SSH, GPG agent, shell, GUI app, and package Home Manager modules.
- NixOS modules for Tailscale, OpenSSH, Bluetooth, YubiKey, Docker, Nix LD, Greetd, Sway, system packages, and builder support.
- nixGL support for non-NixOS Linux Home Manager environments.

## Secrets and Private Material

This repo intentionally avoids committing private secrets. Some configurations expect machine-local material such as SSH keys, age/sops setup, YubiKeys, or host-specific files that are not stored here.

The builder configuration also depends on private key material, as described in the `Nix Builders` section above.

## Updating

Update inputs:

```sh
nix flake update
```

Then rebuild the appropriate target, for example:

```sh
darwin-rebuild switch --flake .#macbook-air-m4
nixos-rebuild switch --flake .#ml-pc
home-manager switch --flake .#aarch64-darwin-carl
```

After a successful update, commit the resulting `flake.lock` change if the new input revisions should be kept.

## Bootstrapping a New Machine

High-level process:

1. Install Nix.
2. Enable flakes and the `nix-command` experimental feature if needed.
3. Clone this repository.
4. Choose the closest matching flake output for the machine.
5. Install or prepare the relevant tool:
   - `nix-darwin` for macOS system configuration.
   - `nixos-rebuild` for NixOS system configuration.
   - `home-manager` for user-level configuration.
6. Place any required private keys or machine-local secrets in the expected local paths.
7. Run the relevant `switch` command from the `Usage` section.

## Notes

- Host-level NixOS configurations live under `nix/nixos-configurations/`.
- nix-darwin configurations live under `nix/darwin-configurations/`.
- Home Manager configurations live under `nix/home-manager/` and `acs/`.
- Reusable NixOS modules live under `nix/nixos-modules/`.
- App-specific modules generally live in their own top-level directories.
- Shared outputs are composed with `flake-utils.lib.meld`.

## License

MIT
