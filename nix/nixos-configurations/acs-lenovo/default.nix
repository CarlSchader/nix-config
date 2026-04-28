{
  self,
  nixpkgs,
  ...
}:
let
  system = "x86_64-linux";
in
{
  nixosConfigurations.acs-lenovo = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ./configuration.nix
      ./hardware-configuration.nix

      self.nixosModules.x86_64-linux-system-packages
      self.nixosModules.bluetooth
      self.nixosModules.download-buffer
      self.nixosModules.experimental-features

      # self.nixosModules.gnome
      self.nixosModules.greetd
      self.nixosModules.nix-ld
      self.nixosModules.parallelism
      self.nixosModules.polkit
      self.nixosModules.sway
      self.nixosModules.thunderbolt
      # self.nixosModules.xrdp-gnome
      self.nixosModules.yubikey

      self.nixosModules."${system}-carl-user"
    ];
  };
}
