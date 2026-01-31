{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./saronic-system76
]
