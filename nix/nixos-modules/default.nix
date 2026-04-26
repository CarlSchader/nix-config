{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./aarch64-darwin
  ./aarch64-linux
  ./all-systems
  ./x86_64-linux
]
