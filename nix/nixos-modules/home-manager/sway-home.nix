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
          startup = [
            { command = "dbus-update-activation-environment --systemd GNOME_KEYRING_CONTROL=/run/user/$(id -u)/keyring"; }
          ];
        };
      };
    };
}
