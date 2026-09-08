{flake-utils, ...} @ inputs:
flake-utils.lib.meld inputs [
  ./ampere-a1
  ./dell-xps
  ./dgx-spark
  ./intel-mac-nixos
  ./4090rtx-tower
]
