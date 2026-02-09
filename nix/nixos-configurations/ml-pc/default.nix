{
  self,
  nixpkgs,
  ...
}:
let
  system = "x86_64-linux";
in
{
  nixosConfigurations.ml-pc = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ./configuration.nix
      ./hardware-configuration.nix

      self.nixosModules.x86_64-linux-system-packages
      self.nixosModules.bluetooth
      self.nixosModules.experimental-features
      self.nixosModules.git-server
      self.nixosModules.git-shared-server
      # self.nixosModules.gnome
      self.nixosModules.greetd
      self.nixosModules.carls-ml-pc-motd
      self.nixosModules.nix-ld
      self.nixosModules.openssh
      self.nixosModules.parallelism
      self.nixosModules.polkit
      self.nixosModules.swap-file
      self.nixosModules.tailscaled
      self.nixosModules.thunderbolt
      # self.nixosModules.xrdp-gnome
      self.nixosModules.yubikey

      self.nixosModules."${system}-carl-user"
      (self.nixosModules.sway-home-manager-nixos [ "carl" ])

      self.nixosModules."${system}-openclaw-user"
      (self.nixosModules.sway-home-manager-nixos [ "openclaw" ])
    ];
  };
}
