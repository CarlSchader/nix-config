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
  # terminal = "ghostty";
  terminal = "wezterm";
  menu = "${pkgs.wofi}/bin/wofi --show drun";
  startup = [
    {
      command = "dbus-update-activation-environment --systemd GNOME_KEYRING_CONTROL=/run/user/$(id -u)/keyring";
    }
  ];
  keybindings = lib.mkOptionDefault {
    "${mod}+ctrl+2" = "resize set width 50 ppt";
    "${mod}+ctrl+3" = "resize set width 33 ppt";
    "${mod}+ctrl+4" = "resize set width 25 ppt";
    "${mod}+ctrl+5" = "resize set width 20 ppt";

    # Volume
    "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume raise";
    "XF86AudioLowerVolume" = "exec swayosd-client --output-volume lower";
    "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
    "XF86AudioMicMute" = "exec swayosd-client --input-volume mute-toggle";

    # Brightness
    "XF86MonBrightnessUp" = "exec swayosd-client --brightness raise";
    "XF86MonBrightnessDown" = "exec swayosd-client --brightness lower";

    # Media
    "XF86AudioPlay" = "exec playerctl play-pause";
    "XF86AudioNext" = "exec playerctl next";
    "XF86AudioPrev" = "exec playerctl previous";
  };
}
