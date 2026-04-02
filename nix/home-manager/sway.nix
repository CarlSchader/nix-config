{ ... }: 
{
  homeModules.sway = { pkgs, ... }:
  {
		programs.ghostty.enable = true;
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraOptions = [ "--unsupported-gpu" ];
      config = {
        modifier = "Mod4";
        terminal = "ghostty";
        menu = "${pkgs.wofi}/bin/wofi --show drun";
        startup = [
          { command = "dbus-update-activation-environment --systemd GNOME_KEYRING_CONTROL=/run/user/$(id -u)/keyring"; }
        ];
      };
    };
  };
}
