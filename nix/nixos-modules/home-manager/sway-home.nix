{ ... }:
{
  nixosModules.sway-home =
    { ... }:
    {
      wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        config = {
          modifier = "Mod4";
          terminal = "wezterm";
        };
      };
    };
}
