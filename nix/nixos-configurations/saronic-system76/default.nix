{
  self,
  nixpkgs,
  ...
}:
let
  system = "x86_64-linux";
in
{
  nixosConfigurations."carls-system76" = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ./configuration.nix
      ./hardware-configuration.nix

      self.nixosModules.x86_64-linux-system-packages
      self.nixosModules.bluetooth
      self.nixosModules.experimental-features
      self.nixosModules.greetd
      self.nixosModules.nix-ld
      self.nixosModules.openssh
      self.nixosModules.parallelism
      self.nixosModules.polkit
      self.nixosModules.saronic-builders
      self.nixosModules.tailscaled
      self.nixosModules.thunderbolt

      self.nixosModules."${system}-saronic-user"

      (self.nixosModules.saronic-sway-home-manager-nixos [ "saronic" ])
    ];
  };
}
