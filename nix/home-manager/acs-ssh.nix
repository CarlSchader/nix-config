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
    { ... }:
    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        inherit matchBlocks;
      };
    };
}
