{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./common
  ./darwin-configurations
  ./lib
  ./nixos-configurations
  ./nixos-modules
]
