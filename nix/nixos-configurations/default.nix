{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./acs-lenovo
  ./ampere-a1
  ./ml-pc
]
