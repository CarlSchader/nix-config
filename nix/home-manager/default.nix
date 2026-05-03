{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./acs-packages.nix
  ./acs-shell.nix
  ./acs-ssh.nix
  ./bluetooth.nix
  ./configurations.nix
  ./ghostty.nix
  ./gnome-keyring.nix
  ./gpg-agent.nix
  ./gui-apps.nix
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
