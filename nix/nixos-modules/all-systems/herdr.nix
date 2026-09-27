{ ... }:
{
  nixosModules.herdr =
    { pkgs, ... }:
    {
      # The listen address (0.0.0.0) lives in the home-managed
      # ~/.config/herdr/config.toml — see herdr/home-modules.nix (Linux-only
      # `server` block). programs.herdr is a home-manager option, not NixOS.
      #
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
