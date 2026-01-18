{ ... }:
{
  nixosModules.greetd =
    { pkgs, ... }:
    {
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
