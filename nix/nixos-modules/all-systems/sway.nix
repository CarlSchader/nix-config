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

      services.gnome.gnome-keyring.enable = true;

      programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
      };

      # programs.regreet.enable = true;

      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd 'sway --unsupported-gpu'";
            user = "greeter";
          };
        };
      };
    };
}
