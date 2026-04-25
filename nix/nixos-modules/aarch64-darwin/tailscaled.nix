{ ... }:
{
  nixosModules.tailscaled-darwin =
    { ... }:
    {
      services.tailscale.enable = true;
    };
}
