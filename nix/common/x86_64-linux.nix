{nixpkgs, ...}: let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
in {
  common.${system} = {
    user-packages = with pkgs; [
      tailscale
      binutils
      home-manager
      spotify
    ];

    system-packages = with pkgs; [
      vim
      git
      dmidecode
      linuxPackages.v4l2loopback
      v4l-utils
      htop
      wl-clipboard
      xclip
      icu
      pciutils
    ];
  };
}
