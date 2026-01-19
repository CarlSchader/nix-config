{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./common.nix
  ./gnome-keyring-home.nix
  ./saronic-awscli.nix
  ./home.nix
  ./rust-overlay-home.nix
  ./saronic-opk.nix
  ./shell-configs.nix
  ./ssh.nix
  ./sway-home.nix
  ./wezterm.nix
]
