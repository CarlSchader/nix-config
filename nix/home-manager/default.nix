{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./configurations.nix
  ./ghostty.nix
  ./gnome-keyring.nix
  ./minecraft-client.nix
  ./packages.nix
  ./permissions.nix
  ./preamble.nix
  ./shell.nix
  ./spotify-player.nix
  ./ssh.nix
  ./sway.nix
  ./tmux.nix
]
