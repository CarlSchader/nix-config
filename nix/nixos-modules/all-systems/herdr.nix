{ ... }:
{
  nixosModules.herdr =
    { pkgs, ... }:
    {
      # Inject a [server] section into the home-managed
      # ~/.config/herdr/config.toml. home-manager deep-merges this with the
      # client settings defined in herdr/home-modules.nix, so those are preserved.
      programs.herdr.settings = {
        server = {
          listen_address = "0.0.0.0";
        };
      };

      # Headless Herdr server as a system service:
      #   - starts at boot (no user session / auto-login needed)
      #   - runs as carl so it reads the same $HOME/.config/herdr/config.toml
      #     and $HOME/.local/state/herdr as the client
      systemd.services.herdr-server = {
        description = "Herdr server";
        wantedBy = [ "multi-user.target" ];
        after = [ "network-online.target" "tailscaled.service" ];
        wants = [ "network-online.target" "tailscaled.service" ];

        environment = {
          HOME = "/home/carl";
          XDG_CONFIG_HOME = "/home/carl/.config";
          XDG_STATE_HOME = "/home/carl/.local/state";
        };

        serviceConfig = {
          User = "carl";
          Group = "users";
          ExecStart = "${pkgs.herdr}/bin/herdr server";
          Restart = "on-failure";
          RestartSec = 5;
        };
      };
    };
}
