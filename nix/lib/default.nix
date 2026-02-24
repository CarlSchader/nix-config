{ nixpkgs, ... }:
let
  system = "x86_64-linux"; 
  pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; }; };
in 
{
  nvidia-drivers."${system}" = import ./nvidia-drivers.nix;
}
