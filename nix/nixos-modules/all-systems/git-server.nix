{ ... }:
{
  nixosModules.git-server =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      cfg = config.services.git-server;
    in
    {
      options.services.git-server = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether to enable the git server.";
        };

        ssh-keys = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "List of SSH public keys to allow for the git user.";
        };
      };

      config = lib.mkIf cfg.enable {
        # Git server
        users.users.git = {
          isSystemUser = true;
          group = "git";
          home = "/var/lib/git-server";
          createHome = true;
          shell = "${pkgs.git}/bin/git-shell";
          openssh.authorizedKeys.keys = cfg.ssh-keys;
        };

        users.groups.git = { };

        services.openssh.extraConfig = ''
          Match user git
            AllowTcpForwarding no
            AllowAgentForwarding no
            PasswordAuthentication no
            PermitTTY no
            X11Forwarding no
        '';
      };
    };
}
