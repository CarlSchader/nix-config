{ ... }:
{
  nixosModules.sway =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        grim
        slurp
        wl-clipboard
        mako
        wdisplays
      ];

      services.gnome.gnome-keyring = {
        enable = true;
      };

      security.pam.services.gdm.enableGnomeKeyring = true;

      programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        extraOptions = [ "--unsupported-gpu" ];
      };
    };
}
