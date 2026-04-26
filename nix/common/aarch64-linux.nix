{
  nixpkgs,
  ...
}:
let
  system = "aarch64-linux";

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
      tailscale
      binutils
      home-manager
    ];

    system-packages = with pkgs; [
      vim
      git
      htop
      icu
      pciutils
      dmidecode
    ];
  };
}
