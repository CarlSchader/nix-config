{ ... }:
{
  nixosModules.swap-file =
    { ... }:
    let
      # The size of the swap file in MiB.
      swapFileSize = 8 * 1024;
    in
    {
      swapDevices = [ { device = "/var/lib/swapfile"; size = swapFileSize; } ];
    };
}
