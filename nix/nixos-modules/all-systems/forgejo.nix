# Generic Forgejo (self-hosted git forge) module.
# Base settings follow https://wiki.nixos.org/wiki/Forgejo.
#
# Per-machine: just set `forgejo.enable` (and optionally override the
# machine-specific bits below). `domain` defaults to the hostname, so a bare
# `forgejo.enable = true;` works out of the box.
{ ... }:
{
  nixosModules.forgejo =
    { lib, config, ... }:
    let
      cfg = config.forgejo;
    in
    {
      options.forgejo = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether to run a Forgejo instance.";
        };

        domain = lib.mkOption {
          type = lib.types.str;
          default = config.networking.hostName;
          description = "Server domain name (Forgejo `DOMAIN`).";
        };

        rootUrl = lib.mkOption {
          type = lib.types.str;
          default = "https://${config.forgejo.domain}/";
          description = "Public URL of the instance (Forgejo `ROOT_URL`). Set this to drop the port from web-UI URLs when serving through a reverse proxy.";
        };

        httpPort = lib.mkOption {
          type = lib.types.port;
          default = 3000;
          description = "Port Forgejo listens on for HTTP.";
        };

        allowRegistration = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Allow new-account registration. Keep open only until the admin account is created, then set to false.";
        };

        settings = lib.mkOption {
          type = lib.types.attrs;
          default = { };
          description = "Extra/override services.forgejo.settings; deep-merged on top of the derived defaults (your values win).";
        };
      };

      config = lib.mkIf cfg.enable {
        services.forgejo = {
          enable = true;
          database.type = "postgres";
          # Enable support for Git Large File Storage
          # lfs.enable = true;
          settings = lib.recursiveUpdate {
            server = {
              DOMAIN = cfg.domain;
              # You need to specify this to remove the port from URLs in the web UI.
              ROOT_URL = cfg.rootUrl;
              HTTP_PORT = cfg.httpPort;
              SSH_PORT = lib.head config.services.openssh.ports;
            };
            # Sending emails is optional; you can send a test email from the web UI at:
            # Profile Picture > Site Administration > Configuration > Mailer Configuration
            # mailer = {
            #   ENABLED = true;
            #   SMTP_ADDR = "mail.example.com";
            #   FROM = "noreply@${cfg.domain}";
            #   USER = "noreply@${cfg.domain}";
            # };
            # secrets = { mailer.PASSWD = config.age.secrets.forgejo-mailer-password.path; };
            service.DISABLE_REGISTRATION = !cfg.allowRegistration;
            # Add support for actions, based on act: https://github.com/nektos/act
            actions = {
              ENABLED = true;
              DEFAULT_ACTIONS_URL = "github";
            };
          } cfg.settings;
        };

        # Optional extras (enable per-machine as needed):
        # age.secrets.forgejo-mailer-password = {
        #   file = <path-to-secret>.age;
        #   mode = "400";
        #   owner = "forgejo";
        # };
        # services.nginx.virtualHosts."${cfg.domain}" = {
        #   forceSSL = true;
        #   enableACME = true;
        #   extraConfig = "client_max_body_size 512M;";
        #   locations."/".proxyPass = "http://localhost:${toString cfg.httpPort}";
        # };
      };
    };
}
