{nixpkgs, ...}: let
  system = "aarch64-darwin";

  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
in {
  common.${system} = {
    user-packages = [
      pkgs.tailscale
      pkgs.darwin.binutils
      pkgs.home-manager
      # pkgs.darwin.PowerManagement
    ];

    system-packages = with pkgs; [
      vim
      git
      htop
    ];
  };
}
