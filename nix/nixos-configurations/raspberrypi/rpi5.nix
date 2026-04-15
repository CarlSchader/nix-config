{
  self,
  nixpkgs,
  nixos-raspberry-pi,
  ...
}:
let
  system = "aarch64-linux";

  pi5-modules = [
    {
      imports = with nixos-raspberry-pi.nixosModules; [
        raspberry-pi-5.base
        raspberry-pi-5.page-size-16k
        raspberry-pi-5.display-vc4
        usb-gadget-ethernet # for usb emulation over ethernet (all boards)
      ];
    }

    (
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        networking.hostName = "rpi5";

        # Allocate more ram for initd, otherwise it will fail when trying to put in nixos modules in RAM. Not sure why the raspberry-pi nixos people haven't dealt with this.
        boot.kernelParams = [ "ramdisk_size=131072" ];

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
  # sudo nix build .#nixosConfigurations.rpi5-installer.config.system.build.sdImage
  # (sudo may be needed on ml-pc to use QEMU)
  #
  # Then just use dd to flash the sd card
  # sudo zstdcat result/sd-image/*.img.zst | sudo dd of=/dev/sdX bs=1M status=progress && sync
  nixosConfigurations.rpi5-installer = nixos-raspberry-pi.lib.nixosInstaller {
    inherit system;
    modules = pi5-modules;
  };

  nixosConfigurations.rpi5 = nixos-raspberry-pi.lib.nixosSystem {
    inherit system;
    modules = pi5-modules;
  };
}
