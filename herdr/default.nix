{ flake-utils, ... } @ inputs:
flake-utils.lib.meld inputs [
  ./home-modules.nix
  ./apps.nix
]
