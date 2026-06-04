{...}: {
  homeModules.bluetooth-applet = {pkgs, ...}: {
    services.blueman-applet = {
      enable = true;
    };

    services.mpris-proxy = {
      enable = true;
    };

    home.packages = with pkgs; [blueman];
  };
}
