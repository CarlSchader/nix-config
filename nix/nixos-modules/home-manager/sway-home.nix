{ ... }:
{
  nixosModules.sway-home =
    { pkgs, ... }:
    {
      wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        extraOptions = [ "--unsupported-gpu" ];
        config = {
          modifier = "Mod4";
          terminal = "wezterm";
          menu = "${pkgs.wofi}/bin/wofi --show drun";
        };
      };
    };
}
