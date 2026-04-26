{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./ampere-a1
  ./ml-pc
]
