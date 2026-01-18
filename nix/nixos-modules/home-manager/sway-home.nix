{ ... }:
{
  nixosModules.sway-home =
    { ... }:
    {
      wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        extraOptions = [ "--unsupported-gpu" ];
        config = {
          modifier = "Mod4";
          terminal = "wezterm";
        };
      };
    };
}
