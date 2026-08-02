# nix-config


Personal Nix flake configuration for macOS and NixOS machines.

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

## License

MIT
