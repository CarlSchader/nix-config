{
  nixpkgs,
  refresh-auth-sock,
  cococrawl,
  ...
}:
let
  system = "aarch64-darwin";

  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
in
{
  common.${system} = {
    user-packages = [
      refresh-auth-sock.packages.${system}.default
      cococrawl.packages.${system}.default
      pkgs.tailscale
      pkgs.darwin.binutils
    ];

    system-packages = with pkgs; [
      vim
      git
      htop
    ];
  };
}
