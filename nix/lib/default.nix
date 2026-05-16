{ ... }:
let
  system = "x86_64-linux";
in
{
  nvidia-drivers."${system}" = import ./nvidia-drivers.nix;
  ssh-keys = import ./keys.nix;
}
