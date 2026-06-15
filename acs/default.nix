{flake-utils, ...} @ inputs:
flake-utils.lib.meld inputs [
  ./packages.nix
  ./rdp-host.nix
  ./shell.nix
  ./ssh.nix
  ./configurations.nix
]
