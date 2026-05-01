{ ... }:
{
  homeModules.bluetooth =
    { ... }:
    {
      services.blueman-applet = {
        enable = true;
      };

      services.mpris-proxy = {
        enable = true;
      };
    };
}
