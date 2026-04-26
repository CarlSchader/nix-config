{
  self,
  nixpkgs,
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
      ./disko-config.nix

      self.nixosModules.x86_64-linux-system-packages
      self.nixosModules.bluetooth
      self.nixosModules.download-buffer
      self.nixosModules.experimental-features
      self.nixosModules.git-server
      # self.nixosModules.gnome
      self.nixosModules.greetd
      self.nixosModules.nix-ld
      self.nixosModules.openssh
      self.nixosModules.parallelism
      self.nixosModules.polkit
      self.nixosModules.swap-file
      self.nixosModules.sway
      self.nixosModules.tailscaled
      self.nixosModules.thunderbolt
      # self.nixosModules.xrdp-gnome
      self.nixosModules.yubikey

      self.nixosModules."${system}-carl-user"
      # self.nixosModules."${system}-openclaw-user"
    ];
  };
}
