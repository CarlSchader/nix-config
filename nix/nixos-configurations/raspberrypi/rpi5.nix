{
  self,
  nixpkgs,
  nixos-raspberrypi,
  ...
}:
let
  system = "aarch64-linux";

  modules = [
    {
      imports = with nixos-raspberrypi.nixosModules; [
        raspberry-pi-5.base
        raspberry-pi-5.page-size-16k
        raspberry-pi-5.display-vc4
        # usb-gadget-ethernet # for usb emulation over ethernet (all boards)
      ];
    }
    # self.nixosModules.x86_64-linux-system-packages
    # self.nixosModules.bluetooth
    # self.nixosModules.experimental-features
    # self.nixosModules.git-server
    # # self.nixosModules.gnome
    # self.nixosModules.greetd
    # self.nixosModules.carls-ml-pc-motd
    # self.nixosModules.nix-ld
    # self.nixosModules.openssh
    # self.nixosModules.parallelism
    # self.nixosModules.polkit
    # self.nixosModules.swap-file
    # self.nixosModules.sway
    # self.nixosModules.tailscaled
    # self.nixosModules.thunderbolt
    # # self.nixosModules.xrdp-gnome
    # self.nixosModules.yubikey
    #
    # self.nixosModules."${system}-carl-user"
    # # self.nixosModules."${system}-openclaw-user"

    (
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        networking.hostName = "rpi5";

        system.nixos.tags =
          let
            cfg = config.boot.loader.raspberry-pi;
          in
          [
            "raspberry-pi-${cfg.variant}"
            cfg.bootloader
            config.boot.kernelPackages.kernel.version
          ];
      }
    )
  ];
in
{
  # To build a micro SD card image run:
  # nix build .#nixosConfigurations.rpi5-installer.config.system.build.sdImage
  #
  # Then just use dd to flash the sd card
  nixosConfigurations.rpi5-installer = nixos-raspberrypi.lib.nixosInstaller {
    inherit system;
    inherit modules;
  };

  nixosConfigurations.rpi5 = nixos-raspberrypi.lib.nixosSystem {
    inherit system;
    inherit modules;
  };
}
