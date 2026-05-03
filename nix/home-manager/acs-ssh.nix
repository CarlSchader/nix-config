{ ... }:
let
  matchBlocks = {
    "*" = {
      extraOptions = {
        IgnoreUnknown = "GSSAPIAuthentication,GSSAPIDelegateCredentials";
      };
    };
    "acs-desktop" = {
      hostname = "10.0.20.145";
      user = "carl";
      forwardAgent = true;
      forwardX11 = true;
      identityFile = "~/.ssh/id_ed25519";
    };
    "ml-pc" = {
      hostname = "ml-pc";
      user = "carl";
      forwardAgent = true;
      forwardX11 = true;
      identityFile = "~/.ssh/id_ed25519_sk_rk";
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

      home.packages = [ pkgs.x11_ssh_askpass ];

      home.sessionVariables = {
        SSH_ASKPASS = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";
        # Often needed to trigger the popup correctly in headless-ish environments
        SSH_ASKPASS_REQUIRE = "prefer";
      };
    };
}
