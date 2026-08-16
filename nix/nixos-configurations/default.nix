{flake-utils, ...} @ inputs:
flake-utils.lib.meld inputs [
  ./ampere-a1
  ./dell-xps
  ./intel-mac-nixos
  ./ml-pc
]
