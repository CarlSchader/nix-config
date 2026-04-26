{
  self,
  nixpkgs,
  disko,
  ...
}:
let
  system = "aarch64-linux";
in
{
  nixosConfigurations.ampere-a1 = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ./configuration.nix
      ./hardware-configuration.nix

      disko.nixosModules.disko
      ./disko-config.nix

      self.nixosModules.aarch64-linux-system-packages
      self.nixosModules.download-buffer
      self.nixosModules.experimental-features
      self.nixosModules.nix-ld
      self.nixosModules.openssh
      self.nixosModules.parallelism
      self.nixosModules.tailscaled

      self.nixosModules."${system}-carl-user"
    ];
  };
}
