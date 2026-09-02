{
  self,
  nixpkgs,
  ...
}: let
  system = "x86_64-linux";
in {
  nixosConfigurations.x1-carbon = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ./configuration.nix
      ./hardware-configuration.nix

      self.nixosModules.x86_64-linux-system-packages
      self.nixosModules.aarch64-linux-builders
      self.nixosModules.bluetooth
      self.nixosModules.download-buffer
      self.nixosModules.experimental-features
      self.nixosModules.greetd
      self.nixosModules.nix-ld
      self.nixosModules.openssh
      self.nixosModules.parallelism
      self.nixosModules.polkit
      self.nixosModules.sway
      self.nixosModules.tailscaled
      self.nixosModules.thunderbolt
      self.nixosModules.yubikey
      self.nixosModules."${system}-carl-user"
    ];
  };
}
