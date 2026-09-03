{...}: {
  homeModules.network-manager-applet = {pkgs, ...}: {
    services.network-manager-applet.enable = true;

    home.packages = with pkgs; [networkmanagerapplet];
  };
}
