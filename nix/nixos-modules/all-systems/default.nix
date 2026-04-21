{ flake-utils, ... }@inputs:
flake-utils.lib.meld inputs [
  ./bluetooth.nix
  ./dockerd.nix
  ./download-buffer.nix
  ./experimental-featurs.nix
  ./git-server.nix
  ./gnome.nix
  ./greetd.nix
  ./kanshi.nix
  ./nginx-reverse-proxy.nix
  ./nix-ld.nix
  ./openssh.nix
  ./parallelism.nix
  ./polkit.nix
  ./rust-overlay-module.nix
  ./swap-file.nix
  ./sway.nix
  ./tailscaled.nix
  ./thunderbolt.nix
  ./xrdp-gnome.nix
  ./yubikey.nix
]
