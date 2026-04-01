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

      services.greetd = {
        enable = true;
        settings = rec {
          initial_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --time";
            user = "greeter";
          };
          default_session = initial_session;
        };
      };
    };
}
