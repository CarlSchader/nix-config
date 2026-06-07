{...}: {
  homeModules.ssh = {pkgs, ...}: {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          ControlMaster = "auto";
          ControlPath = "~/.ssh/sockets/%r@%n-%p";
          ControlPersist = "1h";
        };
        "ml-pc" = {
          HostName = "ml-pc";
          User = "carl";
          ForwardAgent = true;
          ForwardX11 = true;
        };
        "macbook-pro-m1" = {
          Hostname = "macbook-pro-m1";
          User = "carlschader";
          ForwardAgent = true;
          ForwardX11 = true;
        };
        "linode-headscale" = {
          HostName = "198.58.104.63";
          User = "root";
          ForwardAgent = true;
          ForwardX11 = true;
        };
        "ampere-a1" = {
          HostName = "129.153.207.106";
          User = "carl";
          ForwardAgent = true;
          ForwardX11 = true;
        };
        "remarkable" = {
          HostName = "192.168.0.106";
          User = "root";
          ForwardAgent = true;
          ForwardX11 = true;
        };
        "conifer-pi" = {
          HostName = "conifer-pi";
          User = "carl";
          ForwardAgent = true;
          ForwardX11 = true;
        };
        "rpi*" = {
          User = "pi";
          ForwardAgent = true;
          ForwardX11 = true;
        };
        "github-acs" = {
          HostName = "github.com";
          User = "git";
          IdentityFile = "~/.ssh/acs";
          IdentitiesOnly = true;
        };
        "acs-desktop" = {
          HostName = "acs-desktop";
          User = "carl";
          IdentityFile = "~/.ssh/acs";
          ForwardAgent = true;
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
    };
  };
}
