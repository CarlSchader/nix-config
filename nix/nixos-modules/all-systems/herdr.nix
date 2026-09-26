{ pkgs, ... }:
{
  # Inject a [server] section into the home-managed
  # ~/.config/herdr/config.toml. home-manager deep-merges this with the
  # client settings defined in the home module (herdr/home-modules.nix),
  # so those are preserved.
  programs.herdr.settings = {
    server = {
      listen_address = "0.0.0.0";
      # listen_port = 1473;   # herdr's default — uncomment to pin it explicitly
    };
  };

  # Headless Herdr server as a system service:
  #   - starts at boot (WantedBy = multi-user.target)
  #   - runs as the local user (carl) so it reads the same
  #     $HOME/.config/herdr/config.toml and $HOME/.local/state/herdr as the client
  systemd.services.herdr-server = {
    WantedBy = "multi-user.target";
    After  = [ "network-online.target" "tailscale.service" ];
    Wants  = [ "tailscale.service" ];
    User   = "carl";
    ExecStart = "${pkgs.herdr}/bin/herdr server";
    Environment = [
      "HOME=/home/carl"
      "XDG_CONFIG_HOME=/home/carl/.config"
      "XDG_STATE_HOME=/home/carl/.local/state"
    ];
  };
}
