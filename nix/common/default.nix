{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./aarch64-darwin.nix
  ./aarch64-linux.nix
  ./x86_64-linux.nix
]
