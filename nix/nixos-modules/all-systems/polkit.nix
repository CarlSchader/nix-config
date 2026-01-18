{ ... }:
{
  nixosModules.polkit =
    { ... }:
    {
      security.polkit.enable = true;
    };
}
