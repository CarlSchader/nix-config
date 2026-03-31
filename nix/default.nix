{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./common
  ./darwin-configurations
  ./home-manager
  ./lib
  ./nixos-configurations
  ./nixos-modules
]
