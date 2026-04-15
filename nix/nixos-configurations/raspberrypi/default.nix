{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./rpi.nix
]
