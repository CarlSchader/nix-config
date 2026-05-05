{ ... }:
let
  matchBlocks = {
    "*" = {
      controlMaster = "auto";
      controlPath = "~/.ssh/sockets/%r@%h-%p";
      controlPersist = "1h";
      extraOptions = {
        IgnoreUnknown = "GSSAPIAuthentication,GSSAPIDelegateCredentials";
      };
    };
    "desktop-cisco" = {
      hostname = "10.0.20.145";
      user = "carl";
      forwardAgent = true;
      forwardX11 = true;
      # identityFile = "~/.ssh/id_ed25519";
    };
    "desktop-ts" = {
      hostname = "100.64.0.18";
      user = "carl";
      forwardAgent = true;
      forwardX11 = true;
      # identityFile = "~/.ssh/id_ed25519";
    };
    "ml-pc" = {
      hostname = "100.64.0.5";
      user = "carl";
      forwardAgent = true;
      forwardX11 = true;
      # identityFile = "~/.ssh/id_ed25519_sk_rk";
    };
  };
in
{
  homeModules.acs-ssh =
    { pkgs, ... }:
    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        inherit matchBlocks;
      };

      home.file.".ssh/sockets/.keep".text = "";

      home.packages = [ pkgs.x11_ssh_askpass ];

      home.sessionVariables = {
        SSH_ASKPASS = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";
        # Often needed to trigger the popup correctly in headless-ish environments
        SSH_ASKPASS_REQUIRE = "prefer";
      };
    };
}
