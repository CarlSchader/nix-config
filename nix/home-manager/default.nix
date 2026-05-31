{flake-utils, ...} @ inputs:
flake-utils.lib.meld inputs [
  ./acs-packages.nix
  ./acs-shell.nix
  ./acs-ssh.nix
  ./bluetooth-applet.nix
  ./configurations.nix
  ./darwin-permissions.nix
  ./ghostty.nix
  ./gnome-keyring.nix
  ./gpg-agent.nix
  ./gui-apps.nix
  ./minecraft-client.nix
  ./network-manager-applet.nix
  ./opencode.nix
  ./packages.nix
  ./preamble.nix
  ./shell.nix
  ./spotify-player.nix
  ./ssh.nix
]
