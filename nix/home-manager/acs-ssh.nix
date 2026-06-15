{...}: let
  keys = import ../lib/keys.nix;
in {
  homeModules.acs-ssh = {
    pkgs,
    lib,
    ...
  }: {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "desktop-cisco" = {
          HostName = "10.0.20.145";
          User = "carl";
          ForwardAgent = true;
          ForwardX11Trusted = true;
          # identityFile = "~/.ssh/id_ed25519";
        };
        "desktop-ts" = {
          HostName = "100.64.0.18";
          User = "carl";
          ForwardAgent = true;
          ForwardX11Trusted = true;
          # identityFile = "~/.ssh/id_ed25519";
        };
        "ml-pc" = {
          HostName = "100.64.0.5";
          ForwardAgent = true;
          ForwardX11Trusted = true;
        };
      };
    };

    # home.file.".ssh/sockets/.keep".text = "";

    home.packages = [pkgs.x11_ssh_askpass];

    home.sessionVariables = {
      SSH_ASKPASS = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";
      # Often needed to trigger the popup correctly in headless-ish environments
      SSH_ASKPASS_REQUIRE = "prefer";
    };

    home.file.".ssh/authorized_keys" = {
      text = lib.concatStringsSep "\n" (keys.carl ++ keys.acs);
    };
  };
}
