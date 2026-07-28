{flake-utils, ...} @ inputs:
flake-utils.lib.meld inputs [
  ./packages.nix
  ./shell.nix
  ./ssh.nix
  ./configurations.nix
]
