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

      home.sessionVariables = {
        SSH_ASKPASS = "${pkgs.pkgs.x11_ssh_askpass}/bin/lxqt-openssh-askpass";
        # Often needed to trigger the popup correctly in headless-ish environments
        SSH_ASKPASS_REQUIRE = "prefer";
      };
    };
}
