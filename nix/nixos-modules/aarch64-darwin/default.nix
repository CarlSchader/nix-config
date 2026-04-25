{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./system-packages.nix
  ./tailscaled.nix
  ./users.nix
]
