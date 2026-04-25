{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./openssh.nix
  ./system-packages.nix
  ./tailscaled.nix
  ./users.nix
]
