{...}: let
  keys = import ../nix/lib/keys.nix;
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
        "github.com" = {
          HostName = "github.com";
          ControlMaster = "auto";
          ControlPath = "~/.ssh/sockets/%r@%n-%p";
          ControlPersist = "1h";
          User = "git";
        };
        "desktop-cisco" = {
          HostName = "10.0.20.145";
          User = "carl";
          ControlMaster = "auto";
          ControlPath = "~/.ssh/sockets/%r@%n-%p";
          ControlPersist = "1h";
          ForwardAgent = true;
          ForwardX11Trusted = true;
          ForwardX11 = true;
          # identityFile = "~/.ssh/id_ed25519";
        };
        "bastion" = {
          HostName = "ec2-18-217-235-120.us-east-2.compute.amazonaws.com";
          User = "ec2-user";
        };
        "desktop-ts" = {
          HostName = "100.64.0.18";
          User = "carl";
          ControlMaster = "auto";
          ControlPath = "~/.ssh/sockets/%r@%n-%p";
          ControlPersist = "1h";
          ForwardAgent = true;
          ForwardX11Trusted = true;
          ForwardX11 = true;
          Compression = true;
          # identityFile = "~/.ssh/id_ed25519";
        };
        "dell-xps" = {
          User = "carl";
          HostName = "100.64.0.20";
          ControlMaster = "auto";
          ControlPath = "~/.ssh/sockets/%r@%n-%p";
          ControlPersist = "1h";
          ForwardAgent = true;
          ForwardX11 = true;
          ForwardX11Trusted = true;
        };
        "rtx4090-tower" = {
          ControlMaster = "auto";
          ControlPath = "~/.ssh/sockets/%r@%n-%p";
          ControlPersist = "1h";
          HostName = "100.64.0.22";
          ForwardAgent = true;
          ForwardX11Trusted = true;
          ForwardX11 = true;
        };
      };
    };

    home.file.".ssh/sockets/.keep".text = "";

    home.packages = [pkgs.x11_ssh_askpass];

    home.sessionVariables = {
      SSH_ASKPASS = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";
      # Often needed to trigger the popup correctly in headless-ish environments
      SSH_ASKPASS_REQUIRE = "prefer";
      XAUTHORITY = "$HOME/.Xauthority";
    };

    home.file.".ssh/authorized_keys" = {
      text = lib.concatStringsSep "\n" (keys.carl ++ keys.acs);
    };
  };
}
