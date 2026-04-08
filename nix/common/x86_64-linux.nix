{
  nixpkgs,
  refresh-auth-sock,
  # cococrawl,
  ...
}:
let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
in
{
  common.${system} = {
    user-packages = with pkgs; [
      refresh-auth-sock.packages.${system}.default
      # cococrawl.packages.${system}.default
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
