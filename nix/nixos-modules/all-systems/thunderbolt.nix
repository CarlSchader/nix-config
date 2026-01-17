{ ... }:
{
  nixosModules.thunderbolt =
    { ... }:
    {
      services.hardware.bolt.enable = true;
    };
}
