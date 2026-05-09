{
  pkgs,
  config,
  lib,
  ...
}:
let
  mod = config.wayland.windowManager.sway.config.modifier;
in
{
  modifier = "Mod4";
  terminal = "wezterm-gl";
  menu = "${pkgs.wofi}/bin/wofi --show drun";
  bars = [
    {
      position = "bottom";
      statusCommand = "${pkgs.i3status}/bin/i3status";
      trayOutput = "*";
    }
  ];
  startup = [
    {
      command = "dbus-update-activation-environment --systemd PATH=$HOME/.nix-profile/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin GNOME_KEYRING_CONTROL=/run/user/$(id -u)/keyring";
    }
  ];
  keybindings = lib.mkOptionDefault {
    "${mod}+ctrl+2" = "resize set width 50 ppt";
    "${mod}+ctrl+3" = "resize set width 33 ppt";
    "${mod}+ctrl+4" = "resize set width 25 ppt";
    "${mod}+ctrl+5" = "resize set width 20 ppt";
  };
}
