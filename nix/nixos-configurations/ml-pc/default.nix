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
      self.nixosModules.tailscaled
      self.nixosModules.thunderbolt
      # self.nixosModules.xrdp-gnome

      self.nixosModules."${system}-carl-user"

      (self.nixosModules.sway-home-manager-nixos [ "carl" ])

      # # megaborg modules
      # sops-nix.nixosModules.sops {
      #   sops.defaultSopsFile = ../../../secrets/secrets.env;
      #   sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      #   sops.age.generateKey = true;
      #   sops.secrets."megaborg-env" = {
      #     format = "dotenv";
      #     owner = "root";
      #   };
      # }
      #
      # self.nixosModules.docsd {
      #   services.docsd = {
      #     enable = true;
      #     hostname = "0.0.0.0";
      #     port = "3000";
      #   };
      # }
      #
      # coco-label-tool.nixosModules.service ({ config, ... }: {
      #   services.coco-label-tool.merl-label-server = {
      #     enable = true;
      #     coco-file = "s3://merl-datalake/phone-camera-coco/dataset.json";
      #     host = "0.0.0.0";
      #     port = "8000";
      #     environment-file = config.sops.secrets."megaborg-env".path;
      #   };
      # })
    ];
  };
}
