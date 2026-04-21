{ ... }:
{
  nixosModules.bluetooth =
    { ... }:
    {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Enable = "Source,Sink,Media,Socket";
            # Shows battery charge of connected devices on supported
            # Bluetooth adapters. Defaults to 'false'.
            Experimental = true;
            # When enabled other devices can connect faster to us, however
            # the tradeoff is increased power consumption. Defaults to
            # 'false'.
            FastConnectable = true;

            # ControllerMode tells the Bluetooth adapter which Bluetooth version to use. The default is 'dual', which means that the adapter will use both Bluetooth Low Energy (BLE) and Bluetooth Basic Rate/Enhanced Data Rate (BR/EDR) modes. Setting it to 'bredr' will disable BLE and only use BR/EDR mode, which may be necessary for compatibility with certain devices that do not support BLE. However, it may also result in increased power consumption.
            ControllerMode = "dual"; # Airpods require bredr
          };
          Policy = {
            # Enable all controllers when they are found. This includes
            # adapters present on start as well as adapters that are plugged
            # in later on. Defaults to 'true'.
            AutoEnable = true;
          };
        };
      };

      services.blueman.enable = true;
    };
}
