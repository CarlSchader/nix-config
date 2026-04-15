{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./rpi4.nix
  ./rpi5.nix
]
