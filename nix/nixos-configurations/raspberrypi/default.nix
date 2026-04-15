{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./rpi5.nix
]
