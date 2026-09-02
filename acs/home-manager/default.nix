{flake-utils, ...} @ inputs:
flake-utils.lib.meld inputs [
  ./configurations.nix
  ./packages.nix
  ./shell.nix
  ./ssh.nix
]
