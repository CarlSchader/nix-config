{ ... }:
{
  nixosModules.gnome = { pkgs, ... }:
  {
    services.displayManager.gdm.enable = true;
    services.displayManager.gdm.wayland = true;
    services.desktopManager.gnome.enable = true;

    # To disable installing GNOME's suite of applications
    # and only be left with GNOME shell.
    services.gnome.core-apps.enable = false;
    services.gnome.core-developer-tools.enable = false;
    services.gnome.games.enable = false;
    environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];

    # Tell electron apps to use the Wayland backend
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    xdg.portal = {
      enable = true;
      wlr.enable = true; # Necessary for sway
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
  };
}
