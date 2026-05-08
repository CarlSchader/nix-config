{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./acs-packages.nix
  ./acs-shell.nix
  ./acs-ssh.nix
  ./bluetooth-applet.nix
  ./configurations.nix
  ./ghostty.nix
  ./gnome-keyring.nix
  ./gpg-agent.nix
  ./gui-apps.nix
  ./minecraft-client.nix
  ./network-manager-applet.nix
  ./packages.nix
  ./permissions.nix
  ./preamble.nix
  ./shell.nix
  ./spotify-player.nix
  ./ssh.nix
  ./sway.nix
  ./tmux.nix
]
